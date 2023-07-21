// ignore_for_file: library_private_types_in_public_api

import 'package:app/homepage.dart';
import 'package:app/login.dart';
import 'package:app/main.dart';
import 'package:app/scan.dart';
import 'package:flutter/material.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({super.key});

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
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
            const SizedBox(
                height: 20,
              ),
            Material(
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon( 
                    Icons.chevron_left,
                    color: Color(0xFF39A094),
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(
                      height: 40,
                    ), 
            Material(
                color: bgColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'DEVICE 1',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, color: Color(0xFFF46262), size: 13),
                        Text(
                          ' Inactive',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w100,
                            color: Color(0xFF889B8A),
                            decoration: TextDecoration.none,
                          )
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
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
                        )
                        ),
                        OutlinedButton.icon(
                          label: Text('Edit',
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
                              color: Color(0xFFF46262), 
                              width: 3),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            backgroundColor: Color(0xFFEEEEEE),
                          ),
                          onPressed: () {},)
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                )),
            Column(
              children: <Widget>[
                Text('No channels added',
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
                      'To keep track of your power\n \t\tconsumption, add a new\n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t channel',
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
                          LoginPage(),
                      transitionDuration: const Duration(seconds: 0),
                      reverseTransitionDuration: const Duration(seconds: 0),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 65, vertical: 18),
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

