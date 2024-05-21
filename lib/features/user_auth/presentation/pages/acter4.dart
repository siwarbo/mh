import 'package:alh/global/common/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Acter4Page extends StatefulWidget {
  const Acter4Page({super.key});

  @override
  State<Acter4Page> createState() => _Acter4PageState();
}

class _Acter4PageState extends State<Acter4Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Manager Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
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
              Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/orders');
                  },
                  child: const Card(
                    child: Center(
                      child: Text('Go To Orders'),
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
                    Navigator.pushNamed(context, '/products');
                  },
                  child: const Card(
                    child: Center(
                      child: Text('Go To Products'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
