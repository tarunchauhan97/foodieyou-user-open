import 'package:flutter/material.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 2),
          child: ListView(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle_rounded,
                    color: AppColors.mainColor,
                    size: Dimensions.width10*1.4,
                  ),
                  SizedBox(width: Dimensions.width10,),
                  Expanded(
                      child: Text(
                          "Welcome to the world of foodie bliss! We are a team of food enthusiasts, passionate about providing our users with the best possible food experience. Our app is dedicated to bring you the most diverse and delicious cuisine from all around the world, right at your fingertips.",
                      style: TextStyle(fontSize: Dimensions.width10*1.8),
                      ))
                ],
              ),
              SizedBox(height: Dimensions.height10*4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle_rounded,
                    color: AppColors.mainColor,
                    size: Dimensions.width10*1.4,
                  ),
                  SizedBox(width: Dimensions.width10,),
                  Expanded(
                      child: Text(
                        "With our app, you can discover and find the best local restaurants and cafes, and order food with just a few taps. Our easy-to-use interface and cutting-edge technology make food delivery faster and more convenient than ever before.",
                        style: TextStyle(fontSize: Dimensions.width10*1.8),
                      ))
                ],
              ),
              SizedBox(height: Dimensions.height10*4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle_rounded,
                    color: AppColors.mainColor,
                    size: Dimensions.width10*1.4,
                  ),
                  SizedBox(width: Dimensions.width10,),
                  Expanded(
                      child: Text(
                        "We are constantly working to expand our menu and improve our services to make sure you have the most amazing food journey with us. Whether you're in the mood for a classic dish or a unique twist on a classic, our app has something for everyone.",
                        style: TextStyle(fontSize: Dimensions.width10*1.8),
                      ))
                ],
              ),
              SizedBox(height: Dimensions.height10*4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle_rounded,
                    color: AppColors.mainColor,
                    size: Dimensions.width10*1.4,
                  ),
                  SizedBox(width: Dimensions.width10,),
                  Expanded(
                      child: Text(
                        "Join us on this culinary adventure, and let us treat your taste buds to the ultimate food experience. Bon appétit!",
                        style: TextStyle(fontSize: Dimensions.width10*1.8),
                      ))
                ],
              ),
              SizedBox(height: Dimensions.height10*4,),
            ],
          )),
    );
  }
}
