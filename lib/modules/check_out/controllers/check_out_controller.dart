import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:foodieyou/shared/constants/constants.dart';

class CheckOutController extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    cardFormController = CardFormEditController();
  }
  late CardFormEditController cardFormController;
  int paymentIndex=1;

  void setPaymentIndex(int index){
    paymentIndex=index;
    update();
  }




  bool loading=false;
  Future<Map<String,dynamic>> makePayment(String amount) async {
      loading = true;
      update();
      final response = await http.post(
        Uri.parse(AppConstants.stripeServerlessFunctionUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': amount
        }),
      );
      final responseData = jsonDecode(response.body);
      loading=false;
      update();
      return responseData;


  }

  String? paymentId;

  Future<void> initPaymentSheet(String amount) async {
    try {
      // 1. create payment intent on the server
      final data = await makePayment(amount);
      paymentId=data['id'];
      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(

          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['client_secret'],
        ),
      );
      await Stripe.instance.presentPaymentSheet(
      );


      Get.snackbar( 'Payment Successful', 'Your payment was processed successfully!',colorText: Colors.green);
    } catch (e) {
      Get.snackbar( 'Error', '$e',colorText: Colors.red);
      rethrow;
    }
  }


}