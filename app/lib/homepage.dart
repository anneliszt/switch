// ignore_for_file: library_private_types_in_public_api

import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

Widget buildDeviceContainer(String deviceID) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 238, 238, 238),
      border: Border.all(
        width: 3,
        color: mainColor,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Icon(
          Icons.devices,
          color: Colors.pink,
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
        Text('Device id: $deviceID'),
      ],
    ),
  );
}

Future<bool> getGUID(BuildContext context, String userID, String deviceID,
    String tokenID) async {
  try {
    Response response = await post(
        Uri.parse(
            'https://ojt-relay-switch-api.vercel.app/api/devices/register?userId=${userID}&deviceId=${deviceID}'),
        headers: {'auth_token': tokenID},
        body: {'userId': userID, 'deviceId': deviceID});

    if (response.statusCode == 200) {
      print('Device registered successfully');
      // navigate to Grid
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Grid(
              deviceID: deviceID,
            ),
            transitionDuration: Duration(seconds: 5),
            reverseTransitionDuration: Duration(seconds: 0),
          ));
      return true;
    } else {
      var errorExtract = '${response.body}';
      // Parse the JSON response body
      Map<String, dynamic> responseBody = jsonDecode(errorExtract);

      // Extract the error message
      String errorMessage = responseBody['error'] ?? 'Unknown error';

      print('failed: ${response.body}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

int gridCount = 0;

class HomePage extends StatefulWidget {
  final String userID;
  final String tokenID;
  HomePage({required this.userID, required this.tokenID, Key? key})
      : super(key: key);

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
                onPressed: () {
                  String deviceID = 'de461c3b-5c20-45bc-bec8-9945558a5667';
                  getGUID(context, widget.userID, deviceID, widget.tokenID)
                      .then((success) {
                    if (success) {
                      // If registration is successful, update the gridChild with the device container
                      setState(() {
                        gridChild.add(buildDeviceContainer(deviceID));
                      });
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 238, 238, 238),
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
  final String deviceID;

  Grid({required this.deviceID, Key? key}) : super(key: key);

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: gridCount < 3
          ? FloatingActionButton(
              backgroundColor: mainColor,
              child: const Icon(Icons.add),
              onPressed: () {
                // Navigator.push(
                //      context,
                //      PageRouteBuilder(
                //        pageBuilder: (context, animation, secondaryAnimation) =>
                //            const ScanPage(),
                //        transitionDuration: const Duration(seconds: 0),
                //        reverseTransitionDuration: const Duration(seconds: 0),
                //      )
                //     );
                if (gridCount < 3) {
                  setState(() {
                    gridChild.add(
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 238, 238,
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
    );
  }
}

List<Widget> gridChild = [];
