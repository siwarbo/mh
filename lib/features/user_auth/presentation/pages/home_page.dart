import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
            child: Text("Welcome Home buddy!",
                style: TextStyle(fontWeight: FontWeight.bold))),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, "/login");
          },
          child: Container(
            height: 45,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Sign out",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ),

        /////
        GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, "/login");
            print("Successfully signed out"); //
          },
          child: Container(
            height: 45,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Sign out",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        )
      ]),
    );
  }
}