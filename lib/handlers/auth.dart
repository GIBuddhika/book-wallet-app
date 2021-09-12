import 'dart:convert';
import 'package:flutter_application_1/model/auth.dart';
import 'package:http/http.dart' as http;

class Auth {
  Future login(email, pass) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.8.102:8001/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': pass,
        }),
      );
      if (response.statusCode == 200) {
        return authDataFromJson(response.body);
      } else {
        throw Exception({'error': 'invalid_credentials'});
      }
    } catch (_) {
      throw Exception({'error': 'invalid_credentials'});
    }
  }
}
