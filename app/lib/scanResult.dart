import 'package:app/login.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ScanResult extends StatefulWidget {
  final String code;
  final Function() closeScreen;

  const ScanResult({super.key, required this.closeScreen, required this.code });
  
  @override
  _ScanResultState createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
         onPressed: () => Navigator.of(context).pop(),
          icon: Image.asset('assets/images/backIcon.png'),
          iconSize: 25,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/appBarBG.png'),
                  fit: BoxFit.fill
              )
          ),
        ),
        centerTitle: true,
        title: const Text(
                      'Scan QR code', 
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,),
                ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: const Center(
          child: Text(
            "Device scanned successfully",),
          )
        ),
    );
  } 
}