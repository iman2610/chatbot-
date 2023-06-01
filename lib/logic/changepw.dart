import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firstapp/models/UserModel.dart';

import 'auth.dart';

const baseUrl = 'http://192.168.100.97:8080/';
const chagepwUrl = 'api/user/changepasswords/';

class ChangePW {
  Future<bool> changepw(
      String oldpassword, String newpassword, String newpassword2) async {
    final apiUrl = '$baseUrl/$chagepwUrl';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode({
        'old_password': oldpassword,
        'password': newpassword,
        'password2': newpassword2,
      }),
    );
    if (response.statusCode == 200) {
      // Registration successful, handle the response
      // final responseData = jsonDecode(response.body);
      // Do something with the response data
      return true;
    } else {
      // Registration failed, handle the error
      // final errorMessage = response.body;
      // // Do something with the error message
      // print(errorMessage);
    }
    throw 'Something went wrong ';
  }
}
