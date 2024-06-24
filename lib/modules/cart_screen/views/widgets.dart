import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/models/cart_model.dart';
import 'package:foodieyou/modules/cart_screen/controllers/cart_controller.dart';
import 'package:foodieyou/modules/food_details/views/food_details.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

Widget cartItem(context, CartModel model) {
  CartController cartController = Get.find<CartController>();
  return Container(
    margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Get.to(FoodDetailScreen(productModel: model.product));
      },
      child: Row(
        children: [
          Hero(
            tag: model.product.id,
            child: Container(
              width: Dimensions.width10 * 10,
              height: Dimensions.height10 * 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.height10 * 2),
                      bottomLeft: Radius.circular(Dimensions.height10 * 2)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(model.product.img))),
            ),
          ),
          Expanded(
            child: Container(
              height: Dimensions.height10 * 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(Dimensions.height10 * 2),
                    topRight: Radius.circular(Dimensions.height10 * 2),
                  ),
                  color: Colors.white),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width10, right: Dimensions.width10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            model.product.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.height10 * 2.2),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              cartController.removeItem(model);
                            },
                            child: const Icon(
                              Icons.highlight_remove,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Text(
                      "By ${model.product.restName}",
                      style:
                          TextStyle(color: AppColors.greyColor, fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.product.inDiscount
                              ? " \$${model.product.discount}"
                              : " \$${model.product.price}",
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                cartController.decreaseItem(model);
                              },
                              child: Icon(
                                Icons.remove,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                            GetBuilder<CartController>(
                              builder: (controller) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "${controller.getQuantity(model)}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cartController.increaseItem(model);
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
