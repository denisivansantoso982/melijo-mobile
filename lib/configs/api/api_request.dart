// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiRequest {
  // final String baseUrl = 'http://192.168.43.59:8000/api';
  final String baseUrl = 'http://192.168.100.191:8000/api';
  final String locationBaseUrl =
      'https://dev.farizdotid.com/api/daerahindonesia';
  late http.Client client;

  // ? Login
  Future<Map<String, dynamic>> login(String user, String password) async {
    try {
      client = http.Client();
      final Map body = {
        'email': user,
        'password': password,
      };
      final http.Response response = await client
          .post(
            Uri.parse('$baseUrl/auth/login'),
            headers: {
              'accept': 'application/json',
              'content-type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));
      final Map<String, dynamic> data = jsonDecode(response.body)['data'];
      return Future.value(data);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Register
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String phone,
    String password,
    int role_id,
    int province,
    int city,
    int districts,
    int village,
  ) async {
    try {
      client = http.Client();
      final Map body = {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'role_id': '$role_id',
        'province': '$province',
        'city': '$city',
        'districts': '$districts',
        'ward': '$village',
      };
      final http.Response response = await http
          .post(
            Uri.parse('$baseUrl/auth/register'),
            headers: {
              'accept': 'application/json',
              'content-type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));
      final Map<String, dynamic> data = jsonDecode(response.body)['data'];
      return Future.value(data);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Logout
  Future<void> logout(String token_type, String token) async {
    try {
      client = http.Client();
      await client.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {
          'Authorization': '$token_type $token',
        }
      );
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Provinces
  Future<List<dynamic>> getProvinces() async {
    try {
      client = http.Client();
      final http.Response response = await client.get(
        Uri.parse('$locationBaseUrl/provinsi'),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
        },
      );
      List<dynamic> data = jsonDecode(response.body)['provinsi'];
      return Future.value(data);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Cities or Regencies
  Future<List<dynamic>> getCities(int id_province) async {
    try {
      client = http.Client();
      final http.Response response = await client.get(
        Uri.parse('$locationBaseUrl/kota?id_provinsi=$id_province'),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
        },
      );
      List<dynamic> data = jsonDecode(response.body)['kota_kabupaten'];
      return Future.value(data);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Districts
  Future<List<dynamic>> getDistricts(int id_city) async {
    try {
      client = http.Client();
      final http.Response response = await client.get(
        Uri.parse('$locationBaseUrl/kecamatan?id_kota=$id_city'),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
        },
      );
      List<dynamic> data = jsonDecode(response.body)['kecamatan'];
      return Future.value(data);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Villages
  Future<List<dynamic>> getVillages(int id_district) async {
    try {
      client = http.Client();
      final http.Response response = await client.get(
        Uri.parse('$locationBaseUrl/kelurahan?id_kecamatan=$id_district'),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
        },
      );
      List<dynamic> data = jsonDecode(response.body)['kelurahan'];
      return Future.value(data);
    } catch (error) {
      return Future.error(error);
    }
  }
}
