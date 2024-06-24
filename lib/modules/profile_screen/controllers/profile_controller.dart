import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodieyou/modules/auth/models/signup_model.dart';
import 'package:foodieyou/modules/location/bindings/bindings.dart';
import 'package:foodieyou/modules/location/controller/location_controller.dart';
import 'package:foodieyou/shared/constants/constants.dart';
import 'package:path_provider/path_provider.dart';

class ProfileController extends GetxController{

  final name=TextEditingController();
  final email=TextEditingController();
  final phone=TextEditingController();
  String? nameValidator(String? value){
    if(value!.isEmpty||!RegExp(r"^[a-zA-Z '’]+$").hasMatch(value)){
      return "Enter correct name";
    }
    return null;
  }
  String? phoneValidator(String? value){
    if(value!.isEmpty || !RegExp(r'^(\+|00)([0-9]){1,3}(\s|\-)?([0-9]){3,14}$').hasMatch(value)){
      return "Enter correct phone number";
    }
    return null;
  }

  @override
  void onInit() async{
    super.onInit();
    await getUserData();
    LocationBindings().dependencies();
  }


  bool loadingData=false;
  SignUpModel? userModel;
Future<void> getUserData() async{
  loadingData=true;
  update();
  await FirebaseFirestore.instance
      .collection("users")
      .doc(AppConstants.uid)
      .get()
      .then((value) {
        userModel=SignUpModel.fromJson(value.data()!);
        name.text=userModel!.name;
        phone.text=userModel!.phone;
  })
      .catchError((error) {
    debugPrint(error.toString());
  });
  loadingData=false;
  update();
}

bool editingProfile=false;
void edit(){
  editingProfile=!editingProfile;
  if(editingProfile==false){
    name.text=userModel!.name;
    phone.text=userModel!.phone;
  }
  update();

}

bool loading=false;


  Future<void> updateUser()async{
  loading=true;
  userModel!.name=name.text;
  userModel!.phone=phone.text;
  userModel!.address=Get.find<LocationController>().addressModel;
  update();
  if(profileImage!=null) {
    await uploadProfileImage();
  }
  await FirebaseFirestore.instance
      .collection("users")
      .doc(AppConstants.uid)
      .update(userModel!.toMap())
      .then((value) {
    Get.snackbar("Update", "Your profile has been updated successfully",colorText:Colors.green);
  })
      .catchError((error) {
    debugPrint(error.toString());
  });
  loading=false;
  update();
}

  File? profileImage;
  Future getProfileImage() async {
    ImagePicker picker = ImagePicker();
      await picker.pickImage(source: ImageSource.gallery).then((value) {
        if(value!=null){
          profileImage = File(value.path);
          update();
        }
      }).catchError((error){
        debugPrint(error.toString());
      });

  }
  Future<File?> compressImage(File file) async {
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      String targetPath = "${appDocumentsDir.path}/compressed_image.jpg";
      File? result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 70,
      );
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
  String? profileImageUrl;
  Future uploadProfileImage() async {
    try {
      File? file = await compressImage(profileImage!);

      var storageReference = FirebaseStorage.instance
          .ref()
          .child('users/${AppConstants.uid}/profilePic.jpg}');

      var uploadTask = storageReference.putFile(file!);

      await uploadTask;

      profileImageUrl = await storageReference.getDownloadURL();

      userModel!.image = profileImageUrl!;
      update();
    } catch (error) {
      debugPrint(error.toString());
    }
  }


}