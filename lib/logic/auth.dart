import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firstapp/models/loginmodel.dart';

const baseUrl = 'http://192.168.100.97:8080/';
const loginUrl = 'api/user/login/';
const refreshUrl = '$baseUrl/api/token/refresh/';

class Auth {
  static String accessToken = '';
  static String refreshToken = '';
  static String id = '';
  final bool _requireConsent = false;

  Future<void> linitializeOnesignal() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId("50c2523b-ad83-4410-8945-c16f92a18b50");
    OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);
    OneSignal.shared.setExternalUserId('1');
  }

  Future<LoginModel> login(String email, String password) async {
    final apiUrl = '$baseUrl/$loginUrl';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'email': email,
        'password': password,
      },
    );

    final data = jsonDecode(response.body);
    // print(data);
    if (response.statusCode == 200) {
      accessToken = data['access'].toString();
      id = data['id'].toString();
      await saveTokens();
      final user = LoginModel.fromJson(data);
      print(user.name);
      return user;
    } else {
      print('error');
      throw 'Something went wrong ';
    }
  }

  static Future<String> refresh() async {
    final response = await http.post(
      Uri.parse(refreshUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );
    final data = jsonDecode(response.body);
    accessToken = data['access'];
    await saveTokens();
    return accessToken;
  }

  static Future<void> saveTokens() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    await prefs.setString('id', id);
  }

  static Future<String> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token') ?? '';
    refreshToken = prefs.getString('refresh_token') ?? '';
    id = prefs.getString('id') ?? '';

    return accessToken;
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('id');
  }

  static bool isAuthenticated() {
    if (accessToken.isNotEmpty && !JwtDecoder.isExpired(accessToken)) {
      return true;
    } else {
      return false;
    }
  }
}
