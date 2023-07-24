// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'dart:convert';
import 'package:app/homepage.dart';
import 'package:app/login.dart';
import 'package:app/main.dart';
import 'package:app/scan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

<<<<<<< Updated upstream
Future<void> createNewDate(BuildContext context, date, String tokenID, String channelId) async {
  final response = await post(
    Uri.parse('https://ojt-relay-switch-api.vercel.app/api/devices/channel-set-date?channelId=${channelId}'),
    headers: {'auth_token': tokenID},
    body: jsonEncode(<String, String>{
      'date': date,
    }),
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
        print('API Response: $responseBody');
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album. Status Code: ${response.statusCode}, Message: ${response.body}');
  }
}

=======
Future<void> createNewDateOnChannel(String channelID, String tokenID, String date) async {
  final Uri uri = Uri.parse('https://ojt-relay-switch-api.vercel.app/api/devices/channel-set-date?channelId=$channelID');
  print('sending to $uri');
  final Map<String, String> body = {"date": date};
  print(body);

  final response = await post(
    uri,
    headers: {"auth_token":tokenID},
    body: body,
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    print('API Response: $responseBody');
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception with the response details.
    throw Exception('Failed to create a new date on the channel. Status Code: ${response.statusCode}, Body: ${response.body}');
  }
}

Future<void> createTimeout(String channelID, String tokenID, String time) async {
  final Uri uri = Uri.parse('https://ojt-relay-switch-api.vercel.app//api/devices/channel-set-timeout?channelId=$channelID');
  print('sending to $uri');
  final Map<String, String> body = {"timeout": time};
  print(body);

  final response = await post(
    uri,
    headers: {"auth_token":tokenID},
    body: body,
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    print('API Response: $responseBody');
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception with the response details.
    throw Exception('Failed to create a new date on the channel. Status Code: ${response.statusCode}, Body: ${response.body}');
  }
}

>>>>>>> Stashed changes
extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

class DashboardPage extends StatefulWidget {
<<<<<<< Updated upstream
  final String channelId;
  final String tokenID;
  final String name;
  final String deviceStatus;
  DashboardPage(
      {required this.channelId,
      required this.tokenID,
      required this.name,
      required this.deviceStatus,
=======
  final String channelID;
  final String tokenID;
  final String name;
  DashboardPage(
      {required this.channelID,
      required this.tokenID,
      required this.name,
>>>>>>> Stashed changes
      Key? key})
      : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  bool isOnSwitched = false;
  bool isOffSwitched = false;
  DateTime onSelectedDate = DateTime.now();
  DateTime offSelectedDate = DateTime.now();
  TimeOfDay onSelectedTime = TimeOfDay.now();
  TimeOfDay offSelectedTime = TimeOfDay.now();

  _onSelectTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: onSelectedTime,
      builder: (context, child) {
<<<<<<< Updated upstream
      return Theme(
=======
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), 
        child: Theme(
>>>>>>> Stashed changes
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: mainColor,
                    onPrimary: Colors.white, // <-- SEE HERE
                    onSurface: Color(0xFF393939),// <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: mainColor,// button text color
                    ),
                  ),
<<<<<<< Updated upstream
                ),
                child: child!,
              );
=======
                ), child: child!)
      );
>>>>>>> Stashed changes
    }, 
  );
    if (selected != null && selected != onSelectedDate) {
      setState(() {
        onSelectedTime = selected;
        String time = onSelectedTime.to24hours().toString();
        print('time: $time');
        createTimeout(widget.channelID, widget.tokenID, time);
      });
    }
  }


  _offSelectTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: offSelectedTime,
      builder: (context, child) {
<<<<<<< Updated upstream
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: mainColor,
            onPrimary: Colors.white, // <-- SEE HERE
            onSurface: Color(0xFF393939),// <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: mainColor,// button text color
            ),
          ),
        ),
        child: child!,
      );
    }, 
    );
=======
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), 
        child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: mainColor,
                    onPrimary: Colors.white, // <-- SEE HERE
                    onSurface: Color(0xFF393939),// <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: mainColor,// button text color
                    ),
                  ),
                ), child: child!)
      );
    }, 
  );
>>>>>>> Stashed changes
    if (selected != null && selected != onSelectedDate) {
      setState(() {
        offSelectedTime = selected;
        String formattedTime = offSelectedTime.to24hours().toString();
        createTimeout(widget.channelID, widget.tokenID, formattedTime);
      });
    }
  }

<<<<<<< Updated upstream
=======
//here
>>>>>>> Stashed changes
  _onSelectDate(BuildContext context, bool isOnSwitched) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: onSelectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: mainColor,
            onPrimary: Colors.white, // <-- SEE HERE
            onSurface: Color(0xFF393939),// <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: mainColor,// button text color
            ),
          ),
        ),
        child: child!,
      );
    }, 
    );
    if (selected != null && selected != onSelectedDate) {
      setState(() {
        onSelectedDate = selected;
<<<<<<< Updated upstream
        String formattedOnselectedDate = '${onSelectedDate.month}/${onSelectedDate.day}/${onSelectedDate.year}';
        createNewDate(context, formattedOnselectedDate, widget.tokenID, widget.channelId);
=======
        String formattedOnSelectedDate = DateFormat('MM/dd/yyyy').format(onSelectedDate).toString();
        createNewDateOnChannel(widget.channelID, widget.tokenID, formattedOnSelectedDate);
>>>>>>> Stashed changes
      });
    }
  }

    _offSelectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: offSelectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
      builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: mainColor,
            onPrimary: Colors.white, // <-- SEE HERE
            onSurface: Color(0xFF393939),// <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: mainColor,// button text color
            ),
          ),
        ),
        child: child!,
      );
    }, 
    );
    if (selected != null && selected != offSelectedDate) {
      setState(() {
        offSelectedDate = selected;
        String formattedOnSelectedDate = DateFormat('MM/dd/yyyy').format(offSelectedDate).toString();
        createNewDateOnChannel(widget.channelID, widget.tokenID, formattedOnSelectedDate);
      });
    }
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
        width: 450,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
                height: 20,
              ),
            Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon( 
                      Icons.chevron_left_outlined,
                      color: Color(0xFF39A094),
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon( 
                      Icons.notifications_outlined,
                      color: Color(0xFF393939),
                      size: 40,
                    ),
                  ),
                ],
              ),
            ), 
            Material(
                color: bgColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Text('Channel 1',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3EA496),
                          decoration: TextDecoration.none,
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.signal_cellular_alt_outlined, color: Color(0xFF393939), size: 50),
                          Text(
                            '45',
                            style: TextStyle(
                              fontSize: 60,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF393939),
                              decoration: TextDecoration.none,
                            )
                          ),
                          Text(
                            'kWh',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF393939),
                              decoration: TextDecoration.none,
                            )
                          ),
                        ],
                      ),
                      Text(
                          'Consumption today',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w100,
                            color: Color(0xFF959595),
                            decoration: TextDecoration.none,
                            height: -1,
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: 302,
                        decoration: BoxDecoration(
                          color: Color(0xFFE6E6E6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                                  Icons.warning_amber_rounded,
                                  size: 20.0,
                                  color: Color(0xFF959595),
                                ),
                            Text('Low Voltage',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF959595),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text('\t|',
                              style: TextStyle(
                                fontSize: 27,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFFD6D6D6),
                                decoration: TextDecoration.none,
                                height: 0,
                              ),
                            ),
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 20.0,
                              color: Color(0xFF959595),
                            ),
                            Text(
                              'High Voltage',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF959595),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.power_settings_new_outlined,
                            size: 22.0,
                            color: Color(0xFF393939),
                          ),
                          Text(' Channel Management',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF39A094),
                              decoration: TextDecoration.none,
                            )
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Scheduling power consumption helps save energy' 
                        ' by efficiently managing the usage of your devices',
                          style: TextStyle(
                          fontSize: 13.5,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w200,
                          color: Color(0xFF959595),
                          decoration: TextDecoration.none,
                        )
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Schedule Power On & Off',
                        style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF39A094),
                              decoration: TextDecoration.none,
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),        
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [   
                          Text(
                            'Power On',
                            style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF393939),
                                  decoration: TextDecoration.none,
                              ),
                            ), 
                          Switch(
                            value: isOnSwitched,
                            onChanged: (value) {
                              setState(() {
                                isOnSwitched = value;
                                print(isOnSwitched);
                              });
                            },
                            activeTrackColor: Color(0xFFADFFB5),
                            activeColor: Color(0xFF39A094),
                          ),          
                        ], 
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFD7D7D7),
                            ),
                            child:Icon(
                              Icons.date_range_outlined,
                              size: 25.0,
                              color: Color(0xFFFFFFFF),
                            ), 
                          ),
                          Container(
                            height: 40,
                            width: 135,
                            decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              width: 2, 
                              color: Color(0xFFD7D7D7)),
                                            ),
                            child:ElevatedButton(
                             onPressed: isOnSwitched
                              ? () => _onSelectDate(context, true)
                              : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Color(0xFFEEEEEE)),                    
                                child: Text(
                              '${onSelectedDate.month}/${onSelectedDate.day}/${onSelectedDate.year}',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: Color(0xFF393939),
                                decoration: TextDecoration.none,
                              ),
                            ),)
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 40,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFD7D7D7),
                            ),
                            child:Icon(
                              Icons.access_time_outlined,
                              size: 23.0,
                              color: Color(0xFFFFFFFF),
                            ), 
                          ),
                          Container(
                            height: 40,
                            width: 135,
                            decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              width: 2, 
                              color: Color(0xFFD7D7D7)),
                                            ),
                            child:ElevatedButton(onPressed: isOnSwitched ? () => _onSelectTime(context) : null,
                            style: ElevatedButton.styleFrom(
                                backgroundColor:Color(0xFFEEEEEE)),                    
                                child: Text(
                              '${onSelectedTime.to24hours()}',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: Color(0xFF393939),
                                decoration: TextDecoration.none,
                              ),
                            ),)
                          ),
                        ]
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [   
                          Text(
                            'Power Off',
                            style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF393939),
                                  decoration: TextDecoration.none,
                              ),
                            ), 
                          Switch(
                            value: isOffSwitched,
                            onChanged: (value) {
                              setState(() {
                                isOffSwitched = value;
                                print(isOffSwitched);
                              });
                            },
                            activeTrackColor: Color(0xFFADFFB5),
                            activeColor: Color(0xFF39A094),
                          ),          
                        ], 
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFD7D7D7),
                            ),
                            child:Icon(
                              Icons.date_range_outlined,
                              size: 25.0,
                              color: Color(0xFFFFFFFF),
                            ), 
                          ),
                          Container(
                            height: 40,
                            width: 135,
                            decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              width: 2, 
                              color: Color(0xFFD7D7D7)),
                                            ),
                            child:ElevatedButton(onPressed:isOffSwitched ? () => _offSelectDate(context) : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:Color(0xFFEEEEEE)),                    
                                  child: Text(
                                '${offSelectedDate.month}/${offSelectedDate.day}/${offSelectedDate.year}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF393939),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 40,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFD7D7D7),
                            ),
                            child:Icon(
                              Icons.access_time_outlined,
                              size: 23.0,
                              color: Color(0xFFFFFFFF),
                            ), 
                          ),
                          Container(
                            height: 40,
                            width: 135,
                            decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              width: 2, 
                              color: Color(0xFFD7D7D7)),
                                            ),
                            child:ElevatedButton(onPressed:isOffSwitched ? () => _offSelectTime(context) : null, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Color(0xFFEEEEEE)),                    
                                child: Text(
                              '${offSelectedTime.to24hours()}',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: Color(0xFF393939),
                                decoration: TextDecoration.none,
                              ),
                            ),)
                          ),
                        ]
                      ),      
                ],
              ),
            ),
             Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            LoginPage(),
                        transitionDuration: Duration(seconds: 5),
                        reverseTransitionDuration: Duration(seconds: 0),
                      ));
                },
                  child: Icon( 
                    Icons.home,
                    color: Colors.white,
                    size: 50,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF39A094),
                    shape: CircleBorder(), 
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}

