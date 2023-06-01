import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firstapp/models/userModel.dart';

const baseUrl = 'http://192.168.100.97:8080/';

class Regist {
  Future<bool> register(String email, String name, String password,
      String password2, String phone) async {
    final apiUrl = 'http://192.168.100.97:8080/api/user/register/';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'name': name,
        'password': password,
        'password2': password2,
        'phone': phone,
      }),
    );

    if (response.statusCode == 201) {
      return true;
      // Registration successful, handle the response
      // final responseData = jsonDecode(response.body);
      // // Do something with the response data
      // print(responseData);
    } else {
      // Registration failed, handle the error
      final errorMessage = response.body;
      // Do something with the error message
      return false;
    }
    // throw 'Something went wrong ';
  }
}
