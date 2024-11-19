import 'package:flutter/material.dart';
import 'package:myapp2/screens/carsScreen.dart';
import 'package:myapp2/screens/detailscreen.dart';
import 'package:myapp2/screens/modelsScreen.dart';
import 'package:myapp2/screens/loginscreen.dart';
import 'package:myapp2/screens/registerscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      initialRoute: '/',
      routes: {
        'SignupScreen': (context) => const SignupScreen(),
        'HomeScreen': (context) => const ModelScreen(),
        'CarsScreen': (context) => const CarScreen(),
        'detailsScreen': (context) => CarDetails()
      },
    );
  }
}
