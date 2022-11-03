import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  const ProfileModel({
    required this.avatar,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.province,
    required this.city,
    required this.district,
    required this.ward,
  });

  final String avatar;
  final String name;
  final String username;
  final String phone;
  final String email;
  final int province;
  final int city;
  final int district;
  final int ward;

  @override
  List<Object?> get props => [
    avatar,
    name,
    username,
    phone,
    email,
    province,
    city,
    district,
    ward,
  ];
}
