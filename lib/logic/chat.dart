import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chatmodel.dart';

const baseUrl = 'http://192.168.43.67:8000/';
const chat = '/ask/';

class Chat {
  Future<chatmodel> chat(String question) async {
    final apiUrl = 'http://192.168.100.97:8000/ask/?question=$question';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final chatbot = chatmodel.fromJson(data);
      print(chatbot.response);
      print(chatbot.date);
      return chatbot;
    } else {
      throw Exception('Failed to ask the question');
    }
  }
}
