import 'package:foodieyou/modules/cart_screen/controllers/cart_controller.dart';
import 'package:get/get.dart';


class CartBindings implements Bindings{

  @override
   void dependencies(){
    Get.put(CartController(),permanent: true);
  }

}