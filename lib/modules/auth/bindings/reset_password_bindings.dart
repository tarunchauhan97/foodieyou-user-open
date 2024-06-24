import 'package:get/get.dart';
import 'package:foodieyou/modules/auth/controllers/reset_password_controller.dart';

class ResetPasswordBindings implements Bindings{

  @override
  void dependencies(){
    Get.lazyPut(() => ResetPasswordController());
  }

}