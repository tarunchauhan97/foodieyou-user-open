import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/models/product_model.dart';
import 'package:foodieyou/modules/favorites_screen/controllers/favorite_controller.dart';
import 'package:foodieyou/modules/food_details/views/food_details.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:shimmer/shimmer.dart';

Widget favoriteItem(
        context, ProductModel model, FavoriteController favoriteController) =>
    Padding(
      padding: EdgeInsets.only(right: Dimensions.width10 * 1.5),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width10 * 2.5,
                vertical: Dimensions.height10 * 2.5),
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10 * 3,
              vertical: Dimensions.height10,
            ),
            height: Dimensions.height10 * 22,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: const Offset(5, 10),
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 5)
              ],
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(Dimensions.height10 * 2),
            ),
            child: InkWell(
              onTap: () {
                Get.to(FoodDetailScreen(productModel: model));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(right: Dimensions.width10 * 2.5),
                          child: Text(
                            model.description,
                            maxLines: 7,
                            style: const TextStyle(height: 1.3, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        !model.inDiscount
                            ? Text(
                                "\$${model.price}",
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              )
                            : RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: model.price.toString(),
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationThickness: 2,
                                          color:
                                              Colors.black12.withOpacity(0.5))),
                                  const TextSpan(text: "  "),
                                  TextSpan(
                                      text: "\$${model.discount}",
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                ]),
                              )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(top: Dimensions.height10),
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: () {
                                favoriteController.removeFavorite(model);
                              },
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: Dimensions.height10 * 4,
                              ))))
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(Dimensions.width10 * 16),
            onTap: () {
              Get.to(FoodDetailScreen(productModel: model));
            },
            child: Container(
              width: Dimensions.height10 * 14,
              height: Dimensions.height10 * 14,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(5, 5),
                        color: Colors.black12,
                        blurRadius: 5)
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(model.img))),
            ),
          )
        ],
      ),
    );

Widget favoriteLoadingItem() => Padding(
      padding: EdgeInsets.only(right: Dimensions.width10 * 1.5),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(.2),
            highlightColor: Colors.grey.withOpacity(.1),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10 * 3,
                  vertical: Dimensions.height10 * 3),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10 * 3,
                  vertical: Dimensions.height10),
              height: Dimensions.height10 * 22,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(5, 10),
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: 5)
                ],
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.height10 * 2),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: Dimensions.height10 * 17,
              height: Dimensions.height10 * 17,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
