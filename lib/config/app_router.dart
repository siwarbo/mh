import 'package:alh/adminInterface/screenss/products_screen.dart';
import 'package:alh/models/models.dart';
import 'package:alh/screens/order_confirmation/order_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:alh/screens/screens.dart';

import '../screens/screens.dart';

//
import 'package:alh/adminInterface/screenss/screenss.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      // case SplashScreen.routeName:
      //   return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case ProfileUser.routeName: // Add route for ProfileUser screen
        return ProfileUser.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case OrderConfirmation.routeName:
        return OrderConfirmation.route();

      //
      case ProductsScreen.routeName:
        return ProductsScreen.route();
      case NewProductScreen.routeName:
        return NewProductScreen.route();

      case OrdersScreen.routeName:
        return OrdersScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
      ),
    );
  }
}
