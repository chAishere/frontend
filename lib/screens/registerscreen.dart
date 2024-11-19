import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp2/screens/loginscreen.dart';
import 'package:myapp2/services/auth.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _email = '';
  String _password = '';
  String _name = '';

  void signupPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty && _name.isNotEmpty) {
      try {
        http.Response response =
            await AuthServices.register(_name, _email, _password);
        final responseMap = json.decode(response.body);

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          errorSnackBar(context, 'User Registred Successfully');
        } else {
          // Improved error handling
          String errorMessage = response.statusCode.toString();
          if (responseMap.containsKey('message')) {
            errorMessage = responseMap['message'];
          }

          errorSnackBar(context,
              errorMessage); // Ensure this function exists and works as intended
        }
      } catch (e) {
        errorSnackBar(context, 'An unexpected error occurred: $e');
      }
    } else {
      errorSnackBar(context, 'Please enter all required fields');
    }
  }

  void errorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void openloginScreen() {
    Navigator.of(context).pushReplacementNamed('LoginScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/login.png",
                    height: 250,
                  ),
                  Text(
                    'SIGN UP',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Welcome! sign up to become a member',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: 'name', border: InputBorder.none),
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: 'Email', border: InputBorder.none),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Password', border: InputBorder.none),
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: signupPressed,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                            child: Text(
                          'Sign UP',
                          style: GoogleFonts.robotoCondensed(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'already a member?',
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: openloginScreen,
                        child: Text(
                          'Sign IN now!',
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
