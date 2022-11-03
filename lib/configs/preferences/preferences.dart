// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences prefs;

  Future<void> setUserLogin({
    required int id,
    required int id_detail,
    required int role,
    required String name,
    required String username,
    required String email,
    required String phone,
    required String fcm_token,
    required String auth_token,
    required String token_type,
    required String? avatar,
    required String province,
    required String city,
    required String district,
    required String ward,
  }) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', id);
    prefs.setInt('id_detail', id_detail);
    prefs.setString('name', name);
    prefs.setInt('role', role);
    prefs.setString('username', username);
    prefs.setString('email', email);
    prefs.setString('phone', phone);
    prefs.setString('fcm_token', fcm_token);
    prefs.setString('auth_token', auth_token);
    prefs.setString('token_type', token_type);
    prefs.setString('avatar', avatar ?? '');
    prefs.setString('province', province);
    prefs.setString('city', city);
    prefs.setString('district', district);
    prefs.setString('ward', ward);
  }

  Future<void> setUserProfile({
    required int role,
    required String name,
    required String username,
    required String email,
    required String phone,
    required String? avatar,
  }) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setInt('role', role);
    prefs.setString('username', username);
    prefs.setString('email', email);
    prefs.setString('phone', phone);
    prefs.setString('avatar', avatar ?? '');
  }

  Future<int?> checkUserRole() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role');
  }

  Future<Map<String, dynamic>> getUser() async {
    prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getInt('id'),
      'id_detail': prefs.getInt('id_detail'),
      'name': prefs.getString('name'),
      'role': prefs.getInt('role'),
      'username': prefs.getString('username'),
      'email': prefs.getString('email'),
      'phone': prefs.getString('phone'),
      'fcm_token': prefs.getString('fcm_token'),
      'uid_firebase': prefs.getString('uid_firebase'),
      'auth_token': prefs.getString('auth_token'),
      'token_type': prefs.getString('token_type'),
      'avatar': prefs.getString('avatar'),
      'province': prefs.getString('province'),
      'city': prefs.getString('city'),
      'district': prefs.getString('district'),
      'ward': prefs.getString('ward'),
    };
  }

  Future<void> deleteUser() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
