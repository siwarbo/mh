import 'dart:io';

import 'package:alh/blocs/cart/cart_bloc.dart';
import 'package:alh/blocs/category/category_bloc.dart';
import 'package:alh/blocs/wishlist/wishlist_bloc.dart';
import 'package:alh/config/app_router.dart';
import 'package:alh/config/theme.dart';
//import 'package:alh/features/app/spash_screen/splash_screen.dart';
import 'package:alh/features/user_auth/presentation/pages/home_page.dart';
//import 'package:alh/repositories/category/category_repository.dart';
import '/repositories/repositories.dart';
import 'package:alh/screens/home/home_screen.dart';
import 'package:alh/features/user_auth/presentation/pages/login_page.dart';
import 'package:alh/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alh/screens/screens.dart';
import 'blocs/blocs.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WishlistBloc()..add(StartWishList())),
        BlocProvider(create: (_) => CartBloc()..add(CartStarted())),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(LoadCategories()),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'zero to unicon',
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => SplashScreen(
        //         // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
        //         child: LoginPage(),
        //       ),
        //   '/login': (context) => LoginPage(),
        //   '/signUp': (context) => SignUpPage(),
        //'/home': (context) => HomePage(),

        //},
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
