import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/on_boarding/models/on_boarding_model.dart';
import 'package:foodieyou/modules/started_screen/started_screen.dart';
import 'package:foodieyou/shared/constants/constants.dart';
import 'package:foodieyou/shared/local/cache_helper.dart';

class BoardingController extends GetxController {
  List<BoardingModel> boardingScreens = [
    BoardingModel(
        title: 'Find Food You Love',
        body:
            'Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep',
        image: 'assets/images/boardig1.png'),
    BoardingModel(
        title: 'Fast Delivery',
        body: 'Fast food delivery to your home, office wherever you are',
        image: 'assets/images/boarding2.png'),
    BoardingModel(
        title: 'Live Tracking',
        body:
            'Real time tracking of your food on the app once you placed the order',
        image: 'assets/images/boarding3.png'),
  ];
  PageController viewController = PageController();
  int currentScreen = 0;
  double currentPageVal = 0.0;

  @override
  void dispose() {
    // TODO: implement dispose
    viewController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    viewController.addListener(() {
      currentPageVal = viewController.page!;
      update();
    });
  }

  void changePage(int index) {
    currentScreen = index;
    update();
  }

  void clickedNext() async{
    if (currentScreen != 2) {
      currentScreen++;
    } else {

      await CacheHelper.putData(key: AppConstants.boardingScreen, data: false).then((value) {
        Get.off(const StartedScreen(),curve:Curves.linear,duration: const Duration(milliseconds: 200),transition: Transition.rightToLeft);
      });
    }

    viewController.animateToPage(currentScreen,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    update();
  }
}
