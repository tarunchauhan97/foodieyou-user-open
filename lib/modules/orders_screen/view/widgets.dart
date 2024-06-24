import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:foodieyou/models/order_model.dart';
import 'package:foodieyou/modules/cart_screen/controllers/cart_controller.dart';
import 'package:foodieyou/modules/cart_screen/views/cart_screen.dart';
import 'package:foodieyou/modules/orders_screen/controller/orders_controller.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';

Widget orderItems(OrderModel order, context, {bool inHistory = false}) {
  OrdersController ordersController = Get.find<OrdersController>();

  Color color;
  switch (order.state.toLowerCase()) {
    case "in process":
      color = AppColors.mainColor;
      break;
    case "pending":
      color = Colors.amber;
      break;
    case "declined":
      color = Colors.red;
      break;
    case "canceled":
      color = AppColors.mainColor;
      break;
    default:
      color = Colors.green;
      break;
  }

  return Padding(
    padding: EdgeInsets.only(
        top: Dimensions.height10 * 2,
        right: Dimensions.height10 * 1.5,
        left: Dimensions.height10 * 1.5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              DateFormat(inHistory ? 'dd/MM/yyyy hh:mm a' : 'hh:mm a')
                  .format(DateTime.parse(order.time)),
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            order.state.toLowerCase() == "pending" ||
                    order.state.toLowerCase() == "in process"
                ? SizedBox(
                    width: Dimensions.width10 * 8,
                    child: LinearProgressIndicator(
                      color: order.state.toLowerCase() == "in process"
                          ? AppColors.mainColor
                          : Colors.amberAccent,
                      minHeight: 3.5,
                    ))
                : Container(),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.width10 * 0.6),
                color: color,
              ),
              width: Dimensions.width10 * 8,
              height: Dimensions.height10 * 2.2,
              child: Text(
                order.state,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            inHistory
                ? InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      ordersController.removeOrder(order);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                        size: Dimensions.height10 * 2.8,
                      ),
                    ))
                : Container()
          ],
        ),
        !inHistory
            ? SizedBox(
                height: Dimensions.height10,
              )
            : Container(),
        SizedBox(
          height: Dimensions.height10 * 10,
          child: Row(
            children: [
              Wrap(
                  children: List.generate(
                order.items.length > 3 ? 3 : order.items.length,
                (index) => Container(
                  margin: EdgeInsets.only(
                      right: Dimensions.width10,
                      top: Dimensions.height10 * 1.5),
                  width: Dimensions.width10 * 7,
                  height: Dimensions.height10 * 7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(order.items[index].product.img)),
                      borderRadius: BorderRadius.circular(Dimensions.height10)),
                ),
              )),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  inHistory
                      ? SizedBox(
                          height: Dimensions.height10,
                        )
                      : Container(),
                  Text(
                    'Total',
                    style: TextStyle(fontSize: Dimensions.height10 * 1.2),
                  ),
                  const Spacer(),
                  Text('${order.items.length} Items'),
                  const Spacer(),
                  order.state.toLowerCase() != "in process"
                      ? CustomButton(
                          onPressed: () {
                            if (inHistory) {
                              Get.find<CartController>().setCart(order.items);
                              Get.to(const CartScreen());
                            } else {
                              ordersController.cancelOrder(order);
                            }
                          },
                          transparent: true,
                          buttonText: inHistory ? "one more" : "Cancel",
                          height: Dimensions.height10 * 3,
                          width: Dimensions.width10 * 8,
                        )
                      : Container()
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget divider() => Container(
      margin: EdgeInsets.only(
          top: Dimensions.height10,
          right: Dimensions.width10 * 2,
          left: Dimensions.width10 * 2),
      height: 1,
      color: AppColors.mainColor,
    );
