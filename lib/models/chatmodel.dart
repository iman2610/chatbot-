import 'dart:convert';

class chatmodel {
  final String response;
  final String date;

  chatmodel({
    required this.response,
    required this.date,
  });

  factory chatmodel.fromJson(Map<String, dynamic> json) {
    return chatmodel(
      response: utf8.decode(json['response'].codeUnits),
      date: utf8.decode(json['date'].codeUnits),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': utf8.encode(response),
      'date': utf8.encode(date),
    };
  }
}
