import 'package:app/main.dart';
import 'package:flutter/material.dart';

void main ()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp ({super.key});

  @override
  Widget build (BuildContext context){
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Login(),
    )
  }
}

class Login extends State<Login> {
  @override
  Widget build (BuildContext context) {
  }
}