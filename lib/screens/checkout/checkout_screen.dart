import 'package:flutter/material.dart';
import 'package:alh/widgetts/widgets.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController zipCodeController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/order');
                },
                child: Text('ORDER NOW',
                    style: Theme.of(context).textTheme.headline5!),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CUSTOMER INFORMATION',
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
            ),
            _buildTextFormField(emailController, context, 'Email'),
            _buildTextFormField(nameController, context, 'Full Name'),
            Text(
              'DELEVERY INFORMATION',
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
            ),
            _buildTextFormField(addressController, context, 'Address'),
            _buildTextFormField(cityController, context, 'City'),
            _buildTextFormField(countryController, context, 'Country'),
            _buildTextFormField(zipCodeController, context, 'Zip Code'),
            SizedBox(height: 20),
            Container(
              height: 40,
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
                            .copyWith(fontSize: 12, color: Colors.white),
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
            Text(
              'ORDER SUMMARY',
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
            ),
            OrderSummary(),
          ],
        ),
      ),
    );
  }

  Padding _buildTextFormField(
    TextEditingController controller,
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
            controller: controller,
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
