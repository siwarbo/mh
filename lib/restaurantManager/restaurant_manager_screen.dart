import 'package:flutter/material.dart';


class RestauranManagerScreen extends StatefulWidget {
  static const String routeName = '/restaurantManager';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => RestauranManagerScreen(),
    );
  }

  RestauranManagerScreen({super.key});

  @override
  State<RestauranManagerScreen> createState() => _RestauranManagerScreenState();
}

class _RestauranManagerScreenState extends State<RestauranManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Manager '),
        backgroundColor: Colors.black,
      ),
      body: Column(),
    );
  }
}
