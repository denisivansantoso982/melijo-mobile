// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class MelijoBuyersModel extends Equatable {
  const MelijoBuyersModel({
    required this.seller_id,
    required this.user_id,
    required this.name,
    required this.phone,
    this.username,
    required this.email,
    required this.fcm_token,
    this.image,
    required this.province,
    required this.city,
    required this.districts,
    required this.ward,
  });

  final int seller_id;
  final int user_id;
  final String name;
  final String phone;
  final String? username;
  final String email;
  final String fcm_token;
  final String? image;
  final String province;
  final String city;
  final String districts;
  final String ward;

  @override
  List<Object?> get props => [
    seller_id,
    user_id,
    name,
    phone,
    username,
    email,
    fcm_token,
    image,
    province,
    city,
    districts,
    ward,
  ];
}
