import 'package:foodieyou/modules/favorites_screen/controllers/favorite_controller.dart';
import 'package:get/get.dart';


class FavoriteBindings implements Bindings{

  @override
   void dependencies(){
    Get.put(FavoriteController(),permanent: true);
  }

}