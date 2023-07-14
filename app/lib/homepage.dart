import 'package:app/login.dart';
import 'package:app/main.dart';
import 'package:app/scan.dart';
import 'package:flutter/material.dart';
import 'package:app/homepage.dart';

List<Widget> gridChild = [
  Container(
    child: Column(children: [
      Text('Device `1'),
    ]),
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 238, 238, 238), // Change the background color
      border: Border.all(
        width: 3,
        color: mainColor, // Change the border color
      ),
      borderRadius: BorderRadius.circular(20),
    ),
  ),
];

int gridCount = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
      width: 350,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Material(
              color: bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 60,
                  ),
                  const Image(
                      image: AssetImage('assets/images/placeholder.png')),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Hello, User',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                ],
              )),
          Column(
            children: <Widget>[
              Text('No devices added yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                    decoration: TextDecoration.none,
                  )),
              Center(
                child: Text(
                    'To monitor a channel, you will \n \t\t\t need to add your device',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w100,
                      color: Colors.grey[600],
                      decoration: TextDecoration.none,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              // make elevated button
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ScanPage(),
                    transitionDuration: Duration(seconds: 0),
                    reverseTransitionDuration: Duration(seconds: 0),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 238, 238, 238),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 30),
                  // change stroke
                  side: const BorderSide(
                    width: 3,
                    color: Color.fromARGB(255, 41, 155, 140),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Add new device',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w100,
                    color: Color.fromARGB(255, 41, 155, 140),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: gridCount < 3
            ? FloatingActionButton(
                backgroundColor: mainColor,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ScanPage(),
                            transitionDuration: Duration(seconds: 0),
                            reverseTransitionDuration: Duration(seconds: 0),
                          ));
                  if (gridCount < 3) {
                    setState(() {

                      gridChild.add(
                        Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 238, 238,
                                238), // Change the background color
                            border: Border.all(
                              width: 3,
                              color: mainColor, // Change the border color
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                      gridCount++; // Increment the grid count
                    });
                  }
                },
              )
            : null,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              const Image(image: AssetImage('assets/images/placeholder.png')),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Hello, User',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(
                height: 75,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    gridChild.length,
                    (index) => gridChild[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
