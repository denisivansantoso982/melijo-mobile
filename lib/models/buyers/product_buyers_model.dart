// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class ProductBuyersModel extends Equatable {
  const ProductBuyersModel({
    required this.id,
    required this.price,
    required this.category_id,
    required this.unit_id,
    required this.product_name,
    required this.image_uri,
    required this.description,
    required this.user_seller_id,
  });

  final int id;
  final int price;
  final int unit_id;
  final int category_id;
  final String product_name;
  final String image_uri;
  final String description;
  final int user_seller_id;

  @override
  List<Object?> get props => [
        id,
        price,
        unit_id,
        category_id,
        product_name,
        image_uri,
        description,
        user_seller_id,
      ];
}