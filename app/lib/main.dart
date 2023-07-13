import 'package:app/main.dart';
import 'package:flutter/material.dart';

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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
    );
  }
}

class FormExample extends StatefulWidget{
  const FormExample ({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
   width: 380,
      padding: const EdgeInsets.all(20),
      child: Material(
        color: bgColor,
        key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,),
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
                height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No existing account yet?", 
                            style: TextStyle(
                            fontFamily: 'Poppins',
                            )
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                     foregroundColor: const Color.fromARGB(255, 57, 160, 148), // Text Color
                      ),
                    onPressed: (){
                    },
                    child: const Text("Register",
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
                    child: const Text('LOGIN',
                        style: TextStyle(
                            fontSize: 15,
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
