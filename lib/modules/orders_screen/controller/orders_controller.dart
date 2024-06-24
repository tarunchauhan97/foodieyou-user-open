import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/models/address_model.dart';
import 'package:foodieyou/models/cart_model.dart';
import 'package:foodieyou/models/order_model.dart';
import 'package:foodieyou/shared/constants/constants.dart';
import 'package:http/http.dart' as http;

class OrdersController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    // TODO: implement onInit
    await getOrders();
    getToken();
    listenToNotification();
  }

  bool loading = false;
  void listenToNotification() {
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        debugPrint(event.notification!.body);
      }
    });
  }

  String generateUid(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random();
    final codeUnits = List.generate(length, (index) {
      final index = rand.nextInt(chars.length);
      return chars
          .codeUnitAt(index); // return integer code point instead of character
    });

    return String.fromCharCodes(codeUnits);
  }

  Future<void> setOrder(
      {String? paymentId,
      required String paymentMethod,
      required double totalPrice,
      required String contactPersonName,
      required String contactPersonNumber,
      required AddressModel addressModel,
      required List<CartModel> items}) async {
    String uid = generateUid(22);
    OrderModel order = OrderModel(
        paymentId: paymentId,
        paymentMethod: paymentMethod,
        id: uid,
        time: DateTime.now().toString(),
        state: "Pending",
        totalPrice: totalPrice,
        contactPersonName: contactPersonName,
        addressModel: addressModel,
        contactPersonNumber: contactPersonNumber,
        items: items);
    loading = true;
    update();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AppConstants.uid)
        .collection('orders')
        .doc(order.id)
        .set(order.toJson())
        .then((value) {
      runningOrders.insert(0, order);
      Get.snackbar("Order", "Your Order has been Added successfully",
          colorText: Colors.green);
    }).catchError((error) {
      Get.snackbar("Order", "Verify Your Order", colorText: Colors.red);

      debugPrint(error.toString());
    });
    loading = false;
    update();
  }

  List<OrderModel> runningOrders = [];
  List<OrderModel> historyOrders = [];

  CollectionReference ordersRef = FirebaseFirestore.instance
      .collection("users")
      .doc(AppConstants.uid)
      .collection('orders');

  Future<void> getOrders() async {
    loading = true;
    update();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AppConstants.uid)
        .collection('orders')
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['state'].toLowerCase() == "pending" ||
            element.data()['state'].toLowerCase() == "in process") {
          runningOrders.add(OrderModel.fromJson(element.data()));
        } else {
          historyOrders.add(OrderModel.fromJson(element.data()));
        }
        update();
      }
      listenToChanges();
    }).catchError((error) {
      debugPrint(error.toString());
    });
    loading = false;
    update();
  }

  void listenToChanges() {
    ordersRef.snapshots().listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        if (change.type == DocumentChangeType.modified) {
          OrderModel order =
              OrderModel.fromJson(change.doc.data()! as Map<String, dynamic>);
          if (order.state.toLowerCase() == 'in process') {
            runningOrders
                .firstWhere((element) => element.time == order.time)
                .state = order.state;
          } else {
            runningOrders.removeWhere((element) => element.time == order.time);
            historyOrders.insert(0, order);
          }
          Get.snackbar("Order Status", "Check Your Orders!!",
              colorText: Colors.green);
          sendNotification(
              title: "foodieyou",
              myBody: "Your order status has been changed to ${order.state}");
          update();
        } else if (change.type == DocumentChangeType.removed) {
          OrderModel order =
              OrderModel.fromJson(change.doc.data()! as Map<String, dynamic>);
          historyOrders.removeWhere((element) => element.id == order.id);
          update();
        }
      }
    }, onError: (error) {
      debugPrint(error.toString());
    });
  }

  Future<void> removeOrder(OrderModel model) async {
    historyOrders.removeWhere((element) => element == model);

    update();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AppConstants.uid)
        .collection('orders')
        .where('time', isEqualTo: model.time)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        await element.reference.delete();
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
    update();
  }

  Future<void> cancelOrder(OrderModel model, {bool fromHistory = false}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AppConstants.uid)
        .collection('orders')
        .where('time', isEqualTo: model.time)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        await element.reference.update({"state": "Canceled"});
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
    update();
  }

  Future<void> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      AppConstants.token = token ?? "";
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> sendNotification(
      {required String title, required String myBody}) async {
    try {
      // Set the FCM endpoint URL
      final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

      // Set the FCM server key
      final serverKey = AppConstants.serverKey;

      // Set the notification payload
      final notificationPayload = <String, dynamic>{
        'title': title,
        'body': myBody,
      };

      // Set the data payload
      final dataPayload = <String, dynamic>{
        'via': 'FlutterFire Cloud Messaging!!!',
      };

      // Set the request headers
      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      };

      // Set the request body
      final body = jsonEncode(<String, dynamic>{
        'notification': notificationPayload,
        'data': dataPayload,
        'to': AppConstants.token,
        'priority': 'high',
      });

      // Send the HTTP request
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        debugPrint('Notification sent successfully');
      } else {
        debugPrint('Error sending notification: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }
}
