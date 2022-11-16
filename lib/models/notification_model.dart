// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.uid,
    required this.user_id,
    required this.title,
    required this.description,
    required this.isread,
    required this.send_at,
  });

  final String uid;
  final int user_id;
  final String title;
  final String description;
  final bool isread;
  final int send_at;

  @override
  List<Object?> get props => [
    uid,
    user_id,
    title,
    description,
    isread,
    send_at,
  ];
}
