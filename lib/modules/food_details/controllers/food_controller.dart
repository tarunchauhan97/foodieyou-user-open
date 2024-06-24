import 'package:get/get.dart';
import 'package:foodieyou/models/product_model.dart';
import 'package:foodieyou/modules/cart_screen/controllers/cart_controller.dart';
import 'package:foodieyou/shared/styles/colors.dart';

class FoodController extends GetxController{

  Map<ProductModel,int> quantityPerProduct={};

  bool containsProd(String id){

    for (ProductModel product in quantityPerProduct.keys) {
      if (product.id == id) {
        return true;
      }
    }
    return false;
  }

  void getQuantityFromCart({ProductModel? productModel}){

    if(productModel!=null){
      quantityPerProduct.addAllIf(!containsProd(productModel.id), {productModel:0});
    }
    Get.find<CartController>().allCartItems.forEach((element) {

      if(containsProd(element.product.id)){
        putQuantity(element.product, element.quantity);
      }


    });

  }

  void putQuantity(ProductModel productModel,int quantity){
    for(ProductModel product in quantityPerProduct.keys){
      if(product.id==productModel.id){
         quantityPerProduct[product]=quantity;
         break;
      }
    }
  }
  int getQuantity(ProductModel productModel){
    for(ProductModel product in quantityPerProduct.keys){
      if(product.id==productModel.id){
        return quantityPerProduct[product]!;
      }
    }
    return 0;

  }

  void removeQuantity(ProductModel model){
    for (ProductModel product in quantityPerProduct.keys) {
      if (product.id == model.id) {
        quantityPerProduct[product]=quantityPerProduct[product]!-1;
        update();
        return;
      }
    }

  }

  void addToCart(ProductModel model){

    for (ProductModel product in quantityPerProduct.keys) {
      if (product.id == model.id) {
        Get.find<CartController>().addToCart(model, quantityPerProduct[product]!);
        return;
      }
    }

  }

  void addQuantity(ProductModel model){
    for (ProductModel product in quantityPerProduct.keys) {
      if (product.id == model.id) {
        if(quantityPerProduct[product]==20){
          Get.snackbar("Item Count", "you can't add more ${model.name} ",colorText: AppColors.mainColor);
          return;
        } else{
          quantityPerProduct[product]=quantityPerProduct[product]!+1;
          update();
          return;
        }

      }
    }
    quantityPerProduct.update(model, (value) {
      if(value==20){
        Get.snackbar("Item Count", "you can't add more ${model.name} ",colorText: AppColors.mainColor);

        return value;
      } else{
        value++;
        return value;
      }
    }
    );
    update();
  }




  void clean(){
    quantityPerProduct={};
    update();
  }

}