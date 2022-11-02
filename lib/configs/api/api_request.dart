// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:melijo/models/sellers/product_seller_model.dart';

class ApiRequest {
  static const String baseUrl = 'http://192.168.43.59:8000/api';
  static const String baseStorageUrl = 'http://192.168.43.59:8000/storage';
  // static const String baseUrl = 'http://192.168.100.191:8000/api';
  // static const String baseStorageUrl = 'http://192.168.100.191:8000/storage';
  static const String locationBaseUrl =
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
      final Map decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw '${response.statusCode} ${response.reasonPhrase}';
      }
      final Map<String, dynamic> data = decodedResponse['data'];
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
      final Map decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw '${response.statusCode} ${decodedResponse['message']}';
      }
      final Map<String, dynamic> data = decodedResponse['data'];
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
          'accept': 'application/json',
          'content-type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Set FCM Token
  Future<void> setFCMToken(int id_user, String? fcm_token) async {
    try {
      client = http.Client();
      final Map body = {
        'id': id_user,
        'fcm_token': fcm_token,
      };
      http.Response response = await client
          .put(
            Uri.parse('$baseUrl/auth/fcm_token'),
            headers: {
              'accept': 'application/json',
              'content-type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));
      final Map decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw '${response.statusCode} ${decodedResponse['message']}';
      }
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

  // ? Get Transaction and Product Count
  Future<Map<String, dynamic>> getCount(
      int id_seller, String token_type, String token) async {
    try {
      client = http.Client();
      final http.Response response = await client.get(
        Uri.parse('$baseUrl/transaction/$id_seller/seller'),
        headers: {
          'Authorization': '$token_type $token',
          'accept': 'application/json',
          'content-type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));
      final Map decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw '${response.statusCode} ${decodedResponse['message']}';
      }
      final Map<String, dynamic> data = decodedResponse['data'];
      return Future.value(data);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Post Product Information
  Future<Map<String, dynamic>> uploadProduct({
    required int seller_id,
    required int category,
    required int unit,
    required int price,
    required String name,
    required String description,
    required String token_type,
    required String token,
  }) async {
    try {
      client = http.Client();
      final Map<String, dynamic> body = {
        'user_seller_id': seller_id,
        'category_id': category,
        'unit_id': unit,
        'price': price,
        'product_name': name,
        'description': description,
        'stock': 0,
      };
      final http.Response response = await client
          .post(
            Uri.parse('$baseUrl/product'),
            headers: {
              'Authorization': '$token_type $token',
              'accept': 'application/json',
              'content-type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw '${response.statusCode} ${decodedResponse['message']}';
      }
      return Future.value(decodedResponse['data']);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Upload Picture
  Future<void> uploadPicture(XFile file, int product_id, String token_type, String token) async {
    try {
      final List<int> imageBytes = await file.readAsBytes();
      final http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/product_image'));
      request.headers.addAll({'Authorization': '$token_type $token'});
      request.fields.addAll({'product_id': '$product_id'});
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: file.name,
      ));
      final http.StreamedResponse response = await request.send();
      // final responseByteArray = await response.stream.toBytes();
      // final jsonDecoded = jsonDecode(utf8.decode(responseByteArray));
      if (response.statusCode != 200) {
        throw '${response.statusCode} ${response.reasonPhrase}';
      }
      // return Future.error(jsonDecoded);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Retrieve Products
  Future<List<dynamic>> retrieveProductSeller(int seller_id, String token_type, String token) async {
    try {
      client = http.Client();
      final http.Response response = await client.get(
        Uri.parse('$baseUrl/user_seller/$seller_id/product'),
        headers: {
          'Authorization': '$token_type $token',
          'accept': 'application/json',
          'content-type': 'application/json',
        }
      );
      final Map decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw '${response.statusCode} ${response.reasonPhrase}';
      }
      return Future.value(decodedResponse['data']);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Retrieve Detail Products
  Future<Map> retrieveDetailProductSeller(String token_type, String token, int product_id) async {
    try {
      client = http.Client();
      final http.Response response = await client.get(
        Uri.parse('$baseUrl/product/$product_id'),
        headers: {
          'Authorization': '$token_type $token',
          'accept': 'application/json',
          'content-type': 'application/json',
        }
      );
      final Map decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw '${response.statusCode} ${response.reasonPhrase}';
      }
      return Future.value(decodedResponse['data']);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Delete Product
  Future<void> deleteProductSeller(String token_type, String token, int id) async {
    try {
      client = http.Client();
      final http.Response response = await client.delete(
        Uri.parse('$baseUrl/product/$id'),
        headers: {
          'Authorization': '$token_type $token',
          'accept': 'application/json',
          'content-type': 'application/json',
        }
      );
      if (response.statusCode != 200) {
        throw '${response.statusCode} ${response.reasonPhrase}';
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Retrieve Detail Products
  Future<void> editProductSeller(String token_type, String token, int seller_id, ProductSellerModel product) async {
    try {
      client = http.Client();
      final Map<String, dynamic> body = {
        'user_seller_id': seller_id,
        'category_id': product.category_id,
        'unit_id': product.unit_id,
        'price': product.price,
        'product_name': product.product_name,
        'description': product.description,
        'stock': '0',
      };
      final http.Response response = await client.put(
        Uri.parse('$baseUrl/product/${product.id}'),
        headers: {
          'Authorization': '$token_type $token',
          'accept': 'application/json',
          'content-type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode != 200) {
        throw '${response.statusCode} ${response.reasonPhrase}';
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
