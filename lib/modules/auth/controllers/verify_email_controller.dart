

import 'dart:async';

import 'package:get/get.dart';
import 'package:foodieyou/data/auth_repository/auth_repo.dart';
import 'package:foodieyou/modules/layout/bindings/bindings.dart';
import 'package:foodieyou/modules/layout/views/layout.dart';
import 'package:flutter/material.dart';

class VerifyEmailController extends GetxController {

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isEmailVerified=AuthenticationRepository.instance.firebaseUser.value!.emailVerified;
    if(!isEmailVerified){
      sendEmailVerification();
      timer=Timer.periodic(const Duration(seconds: 2), (timer) =>checkEmailVerified());
    }

}

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }

  Timer? timer;
  bool isEmailVerified=false;
  bool canResend=false;

Future checkEmailVerified () async{
  await AuthenticationRepository.instance.firebaseUser.value!.reload();
  isEmailVerified=AuthenticationRepository.instance.firebaseUser.value!.emailVerified;
  if(isEmailVerified){
    Get.offAll(const HomeLayOutScreen(),
        binding: LayOutBindings(), transition: Transition.rightToLeft);
    timer!.cancel();
  }

  update();
}
Duration countdownDuration = const Duration(seconds: 8);

  Future<void> sendEmailVerification () async{
    canResend=false;
    update();
    try{
      await AuthenticationRepository.instance.sendVerificationEmail();
    }catch(e){
      debugPrint(e.toString());
    }
    for ( countdownDuration=const Duration(seconds: 8); countdownDuration.inSeconds > 0; countdownDuration -= const Duration(seconds: 1)) {
      // Update UI with remaining time
      debugPrint('Time remaining until resend: ${countdownDuration.inSeconds} seconds');
      await Future.delayed(const Duration(seconds: 1));
      update();
    }
    countdownDuration=const Duration(seconds: 8);

    canResend=true;
    update();
  }

}
