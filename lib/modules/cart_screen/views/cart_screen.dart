import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/cart_screen/controllers/cart_controller.dart';
import 'package:foodieyou/modules/cart_screen/views/widgets.dart';
import 'package:foodieyou/modules/check_out/bindings/bindings.dart';
import 'package:foodieyou/modules/check_out/views/check_out_screen.dart';
import 'package:foodieyou/modules/layout/controllers/layout_controller.dart';
import 'package:foodieyou/modules/layout/views/layout.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.height10,
                horizontal: Dimensions.width10 * 2),
            child: Column(
              children: [
                InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Get.find<LayoutController>().changeScreen(2);
                      Get.offAll(const HomeLayOutScreen());
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.mainColor,
                      radius: Dimensions.width10 * 3,
                      child: Icon(
                        size: Dimensions.width10 * 3,
                        Icons.home_outlined,
                        color: Colors.white,
                      ),
                    )),
                Expanded(child: GetBuilder<CartController>(
                  builder: (cartController) {
                    return cartController.allCartItems.isEmpty
                        ? Column(
                            children: [
                              const Spacer(),
                              Image.asset('assets/images/emptyCart.png'),
                              SizedBox(
                                height: Dimensions.height10 * 3,
                              ),
                              const Text("Your cart is empty!"),
                              const Spacer()
                            ],
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cartController.allCartItems.length,
                            itemBuilder: (context, index) {
                              return cartItem(
                                  context, cartController.allCartItems[index]);
                            });
                  },
                ))
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartController) {
          return Container(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 2),
            height: Dimensions.height10 * 11,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.height10 * 4),
                  topLeft: Radius.circular(Dimensions.height10 * 4),
                ),
                color: AppColors.disabledColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(Dimensions.height10 * 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(Dimensions.height10 * 2)),
                  child: Text(
                      '\$ ${(cartController.getTotalPrice()).toStringAsFixed(2)}',
                      style:
                          const TextStyle(fontSize: 22, color: Colors.black)),
                ),
                InkWell(
                  onTap: () {
                    if (cartController.allCartItems.isNotEmpty) {
                      Get.to(const CheckOutScreen(),
                          transition: Transition.fade,
                          binding: CheckOutBindings());
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.height10 * 2),
                    decoration: BoxDecoration(
                        color: cartController.allCartItems.isNotEmpty
                            ? AppColors.mainColor
                            : Colors.black26,
                        borderRadius:
                            BorderRadius.circular(Dimensions.height10 * 2)),
                    child: Text(
                      " Check Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.height10 * 1.8),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
