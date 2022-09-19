import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
        child: Image.asset(
          'assets/logo.webp',
          scale: 1.5,
        ),
      ),
    );
  }
}
