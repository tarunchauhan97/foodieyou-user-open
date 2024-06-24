import 'package:flutter/material.dart';
import 'package:foodieyou/modules/on_boarding/controllers/boarding_controller.dart';
import 'package:foodieyou/modules/on_boarding/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/started_screen/started_screen.dart';
import 'package:foodieyou/shared/constants/constants.dart';
import 'package:foodieyou/shared/local/cache_helper.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';
import 'package:foodieyou/shared/widgets/dots_indicator.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        MaterialButton(onPressed: ()async{
          await CacheHelper.putData(key: AppConstants.boardingScreen, data: false).then((value) {
            Get.off(const StartedScreen(),curve:Curves.linear,duration: const Duration(milliseconds: 200),transition: Transition.rightToLeft);
          });

        },child: Text("Skip",style: TextStyle(color: AppColors.mainColor),),)
      ],),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GetBuilder<BoardingController>(
            builder: (controller) => Column(
                  children: [
                    Expanded(
                        child: PageView.builder(
                      onPageChanged: (index) {
                        controller.changePage(index);
                      },
                      physics: const BouncingScrollPhysics(),
                      controller: controller.viewController,
                      itemBuilder: (context, index) => buildPageViewItem(
                          controller.boardingScreens[index], context,index+1),
                      itemCount: 3,
                    )),
                    SizedBox(
                      height: Dimensions.height10 * 3,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: Dimensions.height10 * 2),
                        child: DotsIndicatorReusable(
                          currentIndexPage: controller.currentPageVal,
                          length: 3,
                        )),
                    SizedBox(
                      height: Dimensions.height10 * 3,
                    ),
                    CustomButton(
                      onPressed: () {
                        controller.clickedNext();
                      },
                      buttonText: "Next",
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.width10 * 3.6),
                    ),
                    SizedBox(
                      height: Dimensions.height10 * 4,
                    ),
                  ],
                )),
      ),
    );
  }
}
