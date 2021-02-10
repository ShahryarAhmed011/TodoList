
import 'package:flutter/material.dart';

import 'home_screen/home_screen.dart';


  const String SPLASH_SCREEN = 'Splash_Screen';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, HOME_SCREEN);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SplashScreen'),),
    );
  }
}
