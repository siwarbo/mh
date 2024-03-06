import 'dart:io';

import 'package:alh/features/app/spash_screen/splash_screen.dart';
import 'package:alh/features/user_auth/presentation/pages/home_page.dart';
import 'package:alh/features/user_auth/presentation/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyDhF0KbdcOKlV0ISJuGIf2wJRwPgocHRwM',
          appId: '1:865901728764:android:929a3d2c6976a10aa41879',
          messagingSenderId: '865901728764',
          projectId: 'alhm-3f712',
        ))
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(
              child: LoginPage(),
            ),
        '/home': (context) => HomePage(), // Define the '/home' route
      },
    );
  }
}
