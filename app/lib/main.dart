import 'package:app/dashboard.dart';
import 'package:app/devices.dart';
import 'package:flutter/material.dart';
import 'package:app/login.dart';
import 'package:flutter/services.dart';
import 'package:app/homepage.dart';
import 'package:app/devices.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'EditProfile.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ChannelNameProvider()),
    ],
    child: const MaterialApp(
      title: 'EditChannel',
      home: MyApp(),
    ),
  ));
}

Color mainColor = const Color.fromARGB(255, 41, 155, 140);
Color bgColor = const Color.fromARGB(59, 238, 238, 238);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}
