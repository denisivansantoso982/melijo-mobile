// ignore_for_file: non_constant_identifier_names

import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/firebase/database.dart';
import 'package:melijo/configs/preferences/preferences.dart';

Preferences preferences = Preferences();
FDatabase database = FDatabase();
ApiRequest api_request = ApiRequest();

Future<int?> checkUserRole() async {
  final int? role = await preferences.checkUserRole();
  return Future.value(role);
}

Future<void> logout() async {
  try {
    final Map<String, dynamic> user_data = await preferences.getUser();
    await api_request.logout(user_data['token_type'], user_data['auth_token']);
    await database.deleteUserToken(user_data['id']);
    await preferences.deleteUser();
  } catch (error) {
    return Future.error(Exception(error));
  }
}

Future<Map> getUserInfo() async {
  return preferences.getUser();
}

Future<List<dynamic>> retrieveProvinces() async {
  try {
    List<dynamic> list_province = await api_request.getProvinces();
    return Future.value(list_province);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<dynamic>> retrieveCities(int id_province) async {
  try {
    List<dynamic> list_city = await api_request.getCities(id_province);
    return Future.value(list_city);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<dynamic>> retrieveDistricts(int id_city) async {
  try {
    List<dynamic> list_district = await api_request.getDistricts(id_city);
    return Future.value(list_district);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<dynamic>> retrieveVillages(int id_district) async {
  try {
    List<dynamic> list_village = await api_request.getVillages(id_district);
    return Future.value(list_village);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> login(String user, String password, bool is_seller) async {
  try {
    final Map<String, dynamic> response =
        await api_request.login(user, password);
    final Map<String, dynamic> user_data = response['user'];
    final String auth_token = response['token'];
    final String token_type = response['token_type'];
    if (is_seller && user_data['role_id'] != 4) {
      throw 'Pengguna tidak ditemukan!';
    } else if (!is_seller && user_data['role_id'] != 3) {
      throw 'Pengguna tidak ditemukan!';
    }
    final String fcm_token = await database.generateFCMToken();
    await database.setUserWhenLogin(user_data['id'], fcm_token);
    await preferences.setUserLogin(
      id: user_data['id'],
      role: user_data['role_id'],
      username: user_data['username'] ?? '',
      email: user_data['email'],
      fcm_token: fcm_token,
      auth_token: auth_token,
      token_type: token_type,
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> register(
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
    await api_request.register(name, email, phone, password, role_id, province,
        city, districts, village);
  } catch (error) {
    return Future.error(error);
  }
}
