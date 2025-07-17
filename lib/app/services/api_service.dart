import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

class ApiService {
  static Future<Map<String, dynamic>?> login(
    String username,
    String password,
  ) async {
    final url = Uri.parse('${AppConstants.baseUrl}/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      print('Login gagal: ${response.body}');
      return null;
    }
  }

  static Future<bool> logout() async {
    final url = Uri.parse('${AppConstants.baseUrl}/logout');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Logout gagal: ${response.body}');
      return false;
    }
  }
}
