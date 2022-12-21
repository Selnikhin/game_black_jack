import 'package:flutter/material.dart';
import 'package:game_black_jack/screens/black_lack_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlackJackScreen(),
    );


  }
}
