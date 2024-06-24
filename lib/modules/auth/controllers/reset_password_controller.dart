import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/data/auth_repository/auth_repo.dart';

class ResetPasswordController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phone=TextEditingController();

  String?  emailValidator(String? value){
    if(value!.isEmpty||!RegExp(r'^[\w.-]+@([\w-]+\.)+[\w]{2,}').hasMatch(value)){
      return "Enter correct email";
    }
    return null;
  }



  bool loading=false;
  Future sendPasswordResetEmail(String email)async{
    loading=true;
    update();
    await AuthenticationRepository.instance.sendPasswordResetEmail(email);
    loading=false;
    update();
    Get.back();
    Get.snackbar("Reset Password","An email has been sent to the email address you provided. Please check your inbox and follow the instructions to reset your password.",colorText: Colors.green,duration: const Duration(seconds: 5));

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    password.dispose();
    confirmPassword.dispose();
    email.dispose();
  }
}
