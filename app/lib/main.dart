import 'package:flutter/material.dart';
import 'package:app/login.dart';
import 'package:app/register.dart';
import 'package:app/homepage.dart';

void main() {
  runApp(const MyApp());
}

Color mainColor = const Color.fromARGB(255, 41, 155, 140);
Color bgColor = Color.fromARGB(59, 238, 238, 238);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
