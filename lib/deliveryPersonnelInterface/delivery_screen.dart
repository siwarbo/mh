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
        title: const Text('Delivery Personnel '),
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
  //final ProductController productController = Get.find();
  //final DatabaseServices db = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
      ),
    );
  }
}
