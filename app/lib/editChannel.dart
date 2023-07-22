import 'package:app/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditChannelPage extends StatefulWidget {
  const EditChannelPage({super.key});

  @override
  _EditChannelPageState createState() => _EditChannelPageState();
}

class _EditChannelPageState extends State<EditChannelPage> {

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
          'Edit Channel',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
              child: Container(
                height: 75,
                width: 450,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFD7D7D7),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<ChannelNameProvider>(
                      builder: (context, channelNameProvider, _) => Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    10), // Add padding to the left of the profile picture
                            child: CircleAvatar(
                              radius:
                                  25, // Set the radius for the profile picture size
                              backgroundImage: NetworkImage(
                                  channelNameProvider.profilePictureUrl),
                            ),
                          ),
                          SizedBox(
                              width:
                                  30),
                          Text(
                            'Edit ',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF393939),
                              decoration: TextDecoration.none,
                            ),
                          ), // Add spacing between the profile picture and the text
                          Text(
                            channelNameProvider.channelName,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF393939),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height:
                            10), // Add spacing between the container and the button
                    Padding(
                      padding: EdgeInsets.only(right: 2),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Delete Channel'),
                                content: Text(
                                    'Are you sure you want to delete this channel?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Code to delete the channel goes here
                                      // Replace the following line with the actual code to delete the channel
                                      print('Channel deleted!');
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: Text('No'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.delete, size: 35, color: Color(0xFFF46262),),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(90, 75), 
                          backgroundColor: Color(0xFFD9D9D9), // Set the desired height and width of the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  0), // Adjust individual values for each corner
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
