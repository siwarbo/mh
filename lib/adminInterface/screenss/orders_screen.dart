import 'package:alh/screens/product/product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:alh/adminInterface/models/models.dart';
import 'package:alh/adminInterface/screenss/screenss.dart';
import 'package:alh/adminInterface/controllers/controlllers.dart';

import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OrdersScreen(),
    );
  }

  OrdersScreen({super.key});

  final OrderController orderController = Get.put(OrderController());
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.black,
      ),
      // body: Obx(() {
      //   return ListView.builder(
      //     itemCount: orderController.orders.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       final order = orderController.orders[index];
      //       return OrderCard(order: order);
      //     },
      //   );
      //}),

      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: orderController.pendingOrders.length,
                  itemBuilder: (BuildContext context, index) {
                    final order = orderController.pendingOrders[index];
                    return SizedBox(
                      child: OrderCard(
                        order: order,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Orders order;
  OrderCard({super.key, required this.order});
  final OrderController orderController = Get.find();
  final ProductController productController = Get.find();
  @override
  Widget build(BuildContext context) {
    var products = productController.products
        .where((product) => order.productIds.contains(product.id))
        .toList();
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order ID: ${order.id}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    //DateFormat('dd-MM-yyyy').format(order.createdAt),
                    DateFormat.ABBR_MONTH_DAY,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(
                            products[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 250,
                              child: Text(
                                products[index].description,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        )
                      ]),
                    );
                  }),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Delivery Fee",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${order.deliveryFee}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${order.total}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  order.isAccepted
                      ? ElevatedButton(
                          onPressed: () {
                            orderController.updateOrder(
                              order,
                              'isDelivered',
                              !order.isDelivered,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            minimumSize: const Size(150, 40),
                          ),
                          child: const Text(
                            "Deliver",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            orderController.updateOrder(
                              order,
                              'isAccepted',
                              !order.isAccepted,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            minimumSize: const Size(150, 40),
                          ),
                          child: const Text(
                            "Accept",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                  ElevatedButton(
                    onPressed: () {
                      orderController.updateOrder(
                          order, 'isCancelled', !order.isCancelled);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: const Size(150, 40),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
