import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:foodieyou/data/auth_repository/exceptions/signup_exception.dart';
import 'package:foodieyou/modules/auth/bindings/verify_email_bindings.dart';
import 'package:foodieyou/modules/auth/models/signup_model.dart';
import 'package:foodieyou/modules/auth/views/verify_email_screen.dart';
import 'package:foodieyou/modules/layout/bindings/bindings.dart';
import 'package:foodieyou/modules/layout/views/layout.dart';
import 'package:foodieyou/modules/location/controller/location_controller.dart';
import 'package:foodieyou/modules/on_boarding/bindings/bindings.dart';
import 'package:foodieyou/modules/on_boarding/views/on_boarding.dart';
import 'package:foodieyou/modules/orders_screen/controller/orders_controller.dart';
import 'package:foodieyou/modules/profile_screen/controllers/profile_controller.dart';
import 'package:foodieyou/modules/started_screen/started_screen.dart';
import 'package:foodieyou/shared/constants/constants.dart';
import 'package:foodieyou/shared/local/cache_helper.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  // RxString _verificationId = ''.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    firebaseUser = Rx<User?>(_auth.currentUser);

    firebaseUser.bindStream(_auth.userChanges());
  }

  void _setInitialScreen(Rx<User?> user) {
    if (user.value == null) {
      if (CacheHelper.getData(key: AppConstants.boardingScreen) != false) {
        Get.offAll(const OnBoardingScreen(), binding: MyBindings());
      } else {
        Get.offAll(const StartedScreen());
      }
    } else {
      AppConstants.uid = user.value!.uid;
      Get.offAll(const HomeLayOutScreen(),
          binding: LayOutBindings(), transition: Transition.rightToLeft);
    }
  }

  // Future<void> phoneAuthentication(String phone) async {
  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       verificationCompleted: (credential) async {
  //         await _auth.signInWithCredential(credential);
  //       },
  //       verificationFailed: (e) {
  //         debugPrint(e.toString());
  //       },
  //       codeSent: (verificationId, resendToken) {
  //         _verificationId.value = verificationId;
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) {
  //         _verificationId.value = verificationId;
  //       });
  // }

  Future<void> userCreate(
      {required email,
      required name,
      required phone,
      required uid,
      String? image}) async {
    SignUpModel model = SignUpModel(
      email: email,
      name: name,
      phone: phone,
      uid: uid,
      isEmailVerified: false,
      image: image ??
          "https://cdn-icons-png.flaticon.com/512/727/727399.png?w=740&t=st=1679753400~exp=1679754000~hmac=adf67891bf997c1bce60aad53598bc292eeaf6456fe99fdde4012e8dabd60e0d",
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {})
        .catchError((error) {
      debugPrint(error.toString());
    });
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name, String phone) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await userCreate(
            email: email, name: name, phone: phone, uid: value.user!.uid);
      });

      if (firebaseUser.value != null) {
        AppConstants.uid = firebaseUser.value!.uid;
        Get.offAll(const VerifyEmailScreen(),
            transition: Transition.rightToLeft, binding: VerifyEmailBindings());
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      debugPrint('FireBase AUTH EXCEPTION - ${ex.message}');
      debugPrint(e.toString());
      Get.snackbar("Authentication", ex.message, colorText: Colors.red);
    } catch (_) {
      final ex = SignUpFailure();
      debugPrint('EXCEPTION - ${ex.message}');
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (firebaseUser.value != null) {
        AppConstants.uid = firebaseUser.value!.uid;
        if (firebaseUser.value!.emailVerified) {
          Get.offAll(const HomeLayOutScreen(),
              binding: LayOutBindings(), transition: Transition.rightToLeft);
        } else {
          Get.offAll(const VerifyEmailScreen(),
              transition: Transition.rightToLeft,
              binding: VerifyEmailBindings());
        }
      } else {
        Get.offAll(const StartedScreen(), transition: Transition.leftToRight);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('EXCEPTION - ${e.message}');
    } catch (value) {
      debugPrint(value.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User cancelled the sign-in flow
        return;
      }
      // Obtain the auth details from the request
      final googleAuth = await googleUser.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential;
      userCredential = await _auth.signInWithCredential(credential);
      AppConstants.uid = userCredential.user!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get()
          .then((value) async {
        if (!value.exists) {
          await userCreate(
              email: userCredential.user!.email,
              name: userCredential.user!.displayName,
              phone: userCredential.user!.phoneNumber ?? "",
              image: userCredential.user!.photoURL,
              uid: userCredential.user!.uid);
        }
      });
      Get.offAll(const HomeLayOutScreen(),
          binding: LayOutBindings(), transition: Transition.rightToLeft);
    } on FirebaseAuthException catch (e) {
      debugPrint('EXCEPTION - ${e.message}');
    } catch (value) {
      debugPrint(value.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      Get.delete<ProfileController>(force: true);
      Get.delete<LocationController>(force: true);
      Get.delete<OrdersController>(force: true);
    } catch (e) {
      debugPrint(e.toString());
    }

    Get.offAll(const StartedScreen(), transition: Transition.rightToLeft);
  }

  Future<void> sendVerificationEmail() async {
    await firebaseUser.value!.sendEmailVerification();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint('Password reset email sent successfully');
    } catch (e) {
      debugPrint('Error sending password reset email: $e');
      Get.snackbar("'Error sending password reset email", e.toString(),
          colorText: Colors.red);
    }
  }
}
