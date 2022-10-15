// ignore_for_file: non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Future<void> setUserWhenLogin(dynamic user_id, String fcm_token) async {
  database.ref('users').push().set({
    'user_id': user_id,
    'fcm_token': fcm_token,
  }).onError((error, stackTrace) => Exception(error));
}

Future<void> deleteUserToken(String uid, dynamic user_id) async {
  database.ref('users/$uid').set({
    'user_id': user_id,
    'fcm_token': null,
  }).onError((error, stackTrace) => Exception(error));
}
