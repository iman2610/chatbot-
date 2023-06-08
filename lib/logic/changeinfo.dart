import 'dart:convert';
import 'package:firstapp/models/loginmodel.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';

const baseUrl = 'http://192.168.100.97:8080/';
const chagepwUrl = 'api/user/changeinfos/';

class Changeinfo {
  static Future<DataModel> changeinfo(
      String id, String name, String email, String phone) async {
    final apiUrl = '$baseUrl/$chagepwUrl';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode({
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
      }),
    );
    if (response.statusCode == 200) {
      // Registration successful, handle the response
      final data = jsonDecode(response.body);
      final user = DataModel.fromJson(data);
      print(user);

      // Do something with the response data

      return user;
    } else {
      // Registration failed, handle the error
      // final errorMessage = response.body;
      // // Do something with the error message
      // print(errorMessage);
    }
    throw 'Something went wrong ';
  }
}
