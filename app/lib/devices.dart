import 'dart:convert';
import 'package:app/channel.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:app/scan.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

Map<String, int> userDeviceCount = {};

var gridChild = <Widget>[];

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
  Future<void> _loadDevices(BuildContext context) async {
    EasyLoading.show(); // Show loading indicator
    List<dynamic> devices = await getDevices(widget.userID, widget.tokenID);
    if (devices.isNotEmpty) {
      // Clear the gridChild list before adding new device containers
      gridChild.clear();

      // Add device containers for each device in the list
      for (var device in devices) {
        gridChild.add(buildDeviceContainer(
          context,
          device['name'],
          widget.userID,
          device['_id'],
          device['deviceId'],
          widget.tokenID,
          device['status'],
        ));
        // Add the device to the allDevicesList
      }
      EasyLoading.dismiss();
      // Force a rebuild of the widget to display the new device containers
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDevices(
        context); // Call the method to load devices when the page is first loaded
  }

  Future<void> unregisterDevice(BuildContext context, String userID,
      String deviceID, String tokenID) async {
    try {
      final response = await delete(
          Uri.parse(
              'https://ojt-relay-switch-api.vercel.app/api/devices/unregister?userId=${userID}&deviceId=${deviceID}'),
          headers: {'auth_token': tokenID},
          body: {'userId': userID, 'deviceId': deviceID});

      if (response.statusCode == 200) {
        print("Unregistered device successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
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

  void handleUnregisterDevice(
      BuildContext context, String userID, String deviceID, String tokenID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content:
              const Text('Are you sure you want to unregister this device?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Unregister'),
              onPressed: () {
                unregisterDevice(context, userID, deviceID, tokenID);
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      // pageBuilder: (context, animation, secondaryAnimation) =>
                      //     HomePage(userID: userID, tokenID: token),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DevicesPage(userID: userID, tokenID: tokenID),
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

  Widget buildDeviceContainer(BuildContext context, String name, String userID,
      String device, String deviceID, String tokenID, String deviceStatus) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChannelPage(
              // device: device,
              deviceID: deviceID,
              tokenID: tokenID,
              name: name,
              deviceStatus: deviceStatus,
              userID: userID,
            ),
            transitionDuration: Duration(seconds: 5),
            reverseTransitionDuration: Duration(seconds: 0),
          ),
        );
      },
      child: Container(
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.do_not_disturb_on,
                    color: Colors.red,
                    size: 24.0,
                  ),
                  onPressed: () {
                    print("Unregister button");
                    handleUnregisterDevice(context, userID, deviceID, tokenID);
                  },
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.devices,
                  color: mainColor,
                  size: 80,
                ),
                Text('$name',
                    style: TextStyle(
                        color: Color.fromARGB(255, 79, 79, 79),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: gridChild.length < 4,
        child: FloatingActionButton(
          backgroundColor: mainColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ScanPage(
                  gridChild: gridChild,
                  userID: widget.userID,
                  tokenID: widget.tokenID,
                ),
                transitionDuration: const Duration(seconds: 0),
                reverseTransitionDuration: const Duration(seconds: 0),
              ),
            );
          },
        ),
      ),
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
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(10),
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
