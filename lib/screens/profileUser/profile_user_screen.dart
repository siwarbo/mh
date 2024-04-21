import 'package:alh/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:alh/widgetts/widgets.dart';
import 'package:flutter/material.dart';

class ProfileUser extends StatefulWidget {
  static const String routeName = '/user'; // Define route name

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProfileUser(),
    );
  }

  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  FirebaseAuthService _authService = FirebaseAuthService();
  String _email = '';
  String _role = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // Get current user's ID
      String? uid = _authService.getCurrentUserUID();
      // Fetch user data from Firestore
      String? email = await _authService.getUserEmailFromFirestore(uid!);
      String? role = await _authService.getUserRoleFromFirestore(uid!);

      setState(() {
        _email = email ?? 'N/A'; // Set email to 'N/A' if not found
        _role = role ?? 'N/A'; // Set role to 'N/A' if not found
      });
    } catch (error) {
      // Handle error
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      //bottomNavigationBar: BottomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/prof.jpg'), // Replace with your image path
            fit: BoxFit.cover, // Adjust image fit as needed
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User profile image widget
              CircleAvatar(
                radius: 100, // Adjust radius as needed
                backgroundImage: AssetImage(
                    'assets/images/ip.jpg'), // Replace with your image path
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.black), // Email icon
                  SizedBox(width: 10),
                  Text(
                    'Email:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                _email,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.black), // Role icon
                  SizedBox(width: 10),
                  Text(
                    'Role:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                _role,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
