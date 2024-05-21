import 'package:alh/adminInterface/screenss/products_screen.dart';
// import 'package:alh/global/common/toast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
//import 'package:alh/adminInterface/screenss/screenss.dart';
import 'package:alh/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:alh/global/common/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  ///////////////////
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController =
      TextEditingController(); // Add controller for name

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose(); // Dispose name controller
    super.dispose();
  }

  //////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Admin Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    //Get.to(ProductsScreen());
                    //Get.toNamed('/products');
                    Navigator.pushNamed(context, '/products');
                  },
                  child: const Card(
                    child: Center(
                      child: Text('Go To Products'),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    //Get.to(ProductsScreen());
                    //Get.toNamed('/products');
                    Navigator.pushNamed(context, '/orders');
                  },
                  child: const Card(
                    child: Center(
                      child: Text('Go To Orders'),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    //Get.to(ProductsScreen());
                    //Get.toNamed('/products');
                    Navigator.pushNamed(context, '/role');
                  },
                  child: const Card(
                    child: Center(
                      child: Text('Go To Users'),
                    ),
                  ),
                ),
              ),

              /////////////////////////////////////////////////////////

              SizedBox(height: 20), // Add some space between buttons

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateUserPage(
                              createUserAccount: _createUserAccount,
                            )),
                  );
                },
                child: Text('Create User Account'),
              ),
///////////////////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////
  void _createUserAccount(String email, String password, String name) async {
    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        await _auth.pushUserDetailsToFirestore(email, name);
        showToast(message: "User account created successfully.");
      } else {
        showToast(message: "Failed to create user account. Please try again.");
      }
    } else {
      showToast(message: "Please enter email, password, and name.");
    }
  }

  ////////////////////////
}

///////////////////
class CreateUserPage extends StatelessWidget {
  final Function(String, String, String) createUserAccount;

  const CreateUserPage({Key? key, required this.createUserAccount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Role'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    String name = _nameController.text;
                    createUserAccount(email, password, name);
                  },
                  child: Text('Create User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
