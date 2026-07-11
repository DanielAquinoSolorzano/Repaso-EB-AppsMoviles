import 'dart:convert';
import 'dart:io';

import 'package:book_app/features/auth/data/remote/login_request_dto.dart';
import 'package:book_app/features/auth/data/remote/login_response.dto.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl =
      'https://bookapp-gveteaa0dqf0eycn.eastus-01.azurewebsites.net/api/users/login';

  Future<LoginResponseDto> login(String email, String password) async {
    final Uri uri = Uri.parse(baseUrl);

    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        LoginRequestDto(email: email, password: password).toJson(),
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      return LoginResponseDto.fromJson(json);
    }
    throw Exception('Failed to login');
  }
}