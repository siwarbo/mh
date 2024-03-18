import 'package:alh/widgetts/widgets.dart';
import 'package:flutter/material.dart';

class ProfileUser extends StatelessWidget {
  static const String routeName = '/user'; // Define route name

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProfileUser(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
