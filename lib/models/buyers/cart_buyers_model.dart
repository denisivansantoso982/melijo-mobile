// ignore_for_file: non_constant_identifier_names, must_be_immutable, unused_import

import 'package:equatable/equatable.dart';
import 'package:melijo/models/buyers/product_buyers_model.dart';

class CartBuyersModel extends Equatable {
  CartBuyersModel({
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
  bool checked = false;

  @override
  List<Object?> get props => [
    id,
    product_id,
    user_customer_id,
    quantity,
    product,
    checked
  ];
}
