import 'package:app/utils/overlay.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:app/devices.dart';
import 'package:app/main.dart';
import 'dart:convert';
import 'package:http/http.dart';

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
            pageBuilder: (context, animation, secondaryAnimation) =>
                DevicesPage(
              userID: userID,
              tokenID: tokenID,
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
        Icon(
          Icons.devices,
          color: Colors.pink,
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
        Text('Device id: $name'),
      ],
    ),
  );
}

class ScanPage extends StatefulWidget {
  final List<Widget> gridChild;
  final String userID;
  final String tokenID;

  ScanPage(
      {required this.gridChild,
      required this.userID,
      required this.tokenID,
      Key? key})
      : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanCompleted = false;

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset('assets/images/backIcon.png'),
          iconSize: 25,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/appBarBG.png'),
                  fit: BoxFit.fill)),
        ),
        centerTitle: true,
        title: const Text(
          'Scan QR code',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            MobileScanner(
              allowDuplicates: false,
              onDetect: (barcode, args) {
                if (!isScanCompleted) {
                  String code = barcode.rawValue ?? "---";
                  isScanCompleted = true;
                  getGUID(context, widget.userID, code, widget.tokenID);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Device registered!'),
                        content:
                            Text('You have successfully registered your device'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
              } else {
                // If registration fails, set isScanCompleted back to false
                closeScreen();
              }
            },
          ),
          Container(
            decoration: ShapeDecoration(
                shape: QrScannerOverlayShape1(
                  borderColor: Color(0xFF39A094),
                  borderRadius: 10,
                  borderLength: 40,
                  borderWidth: 15,
                  cutOutSize: 300,
                ),
              ),
            ),
        ],
        ),
      ),
    );
  }
}
