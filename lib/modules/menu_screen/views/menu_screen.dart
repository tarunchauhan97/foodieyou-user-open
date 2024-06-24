import 'package:flutter/material.dart';
import 'package:foodieyou/modules/home/controllers/home_controller.dart';
import 'package:foodieyou/modules/menu_screen/views/food.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:get/get.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: ((controller) {
      return CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: Dimensions.height10 * 6,
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: Dimensions.height10 * 47.5,
                        width: Dimensions.width10 * 9,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                  Dimensions.height10 * 3.5,
                                ),
                                bottomRight: Radius.circular(
                                  Dimensions.height10 * 3.5,
                                ))),
                      ),
                      //Food
                      Positioned(
                        top: Dimensions.height10 * 3,
                        left: Dimensions.width10 * 5,
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                              Dimensions.height10 * 2,
                            ),
                            bottomRight: Radius.circular(
                              Dimensions.height10 * 2,
                            ),
                            topLeft: Radius.circular(
                              Dimensions.height10 * 3.5,
                            ),
                            bottomLeft: Radius.circular(
                              Dimensions.height10 * 3.5,
                            ),
                          ),
                          onTap: () {
                            Get.to(const FoodScreen(title: 'Foods', type: 0),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: Dimensions.width10 * 5),
                            height: Dimensions.height10 * 8,
                            width: Dimensions.width10 * 30.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    Dimensions.height10 * 2,
                                  ),
                                  bottomRight: Radius.circular(
                                    Dimensions.height10 * 2,
                                  ),
                                  topLeft: Radius.circular(
                                    Dimensions.height10 * 3.5,
                                  ),
                                  bottomLeft: Radius.circular(
                                    Dimensions.height10 * 3.5,
                                  ),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                Text(
                                  "Foods",
                                  style: Theme.of(context)
                                      .textTheme.bodyLarge!
                                      .copyWith(fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${controller.foods.length} items",
                                  style: Theme.of(context)
                                      .textTheme.bodySmall!
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                const Spacer()
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: Dimensions.height10 * 4,
                        left: Dimensions.width10 * 2,
                        child: InkWell(
                          onTap: () {
                            Get.to(const FoodScreen(title: 'Foods', type: 0),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            width: Dimensions.width10 * 6,
                            height: Dimensions.height10 * 6,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/food.png"),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Positioned(
                        top: Dimensions.height10 * 5,
                        right: Dimensions.width10 * 2,
                        left: Dimensions.width10 * 33.5,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Get.to(const FoodScreen(title: 'Foods', type: 0),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            
                            width: Dimensions.width10 * 3.4,
                            height: Dimensions.height10 * 3.4,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ),
                      //Beverages
                      Positioned(
                        top: Dimensions.height10 * 14,
                        left: Dimensions.width10 * 5,
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                              Dimensions.height10 * 2,
                            ),
                            bottomRight: Radius.circular(
                              Dimensions.height10 * 2,
                            ),
                            topLeft: Radius.circular(
                              Dimensions.height10 * 3.5,
                            ),
                            bottomLeft: Radius.circular(
                              Dimensions.height10 * 3.5,
                            ),
                          ),
                          onTap: () {
                            Get.to(const FoodScreen(title: "Beverages", type: 1),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: Dimensions.width10 * 5),
                            height: Dimensions.height10 * 8,
                            width: Dimensions.width10 * 30.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    Dimensions.height10 * 2,
                                  ),
                                  bottomRight: Radius.circular(
                                    Dimensions.height10 * 2,
                                  ),
                                  topLeft: Radius.circular(
                                    Dimensions.height10 * 3.5,
                                  ),
                                  bottomLeft: Radius.circular(
                                    Dimensions.height10 * 3.5,
                                  ),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                Text(
                                  "Beverages",
                                  style: Theme.of(context)
                                      .textTheme.bodyLarge!
                                      .copyWith(fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${controller.beverages.length} items",
                                  style: Theme.of(context)
                                      .textTheme.bodySmall!
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                const Spacer()
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: Dimensions.height10 * 15,
                        left: Dimensions.width10 * 2,
                        child: InkWell(
                          onTap: () {
                            Get.to(const FoodScreen(title: "Beverages", type: 1),
                                transition: Transition.noTransition);
                          },
                          child: Container(

                            width: Dimensions.width10 * 6,
                            height: Dimensions.height10 * 6,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/beverage.png"),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Positioned(
                        top: Dimensions.height10 * 16,
                        right: Dimensions.width10 * 2,
                        left: Dimensions.width10 * 33.5,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Get.to(const FoodScreen(title: "Beverages", type: 1),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimensions.height10 * 3.4,
                            width: Dimensions.width10 * 3.4,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ),
                      //Desserts
                      Positioned(
                        top: Dimensions.height10 * 25,
                        left: Dimensions.width10 * 5,
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                              Dimensions.height10 * 2,
                            ),
                            bottomRight: Radius.circular(
                              Dimensions.height10 * 2,
                            ),
                            topLeft: Radius.circular(
                              Dimensions.height10 * 3.5,
                            ),
                            bottomLeft: Radius.circular(
                              Dimensions.height10 * 3.5,
                            ),
                          ),
                          onTap: () {
                            Get.to(const FoodScreen(title: "Desserts", type: 2),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: Dimensions.width10 * 5),
                            height: Dimensions.height10 * 8,
                            width: Dimensions.width10 * 30.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    Dimensions.height10 * 2,
                                  ),
                                  bottomRight: Radius.circular(
                                    Dimensions.height10 * 2,
                                  ),
                                  topLeft: Radius.circular(
                                    Dimensions.height10 * 3.5,
                                  ),
                                  bottomLeft: Radius.circular(
                                    Dimensions.height10 * 3.5,
                                  ),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                Text(
                                  "Desserts",
                                  style: Theme.of(context)
                                      .textTheme.bodyLarge!
                                      .copyWith(fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${controller.desserts.length} items",
                                  style: Theme.of(context)
                                      .textTheme.bodySmall!
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                const Spacer()
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: Dimensions.height10 * 26,
                        left: Dimensions.width10 * 2,
                        child: InkWell(
                          onTap: () {
                            Get.to(const FoodScreen(title: "Desserts", type: 2),
                                transition: Transition.noTransition);
                          },
                          child: Container(

                            width: Dimensions.width10 * 6,
                            height: Dimensions.height10 * 6,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/dessert.png"),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Positioned(
                        top: Dimensions.height10 * 27,
                        right: Dimensions.width10 * 2,
                        left: Dimensions.width10 * 33.5,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Get.to(const FoodScreen(title: "Desserts", type: 2),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            alignment: Alignment.center,

                            height: Dimensions.height10 * 3.4,
                            width: Dimensions.width10 * 3.4,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ),
                      //Promotions
                      Positioned(
                        top: Dimensions.height10 * 36,
                        left: Dimensions.width10 * 5,
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                              Dimensions.height10 * 2,
                            ),
                            bottomRight: Radius.circular(
                              Dimensions.height10 * 2,
                            ),
                            topLeft: Radius.circular(
                              Dimensions.height10 * 3.5,
                            ),
                            bottomLeft: Radius.circular(
                              Dimensions.height10 * 3.5,
                            ),
                          ),
                          onTap: () {
                            Get.to(const FoodScreen(title: "Discounts", type: 3),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: Dimensions.width10 * 5),
                            height: Dimensions.height10 * 8,
                            width: Dimensions.width10 * 30.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    Dimensions.height10 * 2,
                                  ),
                                  bottomRight: Radius.circular(
                                    Dimensions.height10 * 2,
                                  ),
                                  topLeft: Radius.circular(
                                    Dimensions.height10 * 3.5,
                                  ),
                                  bottomLeft: Radius.circular(
                                    Dimensions.height10 * 3.5,
                                  ),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                Text(
                                  "Discounts",
                                  style: Theme.of(context)
                                      .textTheme.bodyLarge!
                                      .copyWith(fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${controller.productsInDiscount.length} items",
                                  style: Theme.of(context)
                                      .textTheme.bodySmall!
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                const Spacer()
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: Dimensions.height10 * 37,
                        left: Dimensions.width10 * 2,
                        child: InkWell(
                          onTap: () {
                            Get.to(const FoodScreen(title: "Discounts", type: 3),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            width: Dimensions.width10 * 6,
                            height: Dimensions.height10 * 6,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/discount.png"),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: Dimensions.height10 * 38,
                          right: Dimensions.width10 * 2,
                          left: Dimensions.width10 * 33.5,
                        ),
                        height: Dimensions.height10 * 3.4,
                        width: Dimensions.width10 * 3.4,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                              )
                            ]),
                        child: InkWell(
                          onTap: () {
                            Get.to(const FoodScreen(title: "Discounts", type: 3),
                                transition: Transition.noTransition);
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      );
    }));
  }
}
