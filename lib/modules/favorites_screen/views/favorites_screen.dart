import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/favorites_screen/controllers/favorite_controller.dart';
import 'package:foodieyou/modules/favorites_screen/views/widgets.dart';

import 'package:foodieyou/shared/styles/dimension.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(builder: (controller) {
      return CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          !controller.loading&&controller.favorites.isEmpty?SliverToBoxAdapter(
            child: Column(children: [
              SizedBox(height: Dimensions.height10*3,),
              Image.asset("assets/images/favorite.png",height: 400,fit: BoxFit.cover,),
              SizedBox(height: Dimensions.height10*3,),
              const Text("Empty Favorites"),

            ],),
          ):
          SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return
                          controller.loading?
                          favoriteLoadingItem():
                          favoriteItem(context, controller.favorites[controller.favorites.length-index-1],controller)
                        ;
                      },
                  childCount:controller.loading?3:  controller.favorites.length)),
        ],
      );
    },);
  }
}


