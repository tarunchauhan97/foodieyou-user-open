import 'package:get/get.dart';
import 'package:foodieyou/modules/auth/controllers/verify_email_controller.dart';

class VerifyEmailBindings implements Bindings{

  @override
  void dependencies(){
    Get.lazyPut(() => VerifyEmailController());
  }

}