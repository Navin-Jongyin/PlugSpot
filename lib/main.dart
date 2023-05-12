import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Container(
          child: Transform.scale(
              scale: 1.5, child: Image.asset('images/PlugSpot_logonew.png')),
        ),
        duration: 3000,
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Palette.backgroundColor,
      ),
    );
  }
}
