// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences prefs;

  Future<void> setUserLogin({
    required int id,
    required String name,
    required int role,
    required String username,
    required String email,
    required String fcm_token,
    required String uid_firebase,
    required String address,
  }) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', id);
    prefs.setString('name', name);
    prefs.setInt('role', role);
    prefs.setString('username', username);
    prefs.setString('email', email);
    prefs.setString('fcm_token', fcm_token);
    prefs.setString('uid_firebase', uid_firebase);
    prefs.setString('address', address);
  }

  Future<int?> checkUserRole() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role');
  }

  Future<Map> getUser() async {
    prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getInt('id'),
      'name': prefs.getString('name'),
      'role': prefs.getInt('role'),
      'username': prefs.getString('username'),
      'email': prefs.getString('email'),
      'fcm_token': prefs.getString('fcm_token'),
      'uid_firebase': prefs.getString('uid_firebase'),
      'address': prefs.getString('address'),
    };
  }
}
