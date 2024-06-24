import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:foodieyou/models/product_model.dart';
import 'package:foodieyou/models/restaurant_model.dart';



class HomeController extends GetxController{

  @override
  void onInit() async {
    super.onInit();
    await getRestaurants();
    getAllProducts().listen((_) {
      update();
    });
    listenForRestaurantChanges();

  }

  List<RestaurantModel> restaurants = [];
  List<ProductModel> products = [];
  List<ProductModel> foods=[];
  List<ProductModel> beverages=[];
  List<ProductModel> desserts=[];
  List<ProductModel> productsInDiscount=[];

  Map<String,Map<String,List<ProductModel>>> productsPerRest={};

  bool loading=false;

  Future<void> getRestaurants() async{
    loading=true;
    update();
    CollectionReference<Map<String, dynamic>> restCollection =
    FirebaseFirestore.instance.collection("restaurants");
    await restCollection.orderBy('stars', descending: true).get().then((doc) {
      restaurants = [];
      for (var element in doc.docs) {
        Map<String, dynamic> temp = element.data();
        temp.putIfAbsent('id', () => element.id);
        productsPerRest.putIfAbsent(element.id, () => {
          "foods":[],
          "beverages":[],
          "desserts":[],
        });
        restaurants.add(RestaurantModel.fromJson(temp));
      }
      update();
    }).catchError((error) {
      debugPrint(error.toString());
    });
    loading=false;
    update();
  }
  void listenForRestaurantChanges() {
    FirebaseFirestore.instance.collection('restaurants').snapshots().listen((event) async {
      for (var change in event.docChanges) {
        if (change.type == DocumentChangeType.added||change.type == DocumentChangeType.removed||change.type == DocumentChangeType.modified) {
          await getRestaurants();
        }
      }
    });
  }
  Stream<void> getAllProducts() {
    productsInDiscount=[];
    products = [];
    foods=[];
    beverages=[];
    desserts=[];
    loading=true;
    productsPerRest.forEach((key, value) {
      productsPerRest[key]!['foods']=[];
      productsPerRest[key]!['beverages']=[];
      productsPerRest[key]!['desserts']=[];
    });
    update();

    final query = FirebaseFirestore.instance.collectionGroup('products').orderBy("stars",descending: true);
    return query.snapshots().asyncMap((querySnapshot) async {
      try {
        for (var item in querySnapshot.docs) {
          Map<String, dynamic> temp = item.data();
          temp.putIfAbsent('restId', () => restaurants.firstWhere((element) => item.reference.parent.parent!.id==element.id).id);
          temp.putIfAbsent('restName', () => restaurants.firstWhere((element) => item.reference.parent.parent!.id==element.id).name);
          temp.remove('id');
          temp.putIfAbsent('id', () => item.id);
          if(item["category"]=="food"){

            //add food items
            int index=foods.indexWhere((element) => element.id==temp['id']);
            if(index==-1){
              foods.add(ProductModel.fromJson(temp));
            }
            else{
              foods[index]=ProductModel.fromJson(temp);
            }
            productsPerRest.update(temp['restId'], (value) {
              int index=value['foods']!.indexWhere((element) => element.id==temp['id']);
              if(index==-1) {
                value['foods']!.add(ProductModel.fromJson(temp));
              }
              else{
                value['foods']![index]=ProductModel.fromJson(temp);
              }

              return value;
            } );

          }
          else if(item["category"]=="beverages"){
            //add beverages items
            int index=beverages.indexWhere((element) => element.id==temp['id']);
            if(index==-1){
              beverages.add(ProductModel.fromJson(temp));
            }
            else{
              beverages[index]=ProductModel.fromJson(temp);
            }
            productsPerRest.update(temp['restId'], (value) {
              int index=value['beverages']!.indexWhere((element) => element.id==temp['id']);
              if(index==-1) {
                value['beverages']!.add(ProductModel.fromJson(temp));
              }
              else{
                value['beverages']![index]=ProductModel.fromJson(temp);
              }
              return value;
            } );
          }
          else{
            //add desserts items
            int index=desserts.indexWhere((element) => element.id==temp['id']);
            if(index==-1){
              desserts.add(ProductModel.fromJson(temp));
            }
            else{
              desserts[index]=ProductModel.fromJson(temp);
            }
            productsPerRest.update(temp['restId'], (value) {
              int index=value['desserts']!.indexWhere((element) => element.id==temp['id']);
              if(index==-1) {
                value['desserts']!.add(ProductModel.fromJson(temp));
              }
              else{
                value['desserts']![index]=ProductModel.fromJson(temp);
              }
              return value;
            } );
          }
          if(temp['inDiscount']==true){
            //add discount items
            int index=productsInDiscount.indexWhere((element) => element.id==temp['id']);
            if(index==-1){
              productsInDiscount.add(ProductModel.fromJson(temp));
            }
            else{
              productsInDiscount[index]=ProductModel.fromJson(temp);
            }
          }
          int index=products.indexWhere((element) => element.id==temp['id']);
          if(index==-1){
            products.add(ProductModel.fromJson(temp));
          }
          else{
            products[index]=ProductModel.fromJson(temp);
          }
        }

        loading=false;
        update();

      } catch (e) {
        loading=false;
        update();
        debugPrint('Error in getAllProducts: ${e.toString()}');
      }
    }).handleError((error) {
      debugPrint(error.toString());
    });
  }

  List<ProductModel> sortListByPrice(List<ProductModel> list ){
    list.sort((a, b) {
      if(a.inDiscount&&b.inDiscount){
        return a.discount!.compareTo(b.discount!);
      }
      else if(a.inDiscount){
        return a.discount!.compareTo(b.price);
      }
      else if(b.inDiscount){
        return a.price.compareTo(b.discount!);
      }
      else{
        return a.price.compareTo(b.price);
      }
    },);
    return list;
  }
  List<ProductModel> sortListByPopularity(List<ProductModel> list ){
    list.sort((a, b) {
      return b.stars.compareTo(a.stars);
    },);
    return list;
  }
 //sort items
  void sortList(String value){
    if(value=="Popularity"){
      foods=sortListByPopularity(foods);
      beverages=sortListByPopularity(beverages);
      desserts=sortListByPopularity(desserts);
      productsInDiscount=sortListByPopularity(productsInDiscount);
    }
    else{
      foods=sortListByPrice(foods);
      beverages=sortListByPrice(beverages);
      desserts=sortListByPrice(desserts);
      productsInDiscount=sortListByPrice(productsInDiscount);
    }
    update();
  }
  // Search List
  List<RestaurantModel> searchedRestaurants=[];
  List<ProductModel> searchedProducts=[];

  void search(List<dynamic> list,String searchedItem){
    if(searchedItem.isNotEmpty){
      if(list is List<ProductModel>){
        searchedProducts=list.where((product) => product.name.toLowerCase().contains(searchedItem.toLowerCase())).toList();
      }
      else{
        searchedRestaurants=(list as List<RestaurantModel>).where((restaurant) => restaurant.name.toLowerCase().contains(searchedItem.toLowerCase())).toList();
      }
    }
    else{
      searchedProducts=[];
      searchedRestaurants=[];
    }
    update();
  }

  TextEditingController searchController=TextEditingController();

}