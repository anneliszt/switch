import 'package:app/login.dart';
import 'package:app/main.dart';
import 'package:app/scanResult.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class ScanPage extends StatefulWidget {
  const ScanPage({super.key});
  
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanCompleted = false;

  void closeScreen(){
    isScanCompleted = false;
  }
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
        child: MobileScanner(
          allowDuplicates: true,
          onDetect: (barcode, args) {
            if (!isScanCompleted) {
              String code = barcode.rawValue ?? "---";
              isScanCompleted = true;
              Navigator.push(
                        context,
                         MaterialPageRoute(
                          builder: (context) => ScanResult (closeScreen: closeScreen, code: code,))
                      );
            }
          }, 
      ),
      ),
    );
  } 
}