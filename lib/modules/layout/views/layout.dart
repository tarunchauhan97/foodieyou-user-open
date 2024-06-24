import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodieyou/modules/cart_screen/views/cart_screen.dart';
import 'package:foodieyou/modules/layout/controllers/layout_controller.dart';
import 'package:foodieyou/modules/layout/views/search_delgate.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:get/get.dart';

class HomeLayOutScreen extends StatefulWidget {
  const HomeLayOutScreen({Key? key}) : super(key: key);

  @override
  State<HomeLayOutScreen> createState() => _HomeLayOutScreenState();
}

class _HomeLayOutScreenState extends State<HomeLayOutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LayoutController controller = Get.find<LayoutController>();
    controller.screenIndex=2;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                centerTitle: false,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark),
                title: Padding(
                  padding: EdgeInsets.only(left: Dimensions.width10 * 0.5),
                  child: Text(controller.appBarTexts[controller.screenIndex],
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                actions: [
                  InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: (){
                      showSearch(context: context, delegate:CustomSearchDelegate(), );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 2.1),
                      child: Icon(
                        Icons.search,
                        size: 25,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: (){
                      Get.to(const CartScreen());
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 2.1),
                      child: Icon(
                        Icons.shopping_cart,
                        size: 25,
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
              body: controller.pageController != null
                  ? PageView.builder(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                      physics: const BouncingScrollPhysics(),
                      controller: controller.pageController,
                      onPageChanged: (index) {
                        controller.changeScreen(index);
                      },
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            controller.bodyScreens[controller.screenIndex],
                            SizedBox(
                              height: Dimensions.height10 * 3,
                            )
                          ],
                        );
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
              backgroundColor: Colors.white,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              resizeToAvoidBottomInset: true,
              extendBodyBehindAppBar: true,
              floatingActionButton: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
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
                          controller.changeScreen(0);
                          controller.pageController!.jumpToPage(controller.screenIndex);
                        },
                        child: Container(
                          height: Dimensions.height10 * 9,
                          padding:
                              EdgeInsets.only(left: Dimensions.width10 * 1.5),
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
                          controller.changeScreen(1);
                          controller.pageController!.jumpToPage(controller.screenIndex);
                        },
                        child: Container(
                          height: Dimensions.height10 * 9,
                          padding:
                              EdgeInsets.only(left: Dimensions.width10 * 1.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                          controller.changeScreen(3);
                          controller.pageController!.jumpToPage(controller.screenIndex);
                        },
                        child: Container(
                          alignment: AlignmentDirectional.bottomEnd,
                          height: Dimensions.height10 * 9,
                          padding:
                              EdgeInsets.only(right: Dimensions.width10 * 1.5),
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
                          controller.changeScreen(4);
                          controller.pageController!.jumpToPage(controller.screenIndex);
                        },
                        child: Container(
                          alignment: AlignmentDirectional.bottomEnd,
                          height: Dimensions.height10 * 9,
                          padding:
                              EdgeInsets.only(right: Dimensions.width10 * 1.5),
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
            ));
  }
}
