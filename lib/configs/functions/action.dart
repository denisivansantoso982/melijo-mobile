// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:melijo/bloc/sellers/products/product_seller_bloc.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/firebase/database.dart';
import 'package:melijo/configs/preferences/preferences.dart';
import 'package:melijo/models/sellers/product_seller_model.dart';

Preferences preferences = Preferences();
FDatabase database = FDatabase();
ApiRequest api_request = ApiRequest();

String thousandFormat(int val) {
  String result = NumberFormat('#,##,000').format(val).replaceAll(',', '.');
  return result;
}

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
    final Map<String, dynamic> user_detail = response['detail'];
    if (is_seller && user_data['role_id'] != 4) {
      throw 'Pengguna tidak ditemukan!';
    } else if (!is_seller && user_data['role_id'] != 3) {
      throw 'Pengguna tidak ditemukan!';
    }
    final String auth_token = response['token'];
    final String token_type = response['token_type'];
    final String fcm_token = await database.generateFCMToken();
    await api_request.setFCMToken(user_data['id'], fcm_token);
    await database.setUserWhenLogin(user_data['id'], fcm_token);
    await preferences.setUserLogin(
      id: user_data['id'],
      id_detail: user_detail['id'],
      role: user_data['role_id'],
      username: user_data['username'] ?? '',
      email: user_data['email'],
      name: user_detail['name'],
      phone: user_detail['phone'],
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

Future<Map<String, dynamic>> sellerInfoCount() async {
  try {
    final Map<String, dynamic> user = await preferences.getUser();
    final Map<String, dynamic> response = await api_request.getCount(
        user['id_detail'], user['token_type'], user['auth_token']);
    return Future.value(response);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> uploadProduct({
  required String name,
  required int category,
  required int price,
  required String description,
  required int unit,
  required List<XFile> pictures,
}) async {
  try {
    final Map<String, dynamic> user_data = await preferences.getUser();
    final Map<String, dynamic> response = await api_request.uploadProduct(
      seller_id: user_data['id_detail'],
      category: category,
      unit: unit,
      price: price,
      name: name,
      description: description,
      token_type: user_data['token_type'],
      token: user_data['auth_token'],
    );
    final int id_product = response['id'];
    for (XFile element in pictures) {
      await api_request.uploadPicture(
        element,
        id_product,
        user_data['token_type'],
        user_data['auth_token'],
      );
    }
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> getProductsSeller(BuildContext context) async {
  try {
    final Map user_data = await preferences.getUser();
    final List<ProductSellerModel> listProduct = [];
    final List<dynamic> response = await api_request.retrieveProductSeller(
      user_data['id_detail'],
      user_data['token_type'],
      user_data['auth_token'],
    );
    for (var element in response) {
      listProduct.add(ProductSellerModel(
        id: element['id'],
        price: element['price'],
        category_id: element['category_id'],
        unit_id: element['unit_id'],
        product_name: element['product_name'],
        image_uri: element['image'],
        description: element['description'],
      ));
    }
    context.read<ProductSellerBloc>().add(const DeleteProductSeller());
    context
        .read<ProductSellerBloc>()
        .add(AddProductSeller(productSellerModel: listProduct));
  } catch (error) {
    return Future.error(error);
  }
}

Future<Map> getDetailProductSeller(BuildContext context, int product_id) async {
  try {
    final Map user_data = await preferences.getUser();
    final Map response =
        await api_request.retrieveDetailProductSeller(
      user_data['token_type'],
      user_data['auth_token'],
      product_id,
    );
    return Future.value(response);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> deleteProductSeller(int id) async {
  try {
    final Map user_data = await preferences.getUser();
    await api_request.deleteProductSeller(
      user_data['token_type'],
      user_data['auth_token'],
      id,
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> editProduct(ProductSellerModel product) async {
  try {
    final Map<String, dynamic> user_data = await preferences.getUser();
    await api_request.editProductSeller(
      user_data['token_type'],
      user_data['auth_token'],
      user_data['id_detail'],
      product,
    );
  } catch (error) {
    return Future.error(error);
  }
}