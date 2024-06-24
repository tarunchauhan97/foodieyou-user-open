import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/cart_screen/bindings/bindings.dart';
import 'package:foodieyou/modules/favorites_screen/bindings/bindings.dart';
import 'package:foodieyou/modules/food_details/bindings/bindings.dart';
import 'package:foodieyou/modules/home/bindings/bindings.dart';
import 'package:foodieyou/modules/home/controllers/home_controller.dart';
import 'package:foodieyou/modules/home/views/widgets.dart';
import 'package:foodieyou/modules/orders_screen/bindings/bindings.dart';
import 'package:foodieyou/modules/profile_screen/bindings/bindings.dart';
import 'package:foodieyou/modules/restaurant_details/views/restaurants.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeBindings().dependencies();
    FavoriteBindings().dependencies();
    ProfileBindings().dependencies();
    CartBindings().dependencies();
    FoodBindings().dependencies();
    OrdersBindings().dependencies();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          //Popular foods
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 2),
          //     child: const Text("Popular foods"),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     height: Dimensions.height10*26,
          //     margin: EdgeInsets.symmetric(vertical: Dimensions.height10*2),
          //     child: CarouselSlider(
          //         items: List.generate(
          //             0,
          //                 (index) =>controller.loading?sliderLoadingItem(): sliderItem(controller.sortListByPopularity(controller.foods)[index],context)),
          //         options: CarouselOptions(
          //             scrollPhysics: const BouncingScrollPhysics(),
          //             height: Dimensions.height10*24,
          //             enlargeCenterPage: true,
          //             autoPlay: true,
          //             autoPlayAnimationDuration: const Duration(seconds: 1,milliseconds: 500),
          //             enableInfiniteScroll: false,
          //             scrollDirection: Axis.horizontal,
          //             autoPlayInterval: const Duration(seconds: 3),
          //             initialPage: 0,
          //             autoPlayCurve: Curves.fastOutSlowIn,
          //             viewportFraction: 0.85)),
          //   ),
          // ),
          // restaurants
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 2,vertical: Dimensions.height10),
              child: Row(
                children: [
                  const Text("Popular restaurants"),
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      Get.to(const RestaurantsScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "View all",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: Dimensions.height10 * 1.8,
                            color: AppColors.mainColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10 * 3,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) => controller.loading?popRestLoadingItem(): popRestItem(context,controller.restaurants[index]),
                  childCount: 3)),
        ],
      );
    },);
  }
}


