
import 'package:get/get.dart';
import 'package:foodieyou/modules/food_details/controllers/food_controller.dart';


class FoodBindings implements Bindings{

  @override
  void dependencies(){
    Get.put(FoodController(),permanent: true);
  }
}