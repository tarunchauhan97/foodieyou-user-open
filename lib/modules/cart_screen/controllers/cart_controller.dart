import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/models/cart_model.dart';
import 'package:foodieyou/models/product_model.dart';
import 'package:foodieyou/modules/food_details/controllers/food_controller.dart';
import 'package:foodieyou/shared/constants/constants.dart';
import 'package:foodieyou/shared/local/cache_helper.dart';
import 'package:foodieyou/shared/styles/colors.dart';


class CartController extends GetxController{
List<CartModel> allCartItems=[];

@override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getCartData();
  }

Future getCartData()async{
  allCartItems=[];
  List<String> cart=[];
  if (CacheHelper.sharedPreferences.containsKey(AppConstants.cartList)) {
    cart = CacheHelper.sharedPreferences.getStringList(AppConstants.cartList)!;
  }
  for (var element in cart) {
    allCartItems.add(CartModel.fromJson(jsonDecode(element)));
  }
  update();
}

Future setCartStorageData()async{
  List<String> cart=[];
    for (var element in allCartItems) {
      cart.add(jsonEncode(element));
    }
    await CacheHelper.putData(key: AppConstants.cartList, data: cart);
}

Future<void> addToCart(ProductModel model,int quantity) async {
  CartModel cartModel=CartModel(quantity: quantity, time:DateTime.now().toString(), product: model);
  int position=allCartItems.indexWhere((element) => element.product.id==model.id);
  if(position==-1){
    allCartItems.add(cartModel);
  }
  else{
    allCartItems[position]=cartModel;
  }
  setCartStorageData();
  update();
}

Future<void> setCart(List<CartModel> products) async {
  allCartItems = List.from(products);
  setCartStorageData();
  update();
}

double getTotalPrice({double deliveryFees=0.0}){
  double s=0;
  for (var element in allCartItems) {
    if(element.product.inDiscount){
      s+=element.product.discount!*element.quantity;
    }
    else{
      s+=element.product.price*element.quantity;
    }
  }
  return s+deliveryFees;
}

void removeItem(CartModel model){
  allCartItems.remove(model);
  setCartStorageData();
  update();
}

void cleanCart(){
  allCartItems=[];
  setCartStorageData();
  update();
}

Future<void> increaseItem(CartModel model) async {
  int position=allCartItems.indexOf(model);
  if(allCartItems[position].quantity==20){
    Get.snackbar("Item Count", "you can't add more ${model.product.name} ",colorText: AppColors.mainColor);

  }else{
    allCartItems[position].quantity++;
  }
  await setCartStorageData();
  await getCartData();
  update();
}

void decreaseItem(CartModel model) {
  int position=allCartItems.indexOf(model);
  if(allCartItems[position].quantity==1){
    Get.snackbar('Item Count', "An item has been removed",colorText: Colors.red,);
    removeItem(model);
    Get.find<FoodController>().getQuantityFromCart();
    update();
  }else{
    allCartItems[position].quantity--;
  }
  setCartStorageData();
  update();
}

int getQuantity(CartModel model){
  return allCartItems[allCartItems.indexOf(model)].quantity;
}

int getAllQuantity(){
  int s=0;
  for (var element in allCartItems) {
    s+=element.quantity;
  }
  return s;
}

}