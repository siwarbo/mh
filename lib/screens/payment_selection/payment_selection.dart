import 'package:alh/widgetts/custom_appbar.dart';
import 'package:alh/widgetts/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
//import 'package:paymee_flutter/paymee_flutter.dart';


class PaymentSelection extends StatefulWidget {
  static const String routeName = '/payment-selection';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PaymentSelection(),
    );
  }

  @override
  State<PaymentSelection> createState() => _PaymentSelectionState();
}

// class PaymeeTestPage extends StatelessWidget {
//   void initializePaymee() {
//     PaymeeFlutter.initialize(apiKey: 'pym_test_1DP5mmOlF5G5ag');
//   }

class _PaymentSelectionState extends State<PaymentSelection> {
  TextEditingController amtController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();

  void simulatePayment(int amount) {
    // Simulate a successful payment response
    print('Simulating payment of $amount TND (Tunisian Dinar)');
    // You can handle success or failure logic here
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Paymee'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Enter Card Number',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        initiateSobflousPayment();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Initiate Payment',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initiateSobflousPayment() {
    String cardNumber = _cardNumberController.text;
    if (isValidCardNumber(cardNumber)) {
      // Payment initiated successfully
      showSuccessMessage();
    } else {
      // Invalid card number
      showErrorMessage();
    }
  }

  bool isValidCardNumber(String cardNumber) {
    return cardNumber.length == 16;
  }

  void showSuccessMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Initiated Successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error: Invalid Card Number'),
          content: Text('Please enter a valid card number.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}





      // appBar: AppBar(title: Text('Sobflous Test')),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       TextFormField(
      //         controller: amtController,
      //         keyboardType: TextInputType.number,
      //         decoration: InputDecoration(labelText: 'Enter Amount (TND)'),
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () {
      //           if (amtController.text.isNotEmpty) {
      //             final amount = int.tryParse(amtController.text);
      //             if (amount != null) {
      //               simulatePayment(amount);
      //             } else {
      //               print('Invalid amount. Please enter a valid number.');
      //             }
      //           } else {
      //             print('Please enter an amount.');
      //           }
      //         },
      //         child: Text('Simulate Payment'),
      //       ),
      //     ],
      //   ),
      // ),
    //);
  //}
//}

  // late Razorpay _razorpay;
  // TextEditingController amtController = TextEditingController();

  // void openCheckout(amount) async {
  //   amount = amount * 100;
  //   var options = {
  //     'key': 'rzp_test_1DP5mmOlF5G5ag',
  //     'amount': amount,
  //     'name': 'Geeks for Geeks',
  //     'prfill': {'contact': '1234567890', 'email': 'test@gmail.com'},
  //     'external': {
  //       'wallets': ['paytm']
  //     }
  //   };
  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     debugPrint('Error : e');
  //   }
  // }

  // void handlePaymentSuccess(PaymentSuccessResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "Payment Succesful" + response.paymentId!,
  //       toastLength: Toast.LENGTH_SHORT);
  // }

  // void handlePaymentError(PaymentFailureResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "Payment Fail" + response.message!,
  //       toastLength: Toast.LENGTH_SHORT);
  // }

  // void handleExternalWallet(ExternalWalletResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "External Wallet" + response.walletName!,
  //       toastLength: Toast.LENGTH_SHORT);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _razorpay.clear();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _razorpay = Razorpay();
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomAppBar(title: 'Payment Selection'),
  //     bottomNavigationBar: CustomNavBar(),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: 100,
  //           ),
  //           Image.network(
  //             'https://miro.medium.com/v2/resize:fit:1100/format:webp/1*qUUATIBwysfZ6X5mds0KUg.png',
  //             height: 100,
  //             width: 300,
  //           ),
  //           SizedBox(height: 10),
  //           Text(
  //             'Welcome to Razorpay Payment',
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //               fontSize: 18,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //           SizedBox(
  //             height: 30,
  //           ),
  //           Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: TextFormField(
  //               cursorColor: Colors.black,
  //               autofocus: false,
  //               style: TextStyle(color: Colors.black),
  //               decoration: InputDecoration(
  //                   labelText: 'Enter Amount to be paid',
  //                   labelStyle: TextStyle(fontSize: 15.0, color: Colors.black),
  //                   border: OutlineInputBorder(
  //                       borderSide: BorderSide(
  //                     color: Colors.black,
  //                     width: 1.0,
  //                   )),
  //                   enabledBorder: OutlineInputBorder(
  //                       borderSide: BorderSide(
  //                     color: Colors.black,
  //                     width: 1.0,
  //                   )),
  //                   errorStyle:
  //                       TextStyle(color: Colors.redAccent, fontSize: 15)),
  //               controller: amtController,
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter Amount to be paid';
  //                 }
  //                 return null;
  //               },
  //             ),
  //           ),
  //           SizedBox(
  //             height: 30,
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               if (amtController.text.toString().isNotEmpty) {
  //                 setState(() {
  //                   int amount = int.parse(amtController.text.toString());
  //                   openCheckout(amount);
  //                 });
  //               }
  //             },
  //             child: Padding(
  //               padding: EdgeInsets.all(8.0),
  //               child: Text('Make Payment'),
  //             ),
  //             style: ElevatedButton.styleFrom(primary: Colors.green),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //}
//}
