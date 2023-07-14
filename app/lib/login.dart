import 'package:app/main.dart';
import 'package:app/register.dart';
import 'package:flutter/material.dart';
import 'package:app/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              const SizedBox(
                height: 50,
              ),
              const Image(image: AssetImage('assets/images/logo.png')),
              const SizedBox(
                height: 30,
              ),
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
              const SizedBox(
                height: 30,
              ),
              TextFormField(
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
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 215, 215, 215)),
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
                    contentPadding: EdgeInsets.all(20.0)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No existing account yet?",
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
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text("Register",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  width: 600,
                  height: 44.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the border radius as desired
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 181, 222, 195),
                        Color.fromARGB(255, 31, 189, 170)
                      ])),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text('LOGIN',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.none)),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
