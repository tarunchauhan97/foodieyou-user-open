import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/models/cart_model.dart';
import 'package:foodieyou/modules/cart_screen/views/cart_screen.dart';
import 'package:foodieyou/modules/check_out/controllers/check_out_controller.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';

Widget paymentTypeItem(context,
    {required int paymentIndex,required String title, required IconData icon, required String details}) {
  CheckOutController checkOutController=Get.find<CheckOutController>();
  return InkWell(
    onTap: (){
      checkOutController.setPaymentIndex(paymentIndex);
    },
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.height10 * 2,),
      height: Dimensions.height10 * 10,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(15),
          color: Colors.white),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: checkOutController.paymentIndex==paymentIndex?AppColors.mainColor:Colors.black54,
            size: Dimensions.height10 * 5,
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      fontSize: Dimensions
                          .height10 *
                          1.7,
                      fontWeight:
                      FontWeight
                          .bold,
                      color: checkOutController.paymentIndex==paymentIndex?AppColors.mainColor:Colors.black54),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  details,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      fontWeight:
                      FontWeight
                          .w300,
                      fontSize: Dimensions
                          .height10 *
                          1.2,
                      color: AppColors
                          .textColor),
                )
              ],
            ),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          checkOutController.paymentIndex==paymentIndex?Icon(Icons.check_circle,color: AppColors.mainColor,):Container()
        ],
      ),
    ),
  );
}

Widget orderItem(List<CartModel> items,context)=>Padding(
  padding: EdgeInsets.only(
      top: Dimensions.height10 * 2,
      right: Dimensions.height10 * 1.5,
      left: Dimensions.height10 * 1.5),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      SizedBox(
        height:  Dimensions.height10 * 8.5,
        child: Row(
          children: [
            Wrap(
                children: List.generate(
                  items.length > 3 ? 3 : items.length,
                      (index) => Container(
                    margin: EdgeInsets.only(right: Dimensions.width10,top: Dimensions.height10*1.5),
                    width: Dimensions.width10 * 7,
                    height: Dimensions.height10 * 7,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(items[index].product.img)),
                        borderRadius: BorderRadius.circular(Dimensions.height10)),
                  ),
                )),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text( 'Total',style: TextStyle(fontSize: Dimensions.width10*1.8),),
                const Spacer(),
                Text( '${items.length} Items'),
                const Spacer(),
                CustomButton(onPressed: (){
                    Get.offAll(const CartScreen());
                },transparent: true,buttonText: "one more",height: Dimensions.height10*3,width: Dimensions.width10*9,)
              ],
            ),
          ],
        ),
      )
    ],
  ),
);