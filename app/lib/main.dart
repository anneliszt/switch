import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:app/login.dart';

void main() {
  runApp(const MyApp());
}

Color mainColor = const Color.fromARGB(255, 41, 155, 140);
Color bgColor = const Color.fromARGB(255, 238, 238, 238);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        home:HomePage(),
        );
  }
}

class HomePage extends StatefulWidget {
  const HomePage ({super.key});

  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          const Image(image: AssetImage('assets/images/logo.png')),
          const SizedBox(
                height: 50,),
          Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: mainColor,
              decoration: TextDecoration.none,
            ),
          ),
          const FormExample(),
        ],
      ),
    );
  }
}