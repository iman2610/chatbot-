import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firstapp/models/loginmodel.dart';

import '../constants/constants.dart';

class ProfilePage extends StatefulWidget {
  final LoginModel model;
  const ProfilePage({Key? key, required this.model}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isUploaded = false;
  File? _image;
  String? url;

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name:',
          style: TextStyle(
              color: kContentColorLightTheme,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: kContentColorDarkTheme,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: kContentColorLightTheme,
                    blurRadius: 6,
                    offset: Offset(0, 2))
              ]),
          height: 60,
          child: Padding(
            padding: EdgeInsets.only(left: 15), // Adjust the value as needed
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: widget.model.name),
              style: TextStyle(color: kContentColorLightTheme),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmail() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TextStyle(
                color: kContentColorLightTheme,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: kContentColorDarkTheme,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: kContentColorLightTheme,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: Padding(
              padding: EdgeInsets.only(left: 15), // Adjust the value as needed
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: widget.model.email),
                style: TextStyle(color: kContentColorLightTheme),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone number',
          style: TextStyle(
              color: kContentColorLightTheme,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: kContentColorDarkTheme,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: kContentColorLightTheme,
                    blurRadius: 6,
                    offset: Offset(0, 2))
              ]),
          height: 60,
          child: Padding(
            padding: EdgeInsets.only(left: 15), // Adjust the value as needed
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: widget.model.phone),
              style: TextStyle(color: kContentColorLightTheme),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                isUploaded
                    ? _image != null
                        ? CircleAvatar(
                            radius: 40, backgroundImage: FileImage(_image!))
                        : _buildPlaceholderImage()
                    : _buildPlaceholderImage(),
                if (!isUploaded)
                  ElevatedButton(
                    onPressed: _uploadImage,
                    child: const Text('Upload Image'),
                  ),
                if (!isUploaded)
                  MaterialButton(
                    child: const Text('Select Image'),
                    onPressed: _selectImage,
                  ),
              ],
            ),
            SizedBox(height: 20),
            buildName(),
            SizedBox(height: 10), 
            buildEmail(),
            SizedBox(height: 10),
            buildPhone(),
            SizedBox(height: 10),
            // Add more fields from your LoginModel as needed
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return CircleAvatar(
      backgroundColor: kPrimaryColor,
      radius: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.person,
            size: 80,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> _uploadImage() async {
    if (_image == null) {
      print('No image selected.');
      return '';
    }
    isUploaded = true;
    setState(() {
      isUploaded = true;
    });

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(_image!);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadURL = await storageReference.getDownloadURL();
    url = downloadURL;
    print('$downloadURL -------------------');
    // Do something with the downloadURL, such as storing it in local storage

    print('Image uploaded successfully.');
    return downloadURL;
  }
}
