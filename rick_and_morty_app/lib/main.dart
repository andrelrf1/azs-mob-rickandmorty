import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/screens/home/home_screen.dart';
import 'package:rick_and_morty_app/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
      },
      initialRoute: '/',
    );
  }
}
