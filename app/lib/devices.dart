import 'dart:convert';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:app/scan.dart';

Map<String, int> userDeviceCount = {};

var gridChild = <Widget>[];

Future<void> unregisterDevice(BuildContext context, String userID,
    String deviceID, String tokenID) async {
  try {
    final response = await delete(
      Uri.parse(
          'https://ojt-relay-switch-api.vercel.app/api/devices/unregister?userId=${userID}&deviceId=${deviceID}'),
      headers: {'auth_token': tokenID},
      // No need to send a body for DELETE requests
    );

    if (response.statusCode == 200) {
      print('Device unregistered and removed successfully');
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
    }
  } catch (e) {
    print('Error: $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred while unregistering the device.'),
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
  }
}

Widget buildDeviceContainer(String name) {
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
        Row(
          children: [
            Icon(
              Icons.devices,
              color: Color.fromARGB(255, 32, 31, 31),
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            SizedBox(width: 10),
            IconButton(
                icon: Icon(
                  Icons.remove,
                  color: Colors.red,
                  size: 24.0,
                ),
                onPressed: () {
                  // unregisterDevice(context, userID, deviceID, tokenID);
                })
          ],
        ),
        Text('Device id: $name'),
      ],
    ),
  );
}

Future getDevices(String userId, String token) async {
  // Define your base URL
  var baseUrl =
      'https://ojt-relay-switch-api.vercel.app/api/devices?userId=${userId}';

  // Define your query parameters as a map
  var queryParameters = {'userId': userId};

  // Define your headers as a map
  var headers = {
    // Add any headers you need, such as authorization tokens, etc.
    'auth_token': token,
  };

  // Append the query parameters to the base URL
  var url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

  var response = await get(url, headers: headers);

  if (response.statusCode != 200) {
    print("HTTP GET REQUEST FAILED.");
    return 0; // Return 0 if the request fails
  } else {
    var jsonResponse = jsonDecode(response.body) as List<dynamic>;

    // Count the number of devices for each user
    for (var device in jsonResponse) {
      var user = device['user'];
      if (userDeviceCount.containsKey(user)) {
        userDeviceCount[user] = userDeviceCount[user]! + 1;
      } else {
        userDeviceCount[user] = 1;
      }
    }

    // Print the number of devices for each user
    userDeviceCount.forEach((user, count) {
      print('User $user has $count devices.');
    });

    // Return the count of devices for the specified user
    // Return the list of devices
    return jsonResponse;
  }
}

class DevicesPage extends StatefulWidget {
  final String userID;
  final String tokenID;
  DevicesPage({required this.userID, required this.tokenID, Key? key})
      : super(key: key);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  void initState() {
    super.initState();
    _loadDevices(); // Call the method to load devices when the page is first loaded
  }

  Future<void> _loadDevices() async {
    List<dynamic> devices = await getDevices(widget.userID, widget.tokenID);
    if (devices.isNotEmpty) {
      // Clear the gridChild list before adding new device containers
      gridChild.clear();

      // Add device containers for each device in the list
      for (var device in devices) {
        gridChild.add(buildDeviceContainer(device['name']));
      }

      // Force a rebuild of the widget to display the new device containers
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
          visible: gridChild.length < 4,
          child: FloatingActionButton(
            backgroundColor: mainColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ScanPage(
                            gridChild: gridChild,
                            userID: widget.userID,
                            tokenID: widget.tokenID),
                    transitionDuration: const Duration(seconds: 0),
                    reverseTransitionDuration: const Duration(seconds: 0),
                  ));

              setState(() {
                gridChild.add(
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 238, 238, 238), // Change the background color
                      border: Border.all(
                        width: 3,
                        color: mainColor, // Change the border color
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              });
            },
          )),
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
