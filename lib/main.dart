import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:foodieyou/data/auth_repository/auth_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodieyou/shared/constants/constants.dart';
import 'package:foodieyou/shared/local/cache_helper.dart';
import 'package:foodieyou/shared/styles/themes/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey=AppConstants.stripePublishableKey;
  // await Stripe.instance.applySettings();

  await Firebase.initializeApp()
      .then((value) => Get.put(AuthenticationRepository()));
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint("Received message");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.lightTheme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(),
    );
  }
}
