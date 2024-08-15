import 'dart:convert';

import 'package:flutter/physics.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/salary.model.dart';
import 'package:http/http.dart' as http;

const url = 'https://interview-test.digital.cz/api/salaries';

class SalaryService {
  final _storage = const FlutterSecureStorage();

  Future<List<Salary>> fetchSalaries() async {
    String? token = await _storage.read(key: 'jwtToken');
    if (token == null) {}
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body)['items'];
      final List<Salary> salaries = List<Salary>.from(
        jsonResponse.map((salary) => Salary.fromJson(salary)),
      );
      return salaries;
    } else {
      throw Exception('Failed to load salaries');
    }
  }
}
