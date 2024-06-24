import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:foodieyou/models/product_model.dart';
import 'package:foodieyou/models/restaurant_model.dart';
import 'package:foodieyou/modules/food_details/views/food_details.dart';
import 'package:foodieyou/modules/restaurant_details/views/restaurant_details.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:shimmer/shimmer.dart';

Widget item1(context, index) => Container(
      margin: EdgeInsets.only(right: Dimensions.width10 * 1.4),
      height: Dimensions.height10 * 11.4,
      width: Dimensions.width10 * 9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.height10),
              topRight: Radius.circular(Dimensions.height10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Image.asset(
                "assets/images/test1.png",
                width: Dimensions.width10 * 9,
                height: Dimensions.height10 * 9,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: Dimensions.height10 * 0.7,
              ),
              Text(
                'Sri Lankan',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: Dimensions.height10 * 1.5),
              ),
            ],
          )
        ],
      ),
    );

Widget popRestItem(context, RestaurantModel model) => InkWell(
      onTap: () {
        Get.to(RestaurantDetailScreen(restaurantModel: model));
      },
      child: Column(
        children: [
          Hero(
            tag: model.id,
            child: Container(
              height: Dimensions.height10 * 19,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(model.image), fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            height: Dimensions.height10 * 0.7,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.height10 * 1.65),
                ),
                SizedBox(
                  height: Dimensions.height10 * 0.5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.mainColor,
                      size: 25,
                    ),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: AppColors.greyColor,
                                fontWeight: FontWeight.w300,
                                fontSize: Dimensions.height10 * 1.25),
                            children: [
                          TextSpan(
                              text: ' ${model.stars} ',
                              style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: Dimensions.height10 * 1.6)),
                          TextSpan(
                              text: "(${model.ratings} ratings) Restaurant"),
                          TextSpan(
                              text: ' . ',
                              style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: Dimensions.height10 * 2)),
                          TextSpan(text: model.speciality),
                        ]))
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10 * 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget popRestLoadingItem() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(.3),
        highlightColor: Colors.grey.withOpacity(.15),
        child: Container(
          height: Dimensions.height10 * 19,
          width: double.infinity,
          color: Colors.black,
        ),
      ),
      SizedBox(
        height: Dimensions.height10 * 0.7,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.2),
              highlightColor: Colors.grey.withOpacity(.1),
              child: Container(
                color: Colors.black,
                height: Dimensions.height10 * 3,
                width: Dimensions.width10 * 10,
              ),
            ),
            SizedBox(
              height: Dimensions.height10 * 0.5,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.2),
              highlightColor: Colors.grey.withOpacity(.1),
              child: Container(
                color: Colors.black,
                height: Dimensions.height10 * 3,
                width: Dimensions.width10 * 25,
              ),
            ),
            SizedBox(
              height: Dimensions.height10 * 3,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget recentItem(context, index) {
  return Container(
    margin: EdgeInsets.only(bottom: Dimensions.height10 * 1.2),
    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 2),
    height: Dimensions.height10 * 8,
    width: double.infinity,
    child: Row(
      children: [
        Container(
          height: Dimensions.height10 * 8,
          width: Dimensions.width10 * 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/test2.png"))),
        ),
        SizedBox(
          width: Dimensions.width10 * 2,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mulberry Pizza by Josh",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.height10 * 1.65),
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w300,
                        fontSize: Dimensions.height10 * 1.25),
                    children: [
                  const TextSpan(text: "Café"),
                  TextSpan(
                      text: ' . ',
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w800,
                          fontSize: Dimensions.height10 * 2)),
                  const TextSpan(text: ' Western Food '),
                ])),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 25,
                ),
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w300,
                            fontSize: Dimensions.height10 * 1.25),
                        children: [
                      TextSpan(
                          text: ' 4.9 ',
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.w400,
                              fontSize: Dimensions.height10 * 1.8)),
                      const TextSpan(text: ' (124 Ratings) '),
                    ])),
              ],
            ),
          ],
        )
      ],
    ),
  );
}

Widget sliderItem(
  ProductModel model,
  context,
) {
  return InkWell(
    onTap: () {
      Get.to(FoodDetailScreen(productModel: model));
    },
    child: Stack(
      children: [
        Hero(
          tag: model.id,
          child: Container(
            height: Dimensions.height10 * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.height10 * 3),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(model.img)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.centerLeft,
            height: Dimensions.height10 * 10,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 3,
                      color: Colors.black12),
                ],
                borderRadius: BorderRadius.circular(Dimensions.height10 * 3),
                color: Colors.white),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                    vertical: Dimensions.height10),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        model.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBarIndicator(
                          unratedColor: AppColors.mainColor.withOpacity(0.2),
                          rating: model.stars,
                          itemBuilder: (context, index) => Icon(
                            Icons.star_rounded,
                            color: AppColors.mainColor,
                          ),
                          itemCount: 5,
                          itemSize: Dimensions.height10 * 2,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          width: Dimensions.width10 * 2,
                        ),
                        Text(
                          "${model.stars} Star Ratings",
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Center(
                      child: Text(
                        model.restName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                )),
          ),
        )
      ],
    ),
  );
}

Widget sliderLoadingItem() {
  return Stack(
    children: [
      Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(.4),
        highlightColor: Colors.grey.withOpacity(.2),
        child: Container(
          height: Dimensions.height10 * 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.height10 * 3),
              color: Colors.black),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[200]!,
          child: Container(
            alignment: Alignment.centerLeft,
            height: Dimensions.height10 * 10,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.height10 * 3),
                color: Colors.black),
          ),
        ),
      )
    ],
  );
}
