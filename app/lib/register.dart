import 'package:app/login.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

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
                height: 10,),
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
                height: 30,),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    borderSide:
                      const BorderSide(width: 3, color: Color.fromARGB(255,215,215,215)),
                    borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderSide:
                      const BorderSide(width: 3, color: Color.fromARGB(255,215,215,215)),
                    borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Username',
                    hintStyle: const TextStyle(fontFamily: 'Poppins')),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    borderSide:
                      const BorderSide(width: 3, color: Color.fromARGB(255,215,215,215)),
                    borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderSide:
                      const BorderSide(width: 3, color: Color.fromARGB(255,215,215,215)),
                    borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Email',
                    hintStyle: const TextStyle(fontFamily: 'Poppins')),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                      const BorderSide(width: 3, color: Color.fromARGB(255,215,215,215)),
                    borderRadius: BorderRadius.circular(50.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderSide:
                      const BorderSide(width: 3, color: Color.fromARGB(255,215,215,215)),
                    borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(fontFamily: 'Poppins')),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                      const BorderSide(width: 3, color: Color.fromARGB(255,215,215,215)),
                    borderRadius: BorderRadius.circular(50.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderSide:
                      const BorderSide(width: 3, color: Color.fromARGB(255,215,215,215)),
                    borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: const TextStyle(fontFamily: 'Poppins')),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?", 
                            style: TextStyle(
                            fontFamily: 'Poppins',
                            )
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                     foregroundColor: const Color.fromARGB(255, 57, 160, 148), // Text Color
                      ),
                    onPressed: (){
                      Navigator.push(
                        context,
                         MaterialPageRoute(builder: (context) => const LoginPage())
                      );
                    },
                    child: const Text("Login",
                    style: TextStyle(
                            fontFamily: 'Poppins',
                            )),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text('REGISTER',
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
        )
      ),
    );
  }
}