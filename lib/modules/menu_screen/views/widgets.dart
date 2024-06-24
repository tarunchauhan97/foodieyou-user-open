import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/models/product_model.dart';
import 'package:foodieyou/modules/food_details/views/food_details.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

Widget foodItem(context, ProductModel product, title) => InkWell(
      onTap: () {
        Get.to(() => FoodDetailScreen(
              productModel: product,
            ));
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Hero(
                tag: product.id,
                child: Container(
                  height: Dimensions.height10 * 19,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            product.img,
                          ))),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          stops: const [
                            0.2,
                            0.6
                          ],
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.black54.withOpacity(0.1)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Dimensions.width10*1.5 ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.5),
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
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                children: [
                              TextSpan(
                                  text: "${product.stars} ",
                                  style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16)),
                              TextSpan(text: product.restName),
                              TextSpan(
                                  text: ' . ',
                                  style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20)),
                              TextSpan(text: title),
                            ])),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        !product.inDiscount
                            ? Text(
                              "\$${product.price}",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.mainColor),
                            )
                            : RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: product.price.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        decoration:
                                        TextDecoration.lineThrough,
                                        decorationThickness: 2,
                                        color: Colors.white
                                            .withOpacity(0.5))),
                                const TextSpan(text: "   "),
                                TextSpan(
                                    text: "\$${product.discount}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.mainColor)),
                              ]),
                            ),
                      ],
                    ),
                    const SizedBox(height: 5,)
                  ],
                ),
              ),
              product.inDiscount?Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color:AppColors.mainColor.withOpacity(.7),
                  ),

                  child: Row(
                    children: [
                      const Icon(Icons.discount_outlined,color: Colors.white,),
                      const SizedBox(width: 5,),
                      Text("-${((1-(product.discount!/product.price))*100).toStringAsFixed(0)}%",style: const TextStyle(color: Colors.white,fontSize: 23),)
                    ],
                  ),
                ),
              ):Container()
            ],
          ),
          SizedBox(
            height: Dimensions.height10 * 0.7,
          )
        ],
      ),
    );
