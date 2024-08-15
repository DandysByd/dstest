import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'https://interview-test.digital.cz/api/auth-token';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{
        "email": email.toString(),
        "password": password.toString()
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<bool> logout() async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to log out');
    }
  }
}
