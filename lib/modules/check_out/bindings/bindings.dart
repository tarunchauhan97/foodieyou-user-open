import 'package:foodieyou/modules/check_out/controllers/check_out_controller.dart';
import 'package:get/get.dart';


class CheckOutBindings implements Bindings{

  @override
   void dependencies(){
    Get.put(CheckOutController(),permanent: true);
  }

}