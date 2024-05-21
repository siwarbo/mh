import 'package:alh/adminInterface/models/models.dart';
import 'package:alh/deliveryPersonnelInterface/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:alh/deliveryPersonnelInterface/delivery_model.dart';
import 'package:alh/deliveryPersonnelInterface/delivery_controller.dart';

import 'package:intl/intl.dart';
import 'package:alh/adminInterface/controllers/controlllers.dart';

class DeliveryPersonnelScreen extends StatefulWidget {
  static const String routeName = '/deliveryPersonnel';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => DeliveryPersonnelScreen(),
    );
  }

  DeliveryPersonnelScreen({super.key});

  @override
  State<DeliveryPersonnelScreen> createState() =>
      _DeliveryPersonnelScreenState();
}

class _DeliveryPersonnelScreenState extends State<DeliveryPersonnelScreen> {
  final DeliveryPersonnelController deliveryPersonnelController =
      Get.put(DeliveryPersonnelController());

  final ProductController productController = Get.put(ProductController());

  final DatabaseServices _databaseService = DatabaseServices();

  @override
  void initState() {
    super.initState();
    _databaseService.copyOrdersToDeliveryPersonnel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Personnel ',
          style: TextStyle(
            color: Colors
                .white, // Couleur du texte blanche pour une meilleure visibilité
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: deliveryPersonnelController
                      .pendingDeliveryPersonnel.length,
                  itemBuilder: (BuildContext context, index) {
                    final deliveryPersonnel = deliveryPersonnelController
                        .pendingDeliveryPersonnel[index];
                    return SizedBox(
                      child: DeliveryPersonnelCard(
                        deliveryPersonnel: deliveryPersonnel,
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

class DeliveryPersonnelCard extends StatelessWidget {
  final DeliveryPersonnel deliveryPersonnel;
  DeliveryPersonnelCard({super.key, required this.deliveryPersonnel});

  final DeliveryPersonnelController deliveryPersonnelController = Get.find();
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];

    // Fetch products based on their names
    deliveryPersonnel.productIds.forEach((productName) {
      Product? product = productController.products.firstWhere(
        (product) => product.name == productName,
      );
      if (product != null) {
        products.add(product);
      }
    });

    print(products);

    print(products);
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name : ${deliveryPersonnel.customerName}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "City : ${deliveryPersonnel.city}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Country : ${deliveryPersonnel.country}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Address : ${deliveryPersonnel.address}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    //DateFormat('dd-MM-yyyy').format(order.createdAt),
                    //DateFormat.ABBR_MONTH_DAY,
                    '❤️',
                    style: const TextStyle(
                      fontSize: 20,
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
                        "${deliveryPersonnel.deliveryFee}",
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
                        "${deliveryPersonnel.total}",
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
                  deliveryPersonnel.isAccepted
                      ? ElevatedButton(
                          onPressed: () {
                            deliveryPersonnelController.updateDeliveryPersonnel(
                              deliveryPersonnel,
                              'isDelivered',
                              !deliveryPersonnel.isDelivered,
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
                              color: Colors.white,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            deliveryPersonnelController.updateDeliveryPersonnel(
                              deliveryPersonnel,
                              'isAccepted',
                              !deliveryPersonnel.isAccepted,
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                  ElevatedButton(
                    onPressed: () {
                      deliveryPersonnelController.updateDeliveryPersonnel(
                          deliveryPersonnel,
                          'isCancelled',
                          !deliveryPersonnel.isCancelled);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: const Size(150, 40),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
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
