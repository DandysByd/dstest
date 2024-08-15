import 'dart:convert';

import 'package:dstest/src/features/user/models/user_prototype.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

const url = 'https://interview-test.digital.cz/api/users';

class UserService {
  static Uri reformatedUri = Uri.parse(url);

  Future<List<User>> fetchUsers() async {
    final response = await http.get(reformatedUri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<User> users = List<User>.from(
        jsonResponse['items'].map((user) => User.fromJson(user)),
      );
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> addUser(UserPrototype user) async {
    final response = await http.post(reformatedUri, body: json.encode(user));
    if (response.statusCode != 200) {
      throw Exception('Failed to send user');
    } else {
      return User.fromJson(json.decode(response.body));
    }
  }

  Future<User> fetchSingleUser(String userId) async {
    final Uri reformatedUri = Uri.parse('$url/$userId');
    final response = await http.get(reformatedUri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return User.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<bool> removeUser(String userId) async {
    final Uri reformatedUri = Uri.parse('$url/$userId');
    final response = await http.delete(reformatedUri);
    if (response.statusCode != 204) {
      throw Exception('Failed to delete user');
    } else {
      return true;
    }
  }
}
