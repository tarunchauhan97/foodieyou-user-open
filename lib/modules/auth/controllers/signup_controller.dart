import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:foodieyou/data/auth_repository/auth_repo.dart';

class SignUpController extends GetxController{
  final name=TextEditingController();
  final email=TextEditingController();
  final password=TextEditingController();
  final confirmPassword=TextEditingController();
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

  String?  emailValidator(String? value){
    if(value!.isEmpty||!RegExp(r'^[\w.-]+@([\w-]+\.)+[\w]{2,}').hasMatch(value)){
      return "Enter correct email";
    }
    return null;
  }

  String? passwordValidator(String? value){
    if(value!.isEmpty||!RegExp(r'^(?=.*[0-9a-zA-Z]).{6,}$').hasMatch(value)){
      return "Enter correct password";
    }
    return null;
  }

  String? confirmPasswordValidator(String? value){
    if(password.text!=value){
      return "Password do not match";
    }
    return null;
  }

  bool _loading=false;

  bool  get loading => _loading;

  Future<void> register (
      {required email, required name, required phone, required password}) async {
    _loading=true;
    update();
     await AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password,name,phone);
     _loading=false;
     update();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    phone.dispose();
    // TODO: implement onClose
    super.onClose();
  }

}