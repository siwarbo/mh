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
        title: Text("Acter 4 Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "/login");
                showToast(message: "Successfully signed out ");
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
