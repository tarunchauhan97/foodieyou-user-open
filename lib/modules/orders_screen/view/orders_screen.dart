import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/orders_screen/controller/orders_controller.dart';
import 'package:foodieyou/modules/orders_screen/view/widgets.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        centerTitle: true,
        title: const Text(
          "Orders",
          style: TextStyle(color: Colors.black,fontSize: 24),
        ),
      ),
      body: GetBuilder<OrdersController>(builder: (ordersController) {
        return ordersController.loading?Center(child: CircularProgressIndicator(color: AppColors.mainColor,)):Column(
          children: [
            TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                labelColor: AppColors.mainColor,
                controller: _tabController,
                labelStyle: const TextStyle(fontSize: 20),
                unselectedLabelColor: AppColors.greyColor,
                unselectedLabelStyle: const TextStyle(fontSize: 20),
                tabs: const [
                  Tab(
                    child: Text("Running",style: TextStyle(fontSize: 16),),
                  ),
                  Tab(
                    child: Text(
                        "History",style: TextStyle(fontSize: 16)
                    ),
                  ),

                ]),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: _tabController,
                children: [
                  ordersController.runningOrders.isEmpty?Column(
                    children: [
                      Image.asset("assets/images/emptyOrders.png",width: double.infinity,height: Dimensions.height10*50,),
                      const Text("There's no running orders yet !!")
                    ],
                  ):ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: ordersController.runningOrders.length,
                    separatorBuilder: (context, index) {
                      return divider();
                    },
                    itemBuilder: (context, index) {
                      return orderItems(ordersController.runningOrders[index],  context);
                    },),
                  ordersController.historyOrders.isEmpty?Column(
                    children: [
                      Image.asset("assets/images/emptyHistory.png",width: double.infinity,height: Dimensions.height10*50,),
                      const Text("Empty History !!")
                    ],
                  ):ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: ordersController.historyOrders.length,
                    separatorBuilder: (context, index) {
                      return divider();
                    },
                    itemBuilder: (context, index) {
                      return orderItems(ordersController.historyOrders[index],  context,inHistory: true);
                    },),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height10*1.5,)
          ],
        );
      },)
    );
  }
}
