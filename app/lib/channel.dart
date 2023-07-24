// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:app/dashboard.dart';
import 'package:app/homepage.dart';
import 'package:app/login.dart';
import 'package:app/main.dart';
import 'package:app/scan.dart';
import 'package:app/editChannel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'devices.dart';

List<Map<String, bool>> channelData = [];

var gridChild = <Widget>[];

class ChannelNameProvider with ChangeNotifier {
  String _channelName = 'Channel 1'; // Initial channel name

  String get channelName => _channelName;

  void setChannelName(String newName) {
    _channelName = newName;
    notifyListeners();
  }
}

// void _showRenameDialog(BuildContext context, String token) {
//   TextEditingController _channelNameController = TextEditingController();
//   final channelNameProvider =
//       Provider.of<ChannelNameProvider>(context, listen: false);
//   _channelNameController.text = channelNameProvider.channelName;

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Rename Channel'),
//         content: TextFormField(
//           controller: _channelNameController,
//           decoration: InputDecoration(
//             labelText: 'New Channel Name',
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               String newName = _channelNameController.text;
//               channelNameProvider.setChannelName(newName);
//               updateChannelName(token);
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text('Save'),
//           ),
//         ],
//       );
//     },
//   );
// }

Future updateChannelStatus(
    String token, String deviceId, String channelId) async {
  var baseUrl =
      'https://ojt-relay-switch-api.vercel.app/api/devices/channels?deviceId=${deviceId}&channelId=${channelId}';
  var headers = {
    'auth_token': token,
  };
  var queryParameters = {'deviceId': deviceId, 'channelId': channelId};

  var url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
  var response = await put(url, headers: headers);

  if (response.statusCode != 200) {
    print("HTTP PUT REQUEST FAILED.");
    return 0; // Return 0 if the request fails
  } else {
    var jsonResponse = jsonDecode(response.body) as List<dynamic>;
    return jsonResponse;
  }
}

// Future updateChannelName(String token) async {
//   var baseUrl =
//       'https://ojt-relay-switch-api.vercel.app/api/devices/update-channel-name?channelId=${channelId}';
//   var headers = {
//     'auth_token': token,
//   };
//   // var queryParameters = {'channelId': channelId};

//   var url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
//   var response = await put(url, headers: headers);

//   if (response.statusCode != 200) {
//     print("HTTP PUT REQUEST FAILED.");
//     return 0; // Return 0 if the request fails
//   } else {
//     var jsonResponse = jsonDecode(response.body) as List<dynamic>;
//     return jsonResponse;
//   }
// }

Future getChannels(String deviceId) async {
  // Define your base URL
  var baseUrl =
      'https://ojt-relay-switch-api.vercel.app/api/devices/channels?deviceId=${deviceId}';

  // Define your query parameters as a map
  var queryParameters = {'deviceId': deviceId};

  // Append the query parameters to the base URL
  var url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

  var response = await get(url);

  if (response.statusCode != 200) {
    print("HTTP GET REQUEST FAILED.");
    return 0; // Return 0 if the request fails
  } else {
    var jsonResponse = jsonDecode(response.body) as List<dynamic>;
    // Return the count of devices for the specified user
    // Return the list of devices
    return jsonResponse;
  }
}

Future getDevices(String deviceId, String token) async {
  // Define your base URL
  var baseUrl =
      'https://ojt-relay-switch-api.vercel.app/api/devices/channels?deviceId=${deviceId}';

  // Define your query parameters as a map
  var queryParameters = {'deviceId': deviceId};

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

    // Return the count of devices for the specified user
    // Return the list of devices
    return jsonResponse;
  }
}

Future<bool> addNewChannel(BuildContext context, String deviceID,
    String tokenID, String name, String deviceStatus) async {
  try {
    Response response = await post(
        Uri.parse(
            'https://ojt-relay-switch-api.vercel.app/api/devices/channels?deviceId=${deviceID}'),
        headers: {'auth_token': tokenID},
        body: {'deviceId': deviceID});

    if (response.statusCode == 200) {
      print('Channel added successfully');
      // navigate to Grid
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChannelPage(
              deviceID: deviceID,
              tokenID: tokenID,
              name: name,
              deviceStatus: deviceStatus,
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

class ChannelPage extends StatefulWidget {
  final String deviceID;
  final String tokenID;
  final String name;
  final String deviceStatus;

  ChannelPage(
      {required this.deviceID,
      required this.tokenID,
      required this.name,
      required this.deviceStatus,
      Key? key})
      : super(key: key);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  Future<void> _loadChannels(BuildContext context) async {
    ;
    EasyLoading.show(); // Show loading indicator
    List<dynamic> channels = await getChannels(widget.deviceID);
    if (channels.isNotEmpty) {
      // Clear the gridChild list before adding new device containers
      gridChild.clear();

      // Add device containers for each device in the list
      for (var channel in channels) {
        channelData.add({'status': channel['status']});
        gridChild.add(buildDeviceContainer(context, widget.deviceID,
            channel['name'], channel['_id'], channel['status']));

        // Add the device to the allDevicesList
      }

      channelData.forEach((channel) {
        bool status = channel['status']!;
        print("Status: $status");
      });

      EasyLoading.dismiss();
      // Force a rebuild of the widget to display the new device containers
      setState(() {});

      ;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadChannels(
        context); // Call the method to load devices when the page is first loaded
  }

  Widget buildDeviceContainer(BuildContext context, String deviceID,
      String name, String channelID, bool status) {
    int initialLabelIndex = status ? 1 : 0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DashboardPage(name: name),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child:
                      Icon(Icons.settings_remote, color: mainColor, size: 50),
                ),
                Text(
                  '$name',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),

                // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ToggleSwitch(
                    isVertical: true,
                    minWidth: 70.0,
                    minHeight: 50.0,
                    initialLabelIndex: initialLabelIndex,
                    cornerRadius: 10.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: ['OFF', 'ON'],
                    icons: [
                      FontAwesomeIcons.lightbulb,
                      FontAwesomeIcons.solidLightbulb,
                    ],
                    iconSize: 30.0,
                    activeBgColors: [
                      [Colors.black45, Colors.black26],
                      [Colors.yellow, Colors.orange]
                    ],
                    animate:
                        true, // with just animate set to true, default curve = Curves.easeIn
                    curve: Curves
                        .bounceInOut, // animate must be set to true when using custom curve
                    onToggle: (index) {
                      updateChannelStatus(
                          widget.tokenID, widget.deviceID, channelID);
                      print('switched to: $index');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool status = widget.deviceStatus == widget.deviceStatus;
    return Scaffold(
        floatingActionButton: Visibility(
          visible: gridChild.length < 4,
          child: FloatingActionButton(
            backgroundColor: mainColor,
            child: Icon(Icons.add),
            onPressed: () {
              addNewChannel(context, widget.deviceID, widget.tokenID,
                  widget.name, widget.deviceStatus);
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      color: Color(0xFF39A094),
                      size: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Material(
                  color: bgColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Consumer<ChannelNameProvider>(
                          //   builder: (context, channelNameProvider, _) =>
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          // ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.red,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print("Edit button");
                              // _showRenameDialog(context, widget.tokenID);

                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return AlertDialog(
                              //       title: Text('Rename Channel'),
                              //       content: TextFormField(
                              //         decoration: InputDecoration(
                              //           labelText: 'New Channel Name',
                              //         ),
                              //       ),
                              //       actions: [
                              //         TextButton(
                              //           onPressed: () {
                              //             Navigator.of(context)
                              //                 .pop(); // Close the dialog
                              //           },
                              //           child: Text('Cancel'),
                              //         ),
                              //         TextButton(
                              //           onPressed: () {
                              //             String newName =
                              //                 _channelNameController.text;
                              //             channelNameProvider
                              //                 .setChannelName(newName);
                              //             Navigator.of(context)
                              //                 .pop(); // Close the dialog
                              //           },
                              //           child: Text('Save'),
                              //         ),
                              //       ],
                              //     );
                              //   },
                              // );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            status
                                ? Icons.circle
                                : Icons
                                    .circle_outlined, // Use different icons based on the status
                            color: status
                                ? Colors.green
                                : Colors
                                    .red, // Use different colors based on the status
                            size: 13,
                          ),
                          Text(
                            status
                                ? ' Active'
                                : ' Inactive', // Use different text based on the status
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w100,
                              color: Colors.grey[600],
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Channels',
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                                decoration: TextDecoration.none,
                              )),
                          OutlinedButton.icon(
                            label: Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF46262),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            icon: Icon(
                              Icons.edit,
                              size: 20.0,
                              color: Color(0xFFF46262),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: Color(0xFFF46262), width: 3),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                              ),
                              backgroundColor: Color(0xFFEEEEEE),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        EditChannelPage(),
                                transitionDuration: Duration(seconds: 5),
                                reverseTransitionDuration: Duration(seconds: 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
              // Column(
              //   children: <Widget>[
              //     Text('No channels added',
              //         style: TextStyle(
              //           fontSize: 20,
              //           fontStyle: FontStyle.italic,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.bold,
              //           color: mainColor,
              //           decoration: TextDecoration.none,
              //         )),
              //     Center(
              //       child: Text(
              //           'To keep track of your power\n \t\tconsumption, add a new\n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t channel',
              //           style: TextStyle(
              //             fontSize: 14,
              //             fontFamily: 'Poppins',
              //             fontWeight: FontWeight.w100,
              //             color: Colors.grey[600],
              //             decoration: TextDecoration.none,
              //           )),
              //     ),
              //     const SizedBox(
              //       height: 20,
              //     ),
              //     // make elevated button
              //     ElevatedButton(
              //       onPressed: () => Navigator.push(
              //         context,
              //         PageRouteBuilder(
              //           pageBuilder: (context, animation, secondaryAnimation) =>
              //               LoginPage(),
              //           transitionDuration: const Duration(seconds: 0),
              //           reverseTransitionDuration: const Duration(seconds: 0),
              //         ),
              //       ),
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: const Color.fromARGB(255, 238, 238, 238),
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 65, vertical: 18),
              //         // change stroke
              //         side: const BorderSide(
              //           width: 3,
              //           color: Color.fromARGB(255, 41, 155, 140),
              //         ),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //       ),
              //       child: const Text(
              //         'Add new device',
              //         style: TextStyle(
              //           fontSize: 15,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w100,
              //           color: Color.fromARGB(255, 41, 155, 140),
              //           decoration: TextDecoration.none,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             PageRouteBuilder(
              //               pageBuilder:
              //                   (context, animation, secondaryAnimation) =>
              //                       LoginPage(),
              //               transitionDuration: Duration(seconds: 5),
              //               reverseTransitionDuration: Duration(seconds: 0),
              //             ));
              //       },
              //       child: Icon(
              //         Icons.home,
              //         color: Colors.white,
              //         size: 50,
              //       ),
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Color(0xFF39A094),
              //         shape: CircleBorder(),
              //         padding: EdgeInsets.all(10),
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 1),
                  children: List.generate(
                    gridChild.length,
                    (index) => gridChild[index],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
