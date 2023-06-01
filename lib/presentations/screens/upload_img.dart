import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoPage extends StatefulWidget {
  const UploadPhotoPage({super.key});

  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  bool isUploaded = false;
  File? _image;
  String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isUploaded
                ? _image != null
                    ? Image.file(_image!)
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
                onPressed: () {
                  _selectImage();
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return const Icon(Icons.person);
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
