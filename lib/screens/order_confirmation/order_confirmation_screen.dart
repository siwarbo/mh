import 'package:alh/blocs/cart/cart_bloc.dart';
import 'package:alh/widgetts/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import '/models/models.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OrderConfirmation(),
    );
  }

  // Define a separate method for building the cart item list
  Widget _buildCartItemList(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return _buildListView(state.cart);
        } else {
          return CircularProgressIndicator(); // Or any loading indicator
        }
      },
    );
  }

// Define a separate method for building the ListView
  Widget _buildListView(Cart cart) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cart.productQuantity(cart.products).keys.length,
      itemBuilder: (context, index) {
        var product = cart.productQuantity(cart.products).keys.elementAt(index);
        var quantity =
            cart.productQuantity(cart.products).values.elementAt(index);
        return OrderSummaryProductCard(
          product: product,
          quantity: quantity,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Order Confirmation'),
      bottomNavigationBar: CustomNavBar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width - 100) / 2,
                  top: 125,
                  child: SvgPicture.asset(
                    'assets/svgs/garlands.svg',
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  top: 250,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Your order is complete!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi,',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Thank you for choosing our restaurant.',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'ORDER CODE: #k321-ekd3',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  ),
                  OrderSummary(),
                  SizedBox(height: 20),
                  Text(
                    'ORDER DETAILS',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  ),
                  Divider(thickness: 2),
                  SizedBox(height: 5),
                  _buildCartItemList(context),

                  // BlocBuilder<CartBloc, CartState>(
                  //   builder: (context, state) {
                  //     if (state is CartLoaded) {
                  //       return ListView.builder(
                  //         shrinkWrap: true,
                  //         padding: EdgeInsets.zero,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemCount: state.cart
                  //             .productQuantity(state.cart.products)
                  //             .keys
                  //             .length,
                  //         itemBuilder: (context, index) {
                  //           var product = state.cart
                  //               .productQuantity(state.cart.products)
                  //               .keys
                  //               .elementAt(index);
                  //           var quantity = state.cart
                  //               .productQuantity(state.cart.products)
                  //               .values
                  //               .elementAt(index);
                  //           return OrderSummaryProductCard(
                  //             product: product,
                  //             quantity: quantity,
                  //           );
                  //         },
                  //       );
                  //     } else {
                  //       return CircularProgressIndicator(); // Or any loading indicator
                  //     }
                  //   },
                  // ),
                  // ListView(
                  //   shrinkWrap: true,
                  //   padding: EdgeInsets.zero,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   children: [

                  //     // OrderSummaryProductCard(
                  //     //   product: Product.products[0],
                  //     //   quantity: 2,
                  //     // ),
                  //     // OrderSummaryProductCard(
                  //     //   product: Product.products[1],
                  //     //   quantity: 2,
                  //     // ),
                  //   ],
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/payment-selection',
                        );
                      },
                      child: Text(
                        'SELECT A PAYMENT METHOD',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
