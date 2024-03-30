import 'package:alh/global/common/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Acter3Page extends StatefulWidget {
  const Acter3Page({super.key});

  @override
  State<Acter3Page> createState() => _Acter3PageState();
}

class _Acter3PageState extends State<Acter3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Delivery Page"),
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
                  Navigator.pushNamed(context, '/deliveryPersonnel');
                },
                child: const Card(
                  child: Center(
                    child: Text('Go To Delivery'),
                  ),
                ),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 150,
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: InkWell(
            //     onTap: () {
            //       //Get.to(ProductsScreen());
            //       //Get.toNamed('/products');
            //       Navigator.pushNamed(context, '/orders');
            //     },
            //     child: const Card(
            //       child: Center(
            //         child: Text('Go To Orders'),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
