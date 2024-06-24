import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/auth/bindings/login_bindings.dart';
import 'package:foodieyou/modules/auth/controllers/signup_controller.dart';
import 'package:foodieyou/modules/auth/views/login_screen.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';
import 'package:foodieyou/shared/widgets/custom_form_field.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final SignUpController controller=Get.find<SignUpController>();
    final formKey =GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key:formKey ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:Dimensions.height10*2,),
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: Dimensions.height10*3,color: AppColors.mainColor)  ,
                ),
                Image.asset("assets/images/Logo12.png",height: Dimensions.height10*12,),
                Text(
                  "Add your details to Sign Up",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: Dimensions.height10*1.5,color: AppColors.textColor)  ,
                ),
                SizedBox(height: Dimensions.height10*2   ),
                CustomFormField(hintText: "Name",prefixIcon: Icons.person,controller:controller.name,isName: true,validator: controller.nameValidator,),
                SizedBox(height: Dimensions.height10*2.8,),
                CustomFormField(hintText: "Email",prefixIcon: Icons.email,controller:controller.email,isEmail: true,validator: controller.emailValidator),
                SizedBox(height: Dimensions.height10*2.8,),
                CustomFormField(hintText: "Mobile No",prefixIcon: Icons.phone_android,controller: controller.phone,isPhone: true,validator: controller.phoneValidator),
                SizedBox(height: Dimensions.height10*2.8,),
                CustomFormField(hintText: "Password",prefixIcon: Icons.lock,isPassword:true ,controller: controller.password,validator: controller.passwordValidator),
                SizedBox(height: Dimensions.height10*2.8,),
                CustomFormField(hintText: "Confirm Password",prefixIcon: Icons.lock,isPassword:true ,controller: controller.confirmPassword,validator: controller.confirmPasswordValidator,),
                SizedBox(height: Dimensions.height10*2,),
                GetBuilder<SignUpController>(builder: (controller){
                  return controller.loading==true?Center(child: CircularProgressIndicator(color: AppColors.mainColor,)):CustomButton(onPressed: (){
                    if(formKey.currentState!.validate()){

                      controller.register(email: controller.email.text, name: controller.name.text, phone: controller.phone.text, password: controller.password.text);
                    }
                  },buttonText: "Sign Up",margin: EdgeInsets.symmetric(horizontal: Dimensions.width10*3.6),);
                }),
                SizedBox(height: Dimensions.height10,),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: Dimensions.height10*1.5,color: AppColors.textColor)  ,
                      ),
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          Get.to(const LoginScreen(),curve:Curves.linear,duration: const Duration(milliseconds: 200),transition: Transition.rightToLeft,binding: LoginBindings());
                        },
                        child: Text(
                          " Login",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: Dimensions.height10*2,color: AppColors.mainColor)  ,
                        ),
                      ),
                    ],
                  ),        ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
