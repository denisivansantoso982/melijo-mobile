// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class ProductSellerModel extends Equatable {
  const ProductSellerModel({
    required this.id,
    required this.price,
    required this.category_id,
    required this.unit_id,
    required this.product_name,
    required this.image_uri,
    required this.description,
  });

  final int id;
  final int price;
  final int unit_id;
  final int category_id;
  final String product_name;
  final String image_uri;
  final String description;

  @override
  List<Object?> get props => [
    id,
    price,
    unit_id,
    category_id,
    product_name,
    image_uri,
    description,
  ];
}