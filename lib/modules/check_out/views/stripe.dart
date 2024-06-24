import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/check_out/controllers/check_out_controller.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

import '../../../shared/widgets/custom_button.dart';

class StripePayment extends StatefulWidget {
   const StripePayment({Key? key}) : super(key: key);

  @override
  State<StripePayment> createState() => _StripePaymentState();
}

class _StripePaymentState extends State<StripePayment> {
  final cardFormController=CardFormEditController();
  @override
  void initState() {
    // TODO: implement initState
    cardFormController.addListener(update);
    super.initState();
  }
  void update() => setState(() {});

  @override
  void dispose() {
    // TODO: implement dispose
    cardFormController.removeListener(update);
    cardFormController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay with a Credit Card'),
      ),
      body: GetBuilder<CheckOutController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(Dimensions.height10 * 2),
              child: Column(
                children: [
                  CardFormField(
                    enablePostalCode: false,
                    controller: cardFormController,
                    onCardChanged: (details) {
                      // print(cardFormController.details.);
                    },
                    style: CardFormStyle(
                      backgroundColor: AppColors.mainColor,
                      placeholderColor: Colors.white,
                      cursorColor: Colors.black54,
                      borderColor: AppColors.mainColor,
                      textColor: Colors.black,
                    ),
                  ),
                  cardFormController.details.complete!=true?CustomButton(
                    radius: 2,
                    onPressed: () async{
                      cardFormController.blur();
                      // print(controller.cardFormController.card?.number);
                      // controller.makePayment(cardNumber, expirationDate, cvc, amount, uid)
                    },
                    buttonText: "Pay",
                  ):Center(child: CircularProgressIndicator(color: AppColors.mainColor),)
                ],
              )),
        );
      },)
    );
  }
}
