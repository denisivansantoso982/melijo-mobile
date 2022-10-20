import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiRequest {
  final String baseUrl = '192.168.43.59:8000/api/';

  Future<dynamic> login(String user, String password) async {
    try {
      final String encodedBody = jsonEncode({
        'user': user,
        'password': password,
      });
      final http.Response response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        body: encodedBody,
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      return Future.value(data);
    } catch (error) {
      return Future.error(Exception(error));
    }
  }

  // Future<dynamic> register()
}
