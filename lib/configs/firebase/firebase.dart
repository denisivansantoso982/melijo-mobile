// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:melijo/models/notification_model.dart';

class FDatabase {
  FDatabase() {
    database = FirebaseDatabase.instance;
  }

  FirebaseDatabase database = FirebaseDatabase.instance;

  static String get firebaseApiKey => 'AIzaSyC_ItkkZM7tkmsVvE3E59TkmgUvOHbkjQw';

  // ? Subscribe to Notification
  Future<void> subscribeTopic() async {
    await FirebaseMessaging.instance
        .getToken(vapidKey: FDatabase.firebaseApiKey);
    await FirebaseMessaging.instance.subscribeToTopic('melijo');
  }

  // Future<void> unsubscribeTopic() async {
  //   await FirebaseMessaging.instance
  //       .getToken(vapidKey: FDatabase.firebaseApiKey);
  //   await FirebaseMessaging.instance.unsubscribeFromTopic('melijo');
  // }

  // ? Set FCM Token
  Future<void> setUserWhenLogin(
      dynamic detail_id, dynamic role_id, String fcm_token) async {
    try {
      await database
          .ref('users')
          .orderByChild(role_id == 3 ? 'customer_id' : 'seller_id')
          .equalTo(detail_id)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          final DataSnapshot val = snapshot.children.first;
          await database.ref('users/${val.key}').set({
            role_id == 3 ? 'customer_id' : 'seller_id': detail_id,
            'fcm_token': fcm_token,
          });
        } else {
          await database.ref('users').push().set({
            role_id == 3 ? 'customer_id' : 'seller_id': detail_id,
            'fcm_token': fcm_token,
            'created_at': DateTime.now().millisecondsSinceEpoch,
          });
        }
      });
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? get Notification Record
  Stream<List<DataSnapshot>> retrieveNotificationRecord(
      int detail_id, int role_id) async* {
    try {
      List<DataSnapshot> snapshot = [];
      database
        .ref('notifications')
        .orderByChild(role_id == 3 ? 'customer_id' : 'seller_id')
        .equalTo(detail_id)
        .onValue.listen((event) {
          snapshot = event.snapshot.children.toList();
        });
      yield snapshot;
    } catch (error) {
      Stream.error(error);
    }
  }

  // ? read Notification rtdb
  Future<void> readNotification(NotificationModel notif, int role_id) async {
    try {
      await database
        .ref('notifications')
        .child(notif.uid).set({
          role_id == 3 ? 'customer_id' : 'seller_id': notif.user_id,
          'title': notif.title,
          'description': notif.description,
          'isread': true,
          'send_at': notif.send_at,
        });
    } catch (error) {
      error;
    }
  }

  // ? push Notification Record Seller
  Future<void> pushNotificationToSeller(
      int seller_id, String title, String description) async {
    try {
      await database
        .ref('notifications')
        .push().set({
          'seller_id': seller_id,
          'title': title,
          'description': description,
          'isread': false,
          'send_at': DateTime.now().millisecondsSinceEpoch,
        });
    } catch (error) {
      error;
    }
  }

  // ? push Notification Record Customer
  Future<void> pushNotificationToCustomer(
      int customer_id, String title, String description) async {
    try {
      await database
        .ref('notifications')
        .push().set({
          'customer_id': customer_id,
          'title': title,
          'description': description,
          'isread': false,
          'send_at': DateTime.now().millisecondsSinceEpoch,
        });
    } catch (error) {
      error;
    }
  }

  // ? Generate FCM Token
  Future<String> generateFCMToken() async {
    try {
      final String? token = await FirebaseMessaging.instance
          .getToken(vapidKey: FDatabase.firebaseApiKey);
      if (token == null) throw Exception('Tidak dapat memuat token!');
      return Future.value(token);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Delete FCM Token
  Future<void> deleteUserToken(int detail_id, int role_id) async {
    try {
      database = FirebaseDatabase.instance;
      await database
          .ref('users')
          .orderByChild(role_id == 3 ? 'customer_id' : 'seller_id')
          .equalTo(detail_id)
          .get()
          .then((snapshot) async {
        final DataSnapshot val = snapshot.children.first;
        await database.ref('users/${val.key}').set({
          role_id == 3 ? 'customer_id' : 'seller_id': detail_id,
          'fcm_token': null,
        });
        await FirebaseMessaging.instance.deleteToken();
      });
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Send a message
  Future<void> sendMessage(
      String message, String user_uid, String admin) async {
    try {
      database = FirebaseDatabase.instance;
      await database.ref('messages').push().set({
        'message': message,
        'user': user_uid,
        'admin': admin,
        'sent_at': DateTime.now().millisecondsSinceEpoch,
        'read_at': null,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<void> readMessage(String message_uid) async {
    try {
      database = FirebaseDatabase.instance;
      // database.ref('messages').
    } catch (error) {
      return Future.error(error);
    }
  }

  void listenNotification(String user_uid) {
    try {
      database = FirebaseDatabase.instance;
      database
          .ref('notifications')
          .orderByChild('user')
          .equalTo(user_uid)
          .onChildAdded
          .listen((event) {});
    } catch (error) {
      Exception(error);
    }
  }

  // ? Get FCM Token
  Future<String> getFCMToken(int detail_id, int role_id) async {
    try {
      String fcm = '';
      database = FirebaseDatabase.instance;
      await database
          .ref('users')
          .orderByChild(role_id == 3 ? 'customer_id' : 'seller_id')
          .equalTo(detail_id)
          .get()
          .then((snapshot) async {
        if (!snapshot.exists) {
          return fcm;
        }
        final Map val = snapshot.children.first.value as Map;
        fcm = val['fcm_token'];
      });
      return fcm;
    } catch (error) {
      return Future.error(error);
    }
  }
}
