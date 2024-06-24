import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/auth/controllers/reset_password_controller.dart';

import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';
import 'package:foodieyou/shared/widgets/custom_form_field.dart';

class ResetPasswordMailScreen extends StatefulWidget {
  const ResetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordMailScreen> createState() => _ResetPasswordMailScreenState();
}

class _ResetPasswordMailScreenState extends State<ResetPasswordMailScreen> {
  @override
  Widget build(BuildContext context) {
    final ResetPasswordController controller=Get.find<ResetPasswordController>();
    final formKey =GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height:Dimensions.height10*6,width: double.infinity,),
              Text(
                "Reset Password",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: Dimensions.height10*3,color: AppColors.mainColor)  ,
              ),
              SizedBox(height: Dimensions.height10,),
              SizedBox(
                width: Dimensions.width10*28.2,
                child: Text(
                  textAlign: TextAlign.center,
                  "Please enter your email to receive a link to  create a new password via email",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: Dimensions.height10*1.55,color: AppColors.textColor,height: 1.5),
                ),
              ),
              SizedBox(height: Dimensions.height10*4,),
              Image.asset('assets/images/resetPasswordEmail.png',height: Dimensions.height10*20,),
              SizedBox(height: Dimensions.height10*4,),
              CustomFormField(hintText: "Email",prefixIcon: Icons.email,validator: controller.emailValidator,controller: controller.email,),
              SizedBox(height: Dimensions.height10*4,),
             GetBuilder<ResetPasswordController>(builder: (controller) {
               return  controller.loading?Center(
                   child: CircularProgressIndicator(
                     color: AppColors.mainColor,
                   )): CustomButton(onPressed: (){
                 if(formKey.currentState!.validate()){
                   controller.sendPasswordResetEmail(controller.email.text);
                 }
               },buttonText: "Send",margin: EdgeInsets.symmetric(horizontal: Dimensions.width10*3.6),);
             },),
              SizedBox(height: Dimensions.height10*2.4,),

            ],
          ),
        ),
      ),
    );
  }
}
