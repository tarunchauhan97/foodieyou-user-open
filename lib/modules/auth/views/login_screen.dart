import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/auth/bindings/reset_password_bindings.dart';
import 'package:foodieyou/modules/auth/bindings/signup_bindings.dart';
import 'package:foodieyou/modules/auth/controllers/login_controller.dart';
import 'package:foodieyou/modules/auth/views/forget_password/forget_password_mail/reset_password_mail.dart';

import 'package:foodieyou/modules/auth/views/signup_screen.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';
import 'package:foodieyou/shared/widgets/custom_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    LogInController controller = Get.find<LogInController>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: Dimensions.height10 * 3.6),
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: Dimensions.height10 * 3,
                      color: AppColors.mainColor),
                ),
                Image.asset("assets/images/Logo12.png",height: Dimensions.height10*16,fit: BoxFit.cover,),
                Text(
                  "Add your details to login",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: Dimensions.height10 * 1.5,
                      color: AppColors.textColor),
                ),
                SizedBox(height: Dimensions.height10 * 3),
                CustomFormField(
                    hintText: "Your email",
                    prefixIcon: Icons.email,
                    controller: controller.email,
                    isEmail: true,
                    validator: controller.emailValidator),
                SizedBox(
                  height: Dimensions.height10 * 2.8,
                ),
                CustomFormField(
                    hintText: "Password",
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    controller: controller.password,
                    validator: controller.passwordValidator),
                SizedBox(
                  height: Dimensions.height10 * 1.5,
                ),
                //forget password
                Row(
                  children: [
                    const Spacer(),
                    MaterialButton(
                      onPressed: () {
                        Get.to(const ResetPasswordMailScreen(),binding: ResetPasswordBindings());
                      },
                      child: Text(
                        "Forget Password",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: Dimensions.height10 * 1.5,
                            color: AppColors.mainColor),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10 * 2,
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                //loginButton
                GetBuilder<LogInController>(builder: (controller) {
                  return controller.loading == true
                      ? Center(
                          child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ))
                      : CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.logIn(
                                  email: controller.email.text,
                                  password: controller.password.text);
                            }
                          },
                          buttonText: "Login",
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10 * 3.6),
                        );
                }),
                SizedBox(
                  height: Dimensions.height10 * 2.8,
                ),
                Text(
                  "OR",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: Dimensions.height10 * 2,
                      color: AppColors.textColor),
                ),
                // SizedBox(
                //   height: Dimensions.height10 * 2,
                // ),
                // //facebookButton
                // GetBuilder<LogInController>(builder: (controller) {
                //   return controller.loadingFacebook == true
                //       ? Center(
                //       child: CircularProgressIndicator(
                //         color: Colors.blue,
                //       ))
                //       : CustomButton(
                //     onPressed: () {
                //       controller.logInWithFacebook();
                //     },
                //     icon: Icons.facebook,
                //     buttonText: "Login with Facebook",
                //     margin: EdgeInsets.symmetric(
                //         horizontal: Dimensions.width10 * 3.6),
                //     filledColor: Colors.blue,
                //   );
                // }),
                SizedBox(
                  height: Dimensions.height10 * 2.8,
                ),
                //gmailButton
                GetBuilder<LogInController>(builder: (controller) {
                  return controller.loadingGoogle == true
                      ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ))
                      : CustomButton(
                    onPressed: () {
                      controller.logInWithGoogle();
                    },
                    icon: Icons.mail_outline,
                    buttonText: "Login with Google",
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.width10 * 3.6),
                    filledColor: Colors.red,
                  );
                }),
                SizedBox(
                  height: Dimensions.height10 ,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: Dimensions.height10 * 1.5,
                            color: AppColors.textColor),
                      ),
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.to(const SignUpScreen(),
                              curve: Curves.linear,
                              duration: const Duration(milliseconds: 200),
                              transition: Transition.rightToLeft,
                              binding: SignUpBindings());
                        },
                        child: Text(
                          " Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: Dimensions.height10 * 2,
                                  color: AppColors.mainColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
