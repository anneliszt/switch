import 'package:app/devices.dart';
import 'package:flutter/material.dart';
import 'package:app/login.dart';
import 'package:flutter/services.dart';
import 'package:app/homepage.dart';
import 'package:app/devices.dart';

void main() {
  runApp(const MyApp());
}

Color mainColor = const Color.fromARGB(255, 41, 155, 140);
Color bgColor = const Color.fromARGB(59, 238, 238, 238);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
