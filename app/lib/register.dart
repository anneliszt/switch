// ignore_for_file: library_private_types_in_public_api

import 'package:app/login.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:app/homepage.dart';
import 'dart:convert';
import 'package:http/http.dart';

void register(BuildContext context, String username, email, password,
    confirmPassword) async {
  try {
    Response response = await post(
        Uri.parse('https://ojt-relay-switch-api.vercel.app/api/register'),
        body: {'username': username, 'email': email, 'password': password});

    if (response.statusCode == 200) {
      if (password == confirmPassword) {
        print('Password match');
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Registration successful');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registration Successful'),
              content: Text('You have successfully registered'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  LoginPage(),
                          transitionDuration: Duration(seconds: 5),
                          reverseTransitionDuration: Duration(seconds: 0),
                        ));
                  },
                ),
              ],
            );
          },
        );
      } else {
        print('Password does not match');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registration unsuccessful'),
              content: Text('Password does not match'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  LoginPage(),
                          transitionDuration: Duration(seconds: 5),
                          reverseTransitionDuration: Duration(seconds: 0),
                        ));
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Account does not exist'),
            content: Text('Try registering an account first'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            LoginPage(),
                        transitionDuration: Duration(seconds: 5),
                        reverseTransitionDuration: Duration(seconds: 0),
                      ));
                },
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print(e.toString());
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      width: 350,
      padding: const EdgeInsets.all(20),
      child: Material(
          color: bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Image(image: AssetImage('assets/images/logo.png')),
              const SizedBox(
                height: 10,
              ),
              Text(
                'REGISTER',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromARGB(255, 215, 215, 215)),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromARGB(255, 18, 189, 169)),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Username',
                    hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 176, 176, 176)),
                    contentPadding: EdgeInsets.all(20.0),
                  )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromARGB(255, 215, 215, 215)),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromARGB(255, 18, 189, 169)),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 176, 176, 176)),
                    contentPadding: EdgeInsets.all(20.0),
                  )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromARGB(255, 215, 215, 215)),
                      borderRadius: BorderRadius.circular(50.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3, color: Color.fromARGB(255, 18, 189, 169)),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 176, 176, 176)),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromARGB(255, 215, 215, 215)),
                      borderRadius: BorderRadius.circular(50.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3, color: Color.fromARGB(255, 18, 189, 169)),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: 'Confirm Password',
                  hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 176, 176, 176)),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      )),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          const Color.fromARGB(255, 57, 160, 148), // Text Color
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  LoginPage(),
                          transitionDuration: Duration(seconds: 0),
                          reverseTransitionDuration: Duration(seconds: 0),
                        ),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              GestureDetector(
                onTap: () {
                  register(
                      context,
                      usernameController.text.toString(),
                      emailController.text.toString(),
                      passwordController.text.toString(),
                      confirmPasswordController.text.toString());
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the border radius as desired
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 181, 222, 195),
                        Color.fromARGB(255, 31, 189, 170)
                      ])),
                  child: Center(
                    child: Text('REGISTER',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.none)),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
