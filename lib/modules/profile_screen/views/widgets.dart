
import 'package:flutter/material.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingWidget(){
  return

    Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      //profile
      Column(
        children: [
          SizedBox(
            height: Dimensions.height10 * 3,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(.2),
            highlightColor:Colors.grey.withOpacity(.1) ,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: Dimensions.height10 * 14,
              width: Dimensions.height10 * 14,
              decoration: const BoxDecoration(
                color: Colors.black,
                  shape: BoxShape.circle,),),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
           Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(.2),
                highlightColor:Colors.grey.withOpacity(.1) ,
                child: Container(
                  color: Colors.black,
                  height: Dimensions.height10 * 2.5,
                  width: Dimensions.width10 * 12,
                                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(.2),
                highlightColor:Colors.grey.withOpacity(.1) ,
                child: Container(
                  color: Colors.black,
                  height: Dimensions.height10 * 2.5,
                  width: Dimensions.width10 * 18,
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(.2),
                highlightColor:Colors.grey.withOpacity(.1) ,
                child: Container(
                  color: Colors.black,
                  height: Dimensions.height10 * 2.5,
                  width: Dimensions.width10 * 12,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.height10 * 1.6),
        ],
      ),
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.height10,
            horizontal: Dimensions.width10 * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.2),
              highlightColor:Colors.grey.withOpacity(.1) ,
              child: Container(
                color: Colors.black,
                height: Dimensions.height10 * 3,
                width: Dimensions.width10 * 10,
              ),
            ),
            SizedBox(height: Dimensions.height10*0.5,),
            //fields
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.2),
              highlightColor:Colors.grey.withOpacity(.1) ,
              child: Container(
                color: Colors.black,
                height: Dimensions.height10 * 5,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: Dimensions.height10 * 2.8,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.2),
              highlightColor:Colors.grey.withOpacity(.1) ,
              child: Container(
                color: Colors.black,
                height: Dimensions.height10 * 3,
                width: Dimensions.width10 * 10,
              ),
            ),
            SizedBox(height: Dimensions.height10*0.5,),
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.2),
              highlightColor:Colors.grey.withOpacity(.1) ,
              child: Container(
                color: Colors.black,
                height: Dimensions.height10 * 5,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),

      SizedBox(
        height: Dimensions.height10 * 0.8,
      ),
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.height10,
            horizontal: Dimensions.width10 * 2),
        height: Dimensions.height10 * 15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.2),
              highlightColor:Colors.grey.withOpacity(.1) ,
              child: Container(
                color: Colors.black,
                height: Dimensions.height10 * 3,
                width: Dimensions.width10 * 10,
              ),
            ),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(.2),
                highlightColor:Colors.grey.withOpacity(.1) ,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                      borderRadius: BorderRadius.circular(
                          Dimensions.width10 * 0.5)),
                  margin: EdgeInsets.symmetric(
                      vertical: Dimensions.height10),
                  height: Dimensions.height10 * 12,
                  width: double.infinity,
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: Dimensions.height10 * 2.8,
      ),
    ],
  )
  ;
}