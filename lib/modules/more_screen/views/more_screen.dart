import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/data/auth_repository/auth_repo.dart';
import 'package:foodieyou/modules/about_us_screen/about_us_screen.dart';
import 'package:foodieyou/modules/orders_screen/view/orders_screen.dart';
import 'package:foodieyou/shared/constants/constants.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authController = Get.find<AuthenticationRepository>();

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.width10*2),
      child: Column(
        children: [
          //orders
          SizedBox(height: Dimensions.height10*2,),
          Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(Dimensions.width10*1.5),
                      onTap: (){
                        Get.to(const OrdersScreen());
                      },
                      child: Container(
                        height: Dimensions.height10*7.5,
                        decoration: BoxDecoration(
                            color: AppColors.fieldColor,
                            borderRadius: BorderRadius.circular(Dimensions.width10*1.5)
                        ),),
                    ),
                  ),
                  SizedBox(width:Dimensions.width10*1.6 ,)
                ],
              ),
              Align(
                heightFactor:7.5/3.3 ,
                alignment: Alignment.centerRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(Dimensions.width10*1.5),
                  onTap: (){
                    Get.to(const OrdersScreen());
                  },
                  child: Container(
                    height: Dimensions.height10*3.3,
                    width: Dimensions.width10*3.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.fieldColor,
                    ),
                    child: Icon(Icons.arrow_forward_ios,color: AppColors.mainColor,),
                  ),
                ),
              ),
              Align(
                heightFactor:7.5/5.3 ,
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: (){
                    Get.to(const OrdersScreen());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: Dimensions.width10*1.5,),
                      Container(
                        height: Dimensions.height10*5.3,
                        width: Dimensions.width10*5.3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.greyColor.withOpacity(0.5),
                        ),
                        child: Icon(Icons.shopping_bag_outlined,color: AppColors.mainColor,),
                      ),
                      SizedBox(width: Dimensions.width10*1.5,),
                      Text("My Orders",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: Dimensions.height10*1.8),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          //about us
          SizedBox(height: Dimensions.height10*2,),
          Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(Dimensions.width10*1.5),
                      onTap: (){
                        Get.to(const AboutUsScreen());
                      },
                      child: Container(
                        height: Dimensions.height10*7.5,
                        decoration: BoxDecoration(
                            color: AppColors.fieldColor,
                            borderRadius: BorderRadius.circular(Dimensions.width10*1.5)
                        ),),
                    ),
                  ),
                  SizedBox(width:Dimensions.width10*1.6 ,)
                ],
              ),
              Align(
                heightFactor:7.5/3.3 ,
                alignment: Alignment.centerRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(Dimensions.width10*1.5),
                  onTap: (){
                    Get.to(const AboutUsScreen());
                  },
                  child: Container(
                    height: Dimensions.height10*3.3,
                    width: Dimensions.width10*3.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.fieldColor,
                    ),
                    child: Icon(Icons.arrow_forward_ios,color: AppColors.mainColor,),
                  ),
                ),
              ),
              Align(
                heightFactor:7.5/5.3 ,
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: (){
                    Get.to(const AboutUsScreen());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: Dimensions.width10*1.5,),
                      Container(
                        height: Dimensions.height10*5.3,
                        width: Dimensions.width10*5.3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.greyColor.withOpacity(0.5),
                        ),
                        child: Icon(Icons.info_outline,color: AppColors.mainColor,),
                      ),
                      SizedBox(width: Dimensions.width10*1.5,),
                      Text("About Us",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: Dimensions.height10*1.8),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          //version
          SizedBox(height: Dimensions.height10*0.5,),
          Row(
            children: [
              const Spacer(),
              Text("version: ${AppConstants.appVersion}",style: TextStyle(color: AppColors.greyColor,fontSize: 15),),
            ],
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          CustomButton(
            onPressed: (){
              showDialog(context: context, builder: (context) => AlertDialog(
                title: const Text("Are you sure you want to Sign Out ?",style: TextStyle(fontSize: 16),),
                actions: [
                  TextButton(onPressed: (){
                    Get.back();
                    authController.logOut();
                  }, child: const Text("Yes",style: TextStyle(color: Colors.red),)),
                  TextButton(onPressed: (){
                    Get.back();
                  }, child: const Text("No",style: TextStyle(color: Colors.red),)),
                ],
              ),);

            },
            radius: 10,
            filledColor: Colors.red,
            buttonText:"Sign Out" ,
            height: Dimensions.height10 * 5,
            width: Dimensions.width10 * 10,
          )
        ],
      ),
    );
  }
}
