import 'package:flutter/material.dart';
import 'package:watercups/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          body: HomeScreen(),
        ));
  }
}
