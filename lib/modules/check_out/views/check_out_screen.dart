import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/cart_screen/controllers/cart_controller.dart';
import 'package:foodieyou/modules/cart_screen/views/cart_screen.dart';
import 'package:foodieyou/modules/check_out/controllers/check_out_controller.dart';
import 'package:foodieyou/modules/check_out/views/widgets.dart';
import 'package:foodieyou/modules/food_details/controllers/food_controller.dart';
import 'package:foodieyou/modules/layout/views/layout.dart';
import 'package:foodieyou/modules/location/controller/location_controller.dart';
import 'package:foodieyou/modules/location/view/pick_address.dart';
import 'package:foodieyou/modules/orders_screen/controller/orders_controller.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';
import 'package:foodieyou/shared/widgets/custom_form_field.dart';

class CheckOutScreen extends StatelessWidget {
   const CheckOutScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.fieldColor,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.offAll(() => const CartScreen());
              // Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.mainColor,
            )),
        title: const Text(
          "Order Details",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0.2,
        shadowColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.height10 * 0.5,
                ),
                Container(
                  height: Dimensions.height10 * 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: orderItem(
                      Get.find<CartController>().allCartItems, context),
                ),
                SizedBox(
                  height: Dimensions.height10 * 0.5,
                ),
                SizedBox(
                  height: Dimensions.height10*0.5,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height10,
                      horizontal: Dimensions.width10*2),
                  height: Dimensions.height10 * 26,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Method",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      GetBuilder<CheckOutController>(
                        builder: (checkOutController) {
                          return Column(
                            children: [
                              paymentTypeItem(context,
                                  paymentIndex: 0,
                                  title: "Pay with Credit Card",
                                  icon: Icons.credit_card,
                                  details: "Pay before receiving your items"),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: Dimensions.height10*.5),
                                height: 1,
                                color: Colors.grey.withOpacity(.5),
                              ),
                              paymentTypeItem(context,
                                  paymentIndex: 1,
                                  title: "Cash on delivery",
                                  icon: Icons.money,
                                  details: "Pay after getting your Items"),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: Dimensions.height10 * 0.5,
                ),
                //ticket
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height10,
                      horizontal: Dimensions.width10 * 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Purchase ticket",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: Dimensions.height10),
                        height: Dimensions.height10 * 0.1,
                        color: AppColors.greyColor.withOpacity(0.5),
                      ),
                      GetBuilder<CartController>(
                        builder: (controller) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children: List.generate(controller.allCartItems.length, (index) => Row(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Dimensions.width10*19,
                                          child: Text(
                                            "${controller.allCartItems[index].product.name} "  ,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: AppColors.greyColor),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          " × ${controller.allCartItems[index].quantity}"  ,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: AppColors.greyColor),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                        controller.allCartItems[index].product.inDiscount==false?
                                      "\$${(controller.allCartItems[index].product.price * controller.allCartItems[index].quantity).toStringAsFixed(2)} ":"\$${(controller.allCartItems[index].product.discount! * controller.allCartItems[index].quantity).toStringAsFixed(2)} ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.greyColor),
                                    )
                                  ],
                                ),),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10),
                                height: Dimensions.height10 * 0.1,
                                color: AppColors.greyColor.withOpacity(0.5),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Sub-total",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.greyColor),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "\$${controller.getTotalPrice().toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize:16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.greyColor),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "delivery fees",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.greyColor),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "\$1.5",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.greyColor),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10),
                                height: Dimensions.height10 * 0.1,
                                color: AppColors.greyColor.withOpacity(0.5),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Total",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "\$${(controller.getTotalPrice()+1.5).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.mainColor),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
                //address
                SizedBox(
                  height: Dimensions.height10*0.5,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height10,
                      horizontal: Dimensions.width10 * 2),
                  height: Dimensions.height10 * 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      GetBuilder<LocationController>(
                        builder: (locationController) {
                          return Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.greyColor, width: 1),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.width10 * 0.5)),
                              margin: EdgeInsets.symmetric(
                                  vertical: Dimensions.height10),
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.height10,
                                  horizontal: Dimensions.width10),
                              height: Dimensions.height10 * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: AppColors.mainColor,
                                      ),
                                      Expanded(
                                          child: Text(
                                        locationController.address,
                                        style: const TextStyle(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ))
                                    ],
                                  ),
                                  const Spacer(),
                                  CustomButton(
                                    onPressed: () {
                                      Get.to(const PickAddressMap(fromProfile: false,));
                                    },
                                    height: Dimensions.height10 * 3,
                                    width: Dimensions.width10 * 15,
                                    buttonText:locationController.pickedAddress==""?'Put Your Location': 'Change Address',
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                //additional info and button
                SizedBox(height: Dimensions.height10*0.5,),
                GetBuilder<LocationController>(builder: (locationController) {
                 return Container(
                   padding: EdgeInsets.symmetric(vertical: Dimensions.height10,horizontal: Dimensions.width10*2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Additional info",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: Dimensions.height10,),
                        const Text('Contact Name',style: TextStyle(fontSize:15),),
                        SizedBox(height: Dimensions.height10*0.5,),
                        CustomFormField(
                          isName: true,
                          margin: EdgeInsets.zero,
                          hintText: "",
                          prefixIcon: Icons.person,
                          controller: locationController.name,
                          validator: locationController.nameValidator,
                        ),
                        SizedBox(
                          height: Dimensions.height10 *0.5,
                        ),
                        const Text('Contact Number',style: TextStyle(fontSize: 15),),
                        SizedBox(height: Dimensions.height10,),
                        CustomFormField(
                          isPhone: true,
                          margin: EdgeInsets.zero,
                          hintText: "",
                          prefixIcon: Icons.phone_android,
                          controller: locationController.phone,
                          validator: locationController.phoneValidator,
                        ),
                        SizedBox(height: Dimensions.height10*2,),
                        GetBuilder<OrdersController>(builder: (ordersController) {
                          CheckOutController checkOutController=Get.find<CheckOutController>();
                          return ordersController.loading?Center(child: CircularProgressIndicator(color: AppColors.mainColor,)): CustomButton(
                            onPressed: ()async{
                               if(locationController.deliveryAddressModel==null){
                                 Get.snackbar("Address", "Put Your Location to proceed ",colorText: Colors.red);
                              }
                              else if (formKey.currentState!.validate()) {
                                if(checkOutController.paymentIndex==1){
                                  await ordersController.setOrder(paymentMethod: "Cash",totalPrice: Get.find<CartController>().getTotalPrice(deliveryFees: 1.5), contactPersonName: locationController.name.text, contactPersonNumber: locationController.phone.text, addressModel: locationController.deliveryAddressModel!, items: Get.find<CartController>().allCartItems);
                                  Get.find<CartController>().cleanCart();
                                  Get.find<FoodController>().clean();
                                  Get.offAll(const HomeLayOutScreen());
                                }
                                else{
                                  String price=(Get.find<CartController>().getTotalPrice(deliveryFees: 1.5)*100).toStringAsFixed(0);
                                  await checkOutController.initPaymentSheet(price);
                                  await ordersController.setOrder(paymentId: checkOutController.paymentId,paymentMethod: "Stripe",totalPrice: Get.find<CartController>().getTotalPrice(deliveryFees: 1.5), contactPersonName: locationController.name.text, contactPersonNumber: locationController.phone.text, addressModel: locationController.deliveryAddressModel!, items: Get.find<CartController>().allCartItems);
                                  Get.find<CartController>().cleanCart();
                                  Get.find<FoodController>().clean();
                                  Get.offAll(const HomeLayOutScreen());
                                  // Get.to( StripePayment());

                                }

                              }
                            },
                            buttonText: "Proceed",);
                        },),

                        SizedBox(height: Dimensions.height10*2,),
                      ],
                    )
                  );
                },),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
