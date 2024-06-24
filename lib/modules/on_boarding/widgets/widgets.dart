import 'package:flutter/material.dart';
import 'package:foodieyou/modules/on_boarding/models/on_boarding_model.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

Widget buildPageViewItem(BoardingModel model,context,int index)=>Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(child: Image(image: AssetImage(model.image))),
    SizedBox(height: Dimensions.height10*2,),
    Text(
      model.title,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: Dimensions.height10*3,color: AppColors.mainColor)  ,
    ),
    SizedBox(height: Dimensions.height10,),
    SizedBox(
      width: Dimensions.width10*28.2,
      child: Text(
        textAlign: TextAlign.center,
        model.body,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: Dimensions.height10*1.55,color: AppColors.textColor,height: 1.5),
      ),
    ),
    SizedBox(height: Dimensions.height10*4,),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$index",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.mainColor,fontSize: 20),),
        Text("/3",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 22),)
      ],
    )
  ],
);