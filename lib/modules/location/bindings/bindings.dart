import 'package:foodieyou/modules/location/controller/location_controller.dart';
import 'package:get/get.dart';


class LocationBindings implements Bindings{

  @override
  void dependencies(){
    Get.put(LocationController(),permanent: true);
  }

}