import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void nextPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), nextPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            'assets/logo.webp',
            scale: 1.5,
          ),
        ),
      ),
    );
  }
}
