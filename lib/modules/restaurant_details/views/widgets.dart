import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/models/product_model.dart';
import 'package:foodieyou/modules/favorites_screen/controllers/favorite_controller.dart';
import 'package:foodieyou/modules/food_details/views/food_details.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

Widget gridItem( ProductModel model,context){
  return Stack(
    alignment: Alignment.topRight,
    children: [
      InkWell(
        onTap: (){
          Get.to(FoodDetailScreen(productModel: model));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10*0.5),
          height: Dimensions.height10*25,
          width: double.infinity,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: model.id,
                child: Container(
                  height: Dimensions.height10*16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(model.img),fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: Dimensions.height10*0.5,),
                    Text("\$${model.price}",maxLines: 1,style: TextStyle(fontSize: 16,color: AppColors.greyColor)),
                    SizedBox(height: Dimensions.height10*0.5),
                    Row(
                      children: [
                        Text("${model.stars} ",maxLines: 1,style: const TextStyle(fontSize: 16)),
                        Icon(Icons.star_rounded,color: AppColors.mainColor,)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      GetBuilder<FavoriteController>(builder: (favoriteController) {
        return Container(
          margin:  EdgeInsets.only(right: Dimensions.width10*2,top: Dimensions.height10*1.5),
          child: InkWell(
              onTap: (){
                if(favoriteController.exist(model)) {
                  favoriteController.removeFavorite(model);
                } else{
                  favoriteController.addFavorite(model);
                }
              },
              child: Icon(!favoriteController.exist(model)?Icons.favorite_border:Icons.favorite,color: AppColors.mainColor,size: 27,)),
        );
      },)
    ],
  );
}
