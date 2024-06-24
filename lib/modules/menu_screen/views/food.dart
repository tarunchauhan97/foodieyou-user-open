import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodieyou/modules/cart_screen/views/cart_screen.dart';
import 'package:foodieyou/modules/home/controllers/home_controller.dart';
import 'package:foodieyou/modules/layout/controllers/layout_controller.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/menu_screen/views/widgets.dart';
import 'package:foodieyou/shared/widgets/custom_form_field.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

class FoodScreen extends StatefulWidget {
  final int type;
  final String title;

  const FoodScreen({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
   Get.find<HomeController>().searchController.clear();
  }
  @override
  Widget build(BuildContext context) {
    LayoutController controller = Get.find<LayoutController>();
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
            automaticallyImplyLeading: true,
            title: Padding(
              padding: EdgeInsets.only(left: Dimensions.width10 * 0.5),
              child: Text(widget.title,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            actions: [
              InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  Get.to(const CartScreen());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10 * 2.1),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ),
          body: CustomScrollView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            slivers: [
              //search field
              SliverToBoxAdapter(
                child: CustomFormField(
                  controller: homeController.searchController,
                  onChanged: (value) {
                    switch (widget.type) {
                      case 0:
                        homeController.search(homeController.foods, value);
                        break;
                      case 1:
                        homeController.search(homeController.beverages, value);
                        break;
                      case 2:
                        homeController.search(homeController.desserts, value);
                        break;
                      default:
                        homeController.search(
                            homeController.productsInDiscount, value);
                        break;
                    }
                  },
                  hintText: 'Search for ${widget.title}',
                  margin: EdgeInsets.symmetric(
                      vertical: Dimensions.height10 * 3,
                      horizontal: Dimensions.width10 * 2),
                  prefixIcon: Icons.search,
                ),
              ),
              //filter
              GetBuilder<LayoutController>(
                builder: (layoutController) {
                  return SliverToBoxAdapter(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10 * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sort By',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.greyColor),
                            ),
                            DropdownButton<String>(
                              iconEnabledColor: AppColors.mainColor,
                              value: layoutController.dropDownValue,
                              onChanged: (value) {
                                layoutController.onChanged(value);
                                homeController.sortList(value!);
                              },
                              items: [
                                DropdownMenuItem<String>(
                                  value: layoutController.dropDownChoices[0],
                                  child:
                                      Text(layoutController.dropDownChoices[0]),
                                ),
                                DropdownMenuItem<String>(
                                  value: layoutController.dropDownChoices[1],
                                  child:
                                      Text(layoutController.dropDownChoices[1]),
                                ),
                              ],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.grey[700]),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                          ],
                        )),
                  );
                },
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                if (homeController.searchController.text.isEmpty) {
                  switch (widget.type) {
                    case 0:
                      return foodItem(
                          context, homeController.foods[index], widget.title);
                    case 1:
                      return foodItem(
                          context, homeController.beverages[index], widget.title);
                    case 2:
                      return foodItem(
                          context, homeController.desserts[index], widget.title);
                    default:
                      return foodItem(context,
                          homeController.productsInDiscount[index], widget.title);
                  }
                } else {
                  return foodItem(
                      context, homeController.searchedProducts[index], widget.title);
                }
              },
                      childCount: homeController.searchController.text.isEmpty
                          ? widget.type == 0
                              ? homeController.foods.length
                              : widget.type == 1
                                  ? homeController.beverages.length
                                  : widget.type == 2
                                      ? homeController.desserts.length
                                      : homeController.productsInDiscount.length
                          : homeController.searchedProducts.length)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Dimensions.height10 * 13,
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: InkWell(
            onTap: () {
              Get.back();
              controller.changeScreen(2);
              controller.pageController!.jumpToPage(controller.screenIndex);
            },
            child: CircleAvatar(
              backgroundColor: controller.screenIndex != 2
                  ? AppColors.greyColor
                  : AppColors.mainColor,
              radius: Dimensions.height10 * 3.6,
              child: Icon(
                Icons.home,
                size: Dimensions.height10 * 4,
                color: Colors.white,
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 18,
            shape: const CircularNotchedRectangle(),
            color: Colors.white,
            elevation: 100,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      controller.changeScreen(0);
                      controller.pageController!.jumpToPage(controller.screenIndex);

                    },
                    child: Container(
                      height: Dimensions.height10 * 9,
                      padding: EdgeInsets.only(left: Dimensions.width10 * 1.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.grid_view_rounded,
                                size: Dimensions.height10 * 2.8,
                                color: controller.screenIndex != 0
                                    ? AppColors.greyColor
                                    : AppColors.mainColor,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Menu",
                                style: TextStyle(
                                    fontSize: Dimensions.height10 * 1,
                                    color: controller.screenIndex != 0
                                        ? AppColors.greyColor
                                        : AppColors.mainColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      controller.changeScreen(1);
                      controller.pageController!.jumpToPage(controller.screenIndex);

                    },
                    child: Container(
                      height: Dimensions.height10 * 9,
                      padding: EdgeInsets.only(left: Dimensions.width10 * 1.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                size: Dimensions.height10 * 2.8,
                                color: controller.screenIndex != 1
                                    ? AppColors.greyColor
                                    : AppColors.mainColor,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Favorite",
                                style: TextStyle(
                                    fontSize: Dimensions.height10 * 1,
                                    color: controller.screenIndex != 1
                                        ? AppColors.greyColor
                                        : AppColors.mainColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10 * 11.4,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      controller.changeScreen(3);
                      controller.pageController!.jumpToPage(controller.screenIndex);

                    },
                    child: Container(
                      alignment: AlignmentDirectional.bottomEnd,
                      height: Dimensions.height10 * 9,
                      padding: EdgeInsets.only(right: Dimensions.width10 * 1.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.person,
                                size: Dimensions.height10 * 2.8,
                                color: controller.screenIndex != 3
                                    ? AppColors.greyColor
                                    : AppColors.mainColor,
                              ),
                              Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: Dimensions.height10 * 1,
                                    color: controller.screenIndex != 3
                                        ? AppColors.greyColor
                                        : AppColors.mainColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      controller.changeScreen(4);
                      controller.pageController!.jumpToPage(controller.screenIndex);
                    },
                    child: Container(
                      alignment: AlignmentDirectional.bottomEnd,
                      height: Dimensions.height10 * 9,
                      padding: EdgeInsets.only(right: Dimensions.width10 * 1.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.format_indent_increase_outlined,
                                size: Dimensions.height10 * 2.8,
                                color: controller.screenIndex != 4
                                    ? AppColors.greyColor
                                    : AppColors.mainColor,
                              ),
                              Text(
                                "More",
                                style: TextStyle(
                                  fontSize: Dimensions.height10 * 1,
                                  color: controller.screenIndex != 4
                                      ? AppColors.greyColor
                                      : AppColors.mainColor,
                                ),
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
          extendBody: true,
        );
      },
    );
  }
}
