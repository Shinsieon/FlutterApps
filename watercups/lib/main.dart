import 'package:flutter/material.dart';
import 'package:watercups/screens/login_screen.dart';

//import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(
              displayLarge: TextStyle(
                color: Colors.blue[700],
              ),
            ),
            cardColor: const Color(0xFFF4EDDB),
            colorScheme: ColorScheme.fromSwatch(
                backgroundColor: const Color(0xFFFFF5ee))),
        home: const Scaffold(
          body: LoginScreen(),
        ));
  }
}
