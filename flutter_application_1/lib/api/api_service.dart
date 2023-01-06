import 'dart:convert';

import 'package:flutter_application_1/model/list_barang.dart';
import 'package:flutter_application_1/model/login.dart';
import 'package:flutter_application_1/model/register.dart';
import 'package:flutter_application_1/model/tambah_data.dart';
import 'package:http/http.dart' as http;

class LoginAPIService {
  Future<LoginResponse> login(LoginRequest requestModel) async {
    final response = await http.post(
        Uri.parse("http://159.223.57.121:8090/auth/login"),
        headers: {"content-type": "application/json"},
        body: jsonEncode(requestModel));
    if (response.statusCode == 401 || response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Login');
    }
  }
}

class RegisterAPIService {
  Future<RegisterResponse> register(RegisterRequest requestModel) async {
    final response = await http.post(
        Uri.parse("http://159.223.57.121:8090/auth/register"),
        headers: {"content-type": "application/json"},
        body: jsonEncode(requestModel));
    if (response.statusCode == 401 || response.statusCode == 200) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Register');
    }
  }
}
