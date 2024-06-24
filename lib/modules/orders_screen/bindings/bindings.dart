import 'package:get/get.dart';
import 'package:foodieyou/modules/orders_screen/controller/orders_controller.dart';


class OrdersBindings implements Bindings{

  @override
  void dependencies(){
    Get.put(OrdersController(),permanent: true);
  }

}