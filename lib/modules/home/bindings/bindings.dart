import 'package:foodieyou/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';


class HomeBindings implements Bindings{

  @override
  void dependencies(){

    Get.put(HomeController(),permanent: true);
  }

}