import 'package:alh/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:alh/widgetts/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CheckoutScreen(),
    );
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                if (state is CheckoutLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CheckoutLoaded) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      //Navigator.pushNamed(context, '/order-confirmation');
                      context
                          .read<CheckoutBloc>()
                          .add(ConfirmCheckout(checkout: state.checkout));
                      Navigator.pushNamed(context, '/order-confirmation');
                    },
                    child: Text('ORDER NOW',
                        style: Theme.of(context).textTheme.headline5!),
                  );
                } else {
                  return Text('Something went wrong');
                }
              })
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
            if (state is CheckoutLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CUSTOMER INFORMATION',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 12),
                  ),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(email: value));
                  }, context, 'Email'),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(fullName: value));
                  }, context, 'Full Name'),
                  Text(
                    'DELIVERY INFORMATION',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 12),
                  ),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(address: value));
                  }, context, 'Address'),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(city: value));
                  }, context, 'City'),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(country: value));
                  }, context, 'Country'),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(zipCode: value));
                  }, context, 'ZIP Code'),
                  SizedBox(height: 20),
                  // Container(
                  //   height: 40,
                  //   alignment: Alignment.bottomCenter,
                  //   decoration: BoxDecoration(color: Colors.black),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //children: [
                      // Center(
                      //   child: TextButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(
                      //         context,
                      //         '/payment-selection',
                      //       );
                      //     },
                      //     child: Text(
                      //       'SELECT A PAYMENT METHOD',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline3!
                      //           .copyWith(fontSize: 12, color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.arrow_forward,
                      //     color: Colors.white,
                      //   ),
                      // )
                      //],
                    //),
                  //),
                  SizedBox(height: 10),
                  Text(
                    'ORDER SUMMARY',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 12),
                  ),
                  OrderSummary(),
                ],
              );
            } else {
              return Text('Something went wrong');
            }
          }),
        ),
      ),
    );
  }

  Padding _buildTextFormField(
    Function(String)? onChanged,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              labelText,
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 11),
            ),
          ),
          Expanded(
              child: TextFormField(
            onChanged: onChanged,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(left: 10),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
