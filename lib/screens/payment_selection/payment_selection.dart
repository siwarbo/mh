import 'package:flutter/material.dart';

class PaymentSelection extends StatelessWidget {
  static const String routeName = '/payment-selection';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PaymentSelection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
