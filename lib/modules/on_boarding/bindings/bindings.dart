import 'package:foodieyou/modules/on_boarding/controllers/boarding_controller.dart';
import 'package:get/get.dart';


class MyBindings implements Bindings{

  @override
  void dependencies(){

    Get.lazyPut(() => BoardingController());
  }

}