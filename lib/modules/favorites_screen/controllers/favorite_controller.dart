import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/models/product_model.dart';
import 'package:foodieyou/shared/constants/constants.dart';

class FavoriteController extends GetxController{
  List<ProductModel> favorites=[];


  @override
  void onInit() async{
    super.onInit();
    await getFavorite();
    update();
  }

   bool exist(ProductModel model){
    bool exist=false;
    int i=0;
    while(i<favorites.length&&exist==false){
      if(favorites[i].id==model.id){
        exist=true;
      }
      else{
        i++;
      }
    }
    return i<favorites.length;
   }

   bool loading=false;

   Future<void> getFavorite() async{
    favorites=[];
    loading=true;
    update();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AppConstants.uid).collection('favorites')
        .get()
        .then((value) {
          for (var element in value.docs) {
            favorites.add(ProductModel.fromJson(element.data()));
          }
      update();
    })
        .catchError((error) {
      debugPrint(error.toString());
    });
    loading=false;
    update();
  }

Future<void> addFavorite(ProductModel model) async{
    favorites.addIf(!favorites.contains(model), model);
  update();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AppConstants.uid)
        .collection('favorites').doc(model.id).set(model.toJson())
        .then((value) {
          Get.snackbar("Add", "${model.name} has been added to your favorites",colorText: Colors.green);
    })
        .catchError((error) {
      debugPrint(error.toString());
    });
    update();
}

  Future<void> removeFavorite(ProductModel model) async{
    favorites.removeWhere((element) => element.id==model.id);
    update();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AppConstants.uid)
        .collection('favorites').doc(model.id).delete()
        .then((value) {

      Get.snackbar("Remove", "${model.name} has been removed from your favorites list.",colorText: Colors.red);

    })
        .catchError((error) {
      debugPrint(error.toString());
    });
    update();
  }


}