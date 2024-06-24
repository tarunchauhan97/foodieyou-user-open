import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/favorites_screen/views/favorites_screen.dart';
import 'package:foodieyou/modules/home/views/home_screen.dart';
import 'package:foodieyou/modules/menu_screen/views/menu_screen.dart';
import 'package:foodieyou/modules/more_screen/views/more_screen.dart';
import 'package:foodieyou/modules/profile_screen/views/profile_screen.dart';

class LayoutController extends GetxController {
  List<Widget> bodyScreens = [
    const MenuScreen(),
    const FavoritesScreen(),
    const HomeScreen(),
    const ProfileScreen(),
    const MoreScreen()
  ];
  List<String> appBarTexts = [
    "Menu",
    "Favorites",
    "WELCOME!",
    "Profile",
    "More",
    "Food",
    "Beverages",
    "Desserts",
    "Promotions",
  ];
  int screenIndex = 2;
    PageController? pageController;

  @override
  void onInit() async {
    super.onInit();
     // await getRestaurants();
     // await getAllProducts();
      update();
    pageController=PageController(
      initialPage: screenIndex
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController!.dispose();
  }

  void changeScreen(int index) {
    screenIndex = index;
    update();
  }


  //drop down button
String? dropDownValue="Popularity";
List<String> dropDownChoices=["Popularity","Price"];
  void onChanged(String? value){
    dropDownValue=value;
    update();
  }





}
