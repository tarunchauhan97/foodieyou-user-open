import 'package:get/get.dart';
import 'package:foodieyou/modules/auth/controllers/login_controller.dart';

class LoginBindings implements Bindings{

  @override
  void dependencies(){
    Get.lazyPut(() => LogInController());
  }

}