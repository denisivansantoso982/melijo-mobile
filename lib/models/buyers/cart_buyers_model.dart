// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:melijo/models/buyers/product_buyers_model.dart';

class CartBuyersModel extends Equatable {
  const CartBuyersModel({
    required this.id,
    required this.product_id,
    required this.user_customer_id,
    required this.quantity,
    required this.product,
  });

  final int id;
  final int product_id;
  final int user_customer_id;
  final int quantity;
  final ProductBuyersModel product;

  @override
  List<Object?> get props => [
    id,
    product_id,
    user_customer_id,
    quantity,
    product,
  ];
}
