import 'package:flutter/material.dart';
import'package:dots_indicator/dots_indicator.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';


// ignore: must_be_immutable
class DotsIndicatorReusable extends StatelessWidget {
   final int length;
   double currentIndexPage ;

   DotsIndicatorReusable({Key? key,required this.length,required this.currentIndexPage}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: length,
      position: currentIndexPage,
      decorator: DotsDecorator(
        spacing: EdgeInsets.symmetric(horizontal: Dimensions.width10*0.3),
        activeColor: AppColors.mainColor,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
