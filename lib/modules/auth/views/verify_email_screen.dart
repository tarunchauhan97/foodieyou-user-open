import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/auth/controllers/verify_email_controller.dart';
import 'package:foodieyou/modules/started_screen/started_screen.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.mainColor
        ),
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
        elevation: 0.2,
        centerTitle: true,
        title: const Text(
          "Verify Email",
          style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w500),
        ),
      ),
      body: GetBuilder<VerifyEmailController>(builder: (verifyEmailController) {

        return Padding(

          padding:  EdgeInsets.symmetric(horizontal: Dimensions.width10*2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("A verification link has been sent to your email.",textAlign: TextAlign.center,),
              SizedBox(height: Dimensions.height10*2,),
              Image.asset("assets/images/Confirm.png"),
              CustomButton(onPressed: (){
                if(verifyEmailController.canResend) {
                  verifyEmailController.sendEmailVerification();
                }
              },buttonText: "Resend Email",radius: 15,fontSize: 20,icon: Icons.email,width: Dimensions.width10*28,
              filledColor: verifyEmailController.canResend?AppColors.mainColor:AppColors.greyColor,
              ),
              !verifyEmailController.canResend? Text("Please wait ${verifyEmailController.countdownDuration.inSeconds} seconds before resending.",style: const TextStyle(fontSize: 15),):const SizedBox(),
              SizedBox(height: Dimensions.height10*2,),
              CustomButton(onPressed: (){
                verifyEmailController.timer!.cancel();
                Get.offAll(const StartedScreen());
              },buttonText: "Cancel",radius: 15,fontSize: 20,width: Dimensions.width10*28,transparent: true,),

            ],
          ),
        );
      },)
    );
  }
}
