import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ChannelNameProvider with ChangeNotifier {
  String _channelName = 'Channel 1'; // Initial channel name
  String _profilePictureUrl =
      'https://example.com/default_profile_picture.png'; // Initial profile picture URL

  String get channelName => _channelName;
  String get profilePictureUrl => _profilePictureUrl;

  void setChannelName(String newName) {
    _channelName = newName;
    notifyListeners();
  }

  void setProfilePicture(String newUrl) {
    _profilePictureUrl = newUrl;
    notifyListeners();
  }
}

class EditProfileScreen extends StatelessWidget {
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 125,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<ChannelNameProvider>(
              builder: (context, channelNameProvider, _) => Align(
                alignment: Alignment
                    .topLeft, // Align the content to the upper-left corner
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30, // Set the radius for the profile picture size
                      backgroundImage:
                          NetworkImage(channelNameProvider.profilePictureUrl),
                    ),
                    SizedBox(
                        width:
                            20), // Add spacing between the profile picture and the text
                    Text(
                      channelNameProvider.channelName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Consumer<ChannelNameProvider>(
              builder: (context, channelNameProvider, _) => GestureDetector(
                onTap: () =>
                    _showChangePictureDialog(context, channelNameProvider),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height:
                        100, // Set the desired height of the rectangular container
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(channelNameProvider.profilePictureUrl),
                      ),
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 105,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: GestureDetector(
                  onTap: () => _showRenameDialog(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mode_edit), // Replace with your desired icon
                      SizedBox(width: 15),
                      // Add some spacing between the icon and the text
                      Text(
                        'Rename Channel 1',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  void _showRenameDialog(BuildContext context) {
    TextEditingController _channelNameController = TextEditingController();
    final channelNameProvider =
        Provider.of<ChannelNameProvider>(context, listen: false);
    _channelNameController.text = channelNameProvider.channelName;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rename Channel'),
          content: TextFormField(
            controller: _channelNameController,
            decoration: InputDecoration(
              labelText: 'New Channel Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newName = _channelNameController.text;
                channelNameProvider.setChannelName(newName);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePictureDialog(
      BuildContext context, ChannelNameProvider channelNameProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Profile Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      channelNameProvider.setProfilePicture(pickedImage.path);
                    }
                  },
                ),
                SizedBox(height: 16),
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      channelNameProvider.setProfilePicture(pickedImage.path);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Picture Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => ChannelNameProvider(),
        child: EditProfileScreen(),
      ),
    );
  }
}
