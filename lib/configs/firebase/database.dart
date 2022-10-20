// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class FDatabase {
  FDatabase() {
    database = FirebaseDatabase.instance;
  }

  late FirebaseDatabase database;

  static String get firebaseApiKey => 'AIzaSyBErFLponN1KFAVlySNIVF0AoNIkmnsKao';

  // ? Set FCM Token
  Future<void> setUserWhenLogin(dynamic user_id, String fcm_token) async {
    try {
      await database
          .ref('users')
          .orderByChild('user_id')
          .equalTo(user_id)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          await database.ref('users/${snapshot.key}').set({
            'user_id': user_id,
            'fcm_token': fcm_token,
          });
        } else {
          await database.ref('users').push().set({
            'user_id': user_id,
            'fcm_token': fcm_token,
          });
        }
      });
    } catch (error) {
      return Future.error(Exception(error));
    }
  }

  // ? Delete FCM Token
  Future<void> deleteUserToken(String uid, dynamic user_id) async {
    try {
      await database.ref('users/$uid').set({
        'user_id': user_id,
        'fcm_token': null,
      });
    } catch (error) {
      return Future.error(Exception(error));
    }
  }

  // ? Send a message
  Future<void> sendMessage(
      String message, String user_uid, String admin) async {
    try {
      await database.ref('messages').push().set({
        'message': message,
        'user': user_uid,
        'admin': admin,
        'sent_at': DateTime.now().millisecondsSinceEpoch,
        'read_at': null,
      });
    } catch (error) {
      return Future.error(Exception(error));
    }
  }

  Future<void> readMessage(String message_uid) async {
    try {
      // database.ref('messages').
    } catch (error) {
      return Future.error(Exception(error));
    }
  }

  void listenNotification(String user_uid) {
    try {
      database
          .ref('notifications')
          .orderByChild('user')
          .equalTo(user_uid)
          .onChildAdded
          .listen((event) {
        print(event.snapshot.value);
      });
    } catch (error) {
      Exception(error);
    }
  }
}
