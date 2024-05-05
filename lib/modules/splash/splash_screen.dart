import 'dart:async';

import 'package:flutter/material.dart';

import '../on_boarding/onBoarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
    ()=>Navigator.pushReplacement(
        context,
        MaterialPageRoute(
        builder: (context) => OnBoardingScreen()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Theme(
      data: ThemeData(
        brightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(248, 251, 255, 1),
        body: Center(
          child: Image(
              image: AssetImage('assets/images/iconIm.png')
          ),
        ),
      ),
    );
  }
}
