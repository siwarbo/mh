import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Center(
    //       child: Image(
    //         image: AssetImage('assets/images/simple.png'),
    //         width: 125,
    //         height: 125,
    //       ),
    //     ),
    //     SizedBox(height: 30),
    //     Container(
    //       color: Colors.black,
    //       padding: const EdgeInsets.symmetric(
    //         vertical: 10,
    //         horizontal: 20,
    //       ),
    //       child: Text(
    //         'FoodFlow',
    //         style: Theme.of(context).textTheme.headline2!.copyWith(
    //               color: Colors.white,
    //               fontSize: 22,
    //             ),
    //       ),
    //     )
    //   ],
    // ));

///////////////////////////////////////////////////
    return Scaffold(
      body: Container(
        //color: Color.fromARGB(222, 177, 49, 3), // Arrière-plan jaune
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage('assets/images/logor.png'),
                width: 500, // Augmenter la taille du logo
                height: 500, // Augmenter la taille du logo
              ),
            ),
          ],
        ),

////////////////////
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Colors.white, Color.fromARGB(255, 222, 214, 214)],
        //   ),
        // ),
        // child: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Image.asset('assets/images/st.png'),
        //       SizedBox(height: 20.0),
        //       Text(
        //         'FoodFlow',
        //         style: TextStyle(
        //           fontSize: 60.0,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.blue,
        //         ),
        //       ),
        //       SizedBox(height: 20.0),
        //       Text(
        //         'Let the food flow to your house.',
        //         style: TextStyle(
        //           fontSize: 18.0,
        //           color: Colors.black,
        //         ),
        //       ),
        //     ],

        //),
        //),
      ),
    );
  }
}




//////////////////////////////////////////////
            //   SizedBox(height: 30),
            //   Container(
            //     decoration: BoxDecoration(
            //       color:Colors.yellow,
            //       borderRadius:
            //           BorderRadius.circular(10), // Ajouter des coins arrondis
            //     ),
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 15, // Augmenter le padding
            //       horizontal: 30, // Augmenter le padding
            //     ),
            //     child: Text(
            //       'FoodFlow !',
            //       textAlign: TextAlign.center, // Centrer le texte
            //       style: Theme.of(context).textTheme.headline2!.copyWith(
            //             color: Colors.green, // Texte en vert
            //             fontSize: 30, // Augmenter la taille du texte
            //             fontWeight: FontWeight.bold, // Rendre le texte en gras
            //           ),
            //     ),
            //   )



         
