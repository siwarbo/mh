import 'package:alh/adminInterface/screenss/products_screen.dart';
// import 'package:alh/global/common/toast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
//import 'package:alh/adminInterface/screenss/screenss.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Admin Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  //Get.to(ProductsScreen());
                  //Get.toNamed('/products');
                  Navigator.pushNamed(context, '/products');
                },
                child: const Card(
                  child: Center(
                    child: Text('Go To Products'),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  //Get.to(ProductsScreen());
                  //Get.toNamed('/products');
                  Navigator.pushNamed(context, '/orders');
                },
                child: const Card(
                  child: Center(
                    child: Text('Go To Orders'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
