import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firstapp/models/loginmodel.dart';

import '../../logic/changeinfo.dart';
import '../../logic/cubit/change_info_cubit.dart';
import '../constants/constants.dart';
import 'localizations.dart';

import '../../logic/auth.dart';

String? name;
String? email;
String? phone;
int? id;
const chageUrl = 'http://192.168.100.97:8080/api/user/changeurl/';
const imageUrlKey = 'profile_image_url';

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

  Future<void> getData() async {
    final data = await Auth().login('iman@gmail.com', '1234');
    // Changeinfo.changeinfo(id, name, email, phone)

    name = data.name;
    email = data.email;
    phone = data.phone;
    id = widget.model.id;
  }

  @override
  void initState() {
    getData();
    loadProfileImage();
    super.initState();
  }

  Future<void> loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    url = prefs.getString(imageUrlKey);
  }

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.translate('Name'),
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
            padding: EdgeInsets.only(left: 5), // Adjust the value as needed
            child: TextField(
              controller: TextEditingController(text: name),
              onChanged: (value) {
                // setState(() {
                name = value;
                // print(email);
                // });
              },
              // controller: _nameController,
              style: TextStyle(color: kContentColorLightTheme),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:
                    Icon(Icons.person, color: Color.fromARGB(255, 115, 82, 28)),
                // hintText: AppLocalizations.of(context)!.translate('Name'),
                hintStyle: TextStyle(color: kContentColorLightTheme),
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
            AppLocalizations.of(context)!.translate('Email'),
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
              padding: EdgeInsets.only(left: 5), // Adjust the value as needed
              child: TextField(
                controller: TextEditingController(text: email),
                onChanged: (value) {
                  // setState(() {
                  email = value;
                  // print(email);
                  // });
                },
                style: TextStyle(color: kContentColorLightTheme),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.email,
                        color: Color.fromARGB(255, 115, 82, 28)),
                    // hintText: AppLocalizations.of(context)!.translate('Email'),
                    hintStyle: TextStyle(color: kContentColorLightTheme)),
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
          AppLocalizations.of(context)!.translate('Phone number'),
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
            padding: EdgeInsets.only(left: 5), // Adjust the value as needed
            child: TextField(
              controller: TextEditingController(text: phone),
              onChanged: (value) {
                // setState(() {
                phone = value;
                // print(phone);
                // });
              },
              style: TextStyle(color: kContentColorLightTheme),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:
                    Icon(Icons.phone, color: Color.fromARGB(255, 115, 82, 28)),
                // hintText:
                //     AppLocalizations.of(context)!.translate('Phone number'),
                hintStyle: TextStyle(color: kContentColorLightTheme),
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
        title: Text(AppLocalizations.of(context)!.translate('Profile')),
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
                            radius: 60, backgroundImage: FileImage(_image!))
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
            SizedBox(height: 15),
            buildEmail(),
            SizedBox(height: 15),
            buildPhone(),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: kPrimaryColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: BlocConsumer<ChangeInfoCubit, ChangeInfoState>(
                      listener: (context, state) {
                        if (state is ChangeInfoSuccess) {
                          Navigator.pop(context);
                          name = state.infoModel.name;
                        } else if (state is ChangeInfoError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .translate('Check your credentials')),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            context.read<ChangeInfoCubit>().changeinfo(
                                  id.toString(),
                                  name.toString(),
                                  email.toString(),
                                  phone.toString(),
                                );
                            print(name);
                            print(email);
                            print(id);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: BlocBuilder<ChangeInfoCubit, ChangeInfoState>(
                            builder: (context, state) {
                              if (state is ChangeInfoLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                return Text(AppLocalizations.of(context)!
                                    .translate('Update'));
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    if (widget.model.profile != null) {
      return CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(url ?? widget.model.profile),
      );
    }
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
    if (widget.model.profile != null) {
      CircleAvatar(
        backgroundColor: kPrimaryColor,
        radius: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              url ??
                  widget
                      .model.profile, // Provide the URL of the image to display
              fit: BoxFit.cover,
            )
          ],
        ),
      );
    }

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(_image!);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadURL = await storageReference.getDownloadURL();
    url = downloadURL;
    print('$url -------------------');
    print(widget.model.profile);

    // Do something with the downloadURL, such as storing it in local storage

    print('Image uploaded successfully.');
    await changeurl();
    return downloadURL;
  }

  Future<bool> changeurl() async {
    final apiUrl = '$chageUrl';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode({"profile_image": "$url"}),
    );
    print('$url');
    print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Update successful
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(imageUrlKey, url!); // Save the image URL locally
      print('Profile image URL updated successfully.');
      return true;
    } else {
      // Update failed
      print('Failed to update profile image URL.');
      return false;
    }
  }
}
