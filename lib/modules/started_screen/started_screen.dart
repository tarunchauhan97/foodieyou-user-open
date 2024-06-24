
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/auth/bindings/login_bindings.dart';
import 'package:foodieyou/modules/auth/bindings/signup_bindings.dart';
import 'package:foodieyou/modules/auth/views/login_screen.dart';
import 'package:foodieyou/modules/auth/views/signup_screen.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

class StartedScreen extends StatelessWidget {
  const StartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children:
              [
                SizedBox(height: Dimensions.height10*48.5,),
                Container(

                  height: Dimensions.height10*40.6,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Organetopshape.png"),
                          fit: BoxFit.fill
                      )),
                ),
                Positioned(
                  top: Dimensions.height10*25,
                  left:Dimensions.width10*6 ,
                  child: Container(
                    height: Dimensions.height10*34.5,
                    width: Dimensions.width10*28,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/Logo12.png"),
                            fit: BoxFit.fill
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.height10*2,),
          SizedBox(
            width: Dimensions.width10*30,
            height: Dimensions.height10*4.6,
            child: Text("Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep",style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,),

          ),
          SizedBox(height: Dimensions.height10*2,),
          CustomButton(onPressed: (){
            Get.off(const LoginScreen(),curve:Curves.linear,duration: const Duration(milliseconds: 100),transition: Transition.rightToLeft,binding: LoginBindings());
          },buttonText: "Login",margin: EdgeInsets.symmetric(horizontal: Dimensions.width10*3.6),),
          SizedBox(height: Dimensions.height10*2.8,),
          CustomButton(onPressed: (){
            Get.off(const SignUpScreen(),curve:Curves.linear,duration: const Duration(milliseconds: 100),transition: Transition.rightToLeft,binding: SignUpBindings());
          },buttonText: "Create an Account",margin: EdgeInsets.symmetric(horizontal: Dimensions.width10*3.6), transparent: true,),
          SizedBox(height: Dimensions.height10*2,),

        ],
      ),
    );
  }
}
