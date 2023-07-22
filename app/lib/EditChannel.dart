import 'package:app/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChannelNameProvider()),
      ],
      child: const MaterialApp(
        title: 'EditChannel',
        home: DevicePage(),
      ),
    ),
  );
}

class DevicePage extends StatelessWidget {
  const DevicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Channel',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        toolbarHeight: 125,
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
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
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
                    padding: EdgeInsets.only(left: 10), // Add padding to the left of the profile picture
                    child: CircleAvatar(
                    radius: 25, // Set the radius for the profile picture size
                    backgroundImage: NetworkImage(channelNameProvider.profilePictureUrl),
                      ),
                          ),
                          SizedBox(width: 10), // Add spacing between the profile picture and the text
                          Text(
                            channelNameProvider.channelName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10), // Add spacing between the container and the button
                    Padding(
                      padding: EdgeInsets.only(right: 2),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Delete Channel'),
                                content: Text('Are you sure you want to delete this channel?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Code to delete the channel goes here
                                      // Replace the following line with the actual code to delete the channel
                                      print('Channel deleted!');
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    child: Text('No'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.delete),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(50, 66),
                          primary: Colors.blueGrey, // Set the desired height and width of the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0), // Adjust individual values for each corner
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
