import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:foodieyou/models/product_model.dart';
import 'package:foodieyou/modules/cart_screen/controllers/cart_controller.dart';
import 'package:foodieyou/modules/cart_screen/views/cart_screen.dart';
import 'package:foodieyou/modules/favorites_screen/controllers/favorite_controller.dart';
import 'package:foodieyou/modules/food_details/controllers/food_controller.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';
import 'package:foodieyou/shared/widgets/expandable_text_widget.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FoodDetailScreen extends StatefulWidget {
  final ProductModel productModel;

   const FoodDetailScreen({required this.productModel,Key? key,}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FoodController foodController=Get.find<FoodController>();
    foodController.getQuantityFromCart(productModel: widget.productModel);
  }
  @override
  Widget build(BuildContext context) {
    FoodController foodController= Get.find<FoodController>();
    FavoriteController favoriteController= Get.find<FavoriteController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      extendBody: true,
      body: CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light),
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      backgroundColor:Colors.white ,
                      radius: 20,
                      child: Icon(
                        size: 18,
                        Icons.arrow_back_ios,
                        color: AppColors.mainColor,
                      ),
                    )),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Get.to(const CartScreen());
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(
                          size: 18,
                          Icons.shopping_cart_outlined,
                          color: AppColors.mainColor,
                        ),
                      ),
                      GetBuilder<CartController>(builder: (controller) {
                        return controller.getAllQuantity()!=0? CircleAvatar(
                          backgroundColor: AppColors.mainColor,
                          radius:10,
                          child:Text("${controller.getAllQuantity()}",style: const TextStyle(color: Colors.white,fontSize: 11),),
                        ):Container();
                      },)
                    ],
                  ),
                )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height10 * 8.2),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.height10 * 2.2,
                    ),
                    padding: EdgeInsets.only(
                        top: Dimensions.height10 * 3,
                        bottom: 10,
                        left: Dimensions.width10 * 2),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.height10 * 4),
                          topRight: Radius.circular(Dimensions.height10 * 4),
                        )),
                    child: Text(
                      widget.productModel.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Positioned(
                    right: Dimensions.width10 * 6,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(Dimensions.width10*3),
                      onTap: (){
                        if(favoriteController.favorites.indexWhere((element) => element.id==widget.productModel.id)==-1){
                          favoriteController.addFavorite(widget.productModel);
                        }
                        else
                          {
                            favoriteController.removeFavorite(widget.productModel);
                          }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: Dimensions.height10 * 6,
                        width: Dimensions.width10 * 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                        ),
                        child: GetBuilder<FavoriteController>(builder: (favoriteController) {
                          return favoriteController.favorites.indexWhere((element) => element.id==widget.productModel.id)==-1?Icon(
                            Icons.favorite_border,
                            color: AppColors.mainColor,
                            size: 28,
                          ): Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                            size: 28,
                          );
                        },),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: AppColors.mainColor,
            pinned: true,
            expandedHeight: Dimensions.height10 * 32,
            flexibleSpace:
            FlexibleSpaceBar(
                background: Hero(
                  tag: widget.productModel.id,
                  child: Image.network(widget.productModel.img,fit: BoxFit.cover,
                    width: double.maxFinite,),
                )

                ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.width10 * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingBarIndicator(
                                itemPadding: const EdgeInsets.only(right: 5),
                                unratedColor:
                                    AppColors.mainColor.withOpacity(0.2),
                                rating: widget.productModel.stars,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star_rounded,
                                  color: AppColors.mainColor,
                                ),
                                itemCount: 5,
                                itemSize: Dimensions.height10 * 2,
                                direction: Axis.horizontal,
                              ),
                              SizedBox(
                                height: Dimensions.height10 * 0.5,
                              ),
                              Text(
                                "${widget.productModel.stars} Star Ratings",
                                style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: Dimensions.height10 * 2,
                              ),
                            ],
                          ),

                          !widget.productModel.inDiscount?Text("\$${widget.productModel.price}",style: TextStyle(fontSize:50,fontWeight: FontWeight.w700,color: AppColors.mainColor),):
                          RichText(text: TextSpan(
                              children: [
                                TextSpan(text: widget.productModel.price.toString(),style: TextStyle(fontSize: 20,decoration: TextDecoration.lineThrough,decorationThickness: 2,color: Colors.black12.withOpacity(0.5))),
                                const TextSpan(text: "   "),
                                TextSpan(text:"\$${widget.productModel.discount}",style: TextStyle(fontSize: 45,fontWeight: FontWeight.w700,color:AppColors.mainColor)),
                              ]
                          ),)
                        ],
                      ),
                      //Description
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      ExpandableTextWidget(
                        text:widget.productModel.description,
                        height: Dimensions.height10 * 17.2,
                      ),
                      SizedBox(
                        height: Dimensions.height10 * 2,
                      ),
                      Row(
                        children: [
                          Text(
                            "Number of Portions",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          GetBuilder<FoodController>(builder: (foodController) {
                            return foodController.getQuantity(widget.productModel)!=0?CustomButton(
                              center: false,
                              width: Dimensions.width10 * 5,
                              height: Dimensions.height10 * 4,
                              onPressed: () {
                                foodController.removeQuantity(widget.productModel);
                              },
                              buttonText: "-",
                            ):Container();
                          },),
                          const SizedBox(
                            width: 3,
                          ),
                          GetBuilder<FoodController>(builder: (controller) =>CustomButton(
                            transparent: true,
                            center: false,
                            width: Dimensions.width10 * 5,
                            height: Dimensions.height10 * 4,
                            onPressed: () {},
                            buttonText: "${controller.getQuantity(widget.productModel)}",
                          ),),
                          const SizedBox(
                            width: 3,
                          ),
                          CustomButton(
                            center: false,
                            width: Dimensions.width10 * 5,
                            height: Dimensions.height10 * 4,
                            onPressed: () {
                              foodController.addQuantity(widget.productModel);
                            },
                            buttonText: "+",
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: Dimensions.height10 * 17,
                      width: Dimensions.width10 * 12,
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
                      top: Dimensions.height10 * 2.5,
                      left: Dimensions.width10 * 6,
                      child: Container(
                        alignment: Alignment.center,
                        height: Dimensions.height10 * 12.2,
                        width: Dimensions.width10 * 27.7,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Text(
                              "Total Price",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 17, color: AppColors.mainColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GetBuilder<FoodController>(builder: (controller) {
                              double myPrice=!widget.productModel.inDiscount?controller.getQuantity(widget.productModel) * widget.productModel.price :controller.getQuantity(widget.productModel) * widget.productModel.discount!;
                              String formattedPrice = myPrice.toStringAsFixed(2);
                              double roundedPrice = double.parse(formattedPrice);
                              return Text(
                                "\$ $roundedPrice",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 25),
                              );
                            },),
                            const SizedBox(
                              height: 5,
                            ),
                            GetBuilder<FoodController>(builder: (foodController) {
                              return foodController.quantityPerProduct[widget.productModel]!=0?CustomButton(
                                icon: Icons.add_shopping_cart_rounded,
                                center: true,
                                width: Dimensions.width10 * 20,
                                height: Dimensions.height10 * 4,
                                onPressed: () {
                                  foodController.addToCart(widget.productModel);
                                },
                                buttonText: "Add to Cart",

                              ):Container(
                                height: Dimensions.height10*4,
                              );
                            },),

                            const Spacer()
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: Dimensions.height10 * 6,
                        right: Dimensions.width10 * 2,
                        left: Dimensions.width10 * 31.3,
                      ),
                      width: Dimensions.width10 * 4.7,
                      height: Dimensions.height10 * 4.7,
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
                        onTap: (){
                          Get.to(const CartScreen());
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius:20,
                              child: Icon(
                                size: 18,
                                Icons.shopping_cart_outlined,
                                color: AppColors.mainColor,
                              ),
                            ),
                            GetBuilder<CartController>(builder: (controller) {
                              return controller.getAllQuantity()!=0? CircleAvatar(
                                backgroundColor: AppColors.mainColor,
                                radius: 10,
                                child:Text("${controller.getAllQuantity()}",style: const TextStyle(color: Colors.white,fontSize: 11),),
                              ):const SizedBox(width: 0,height: 0,);
                            },)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
