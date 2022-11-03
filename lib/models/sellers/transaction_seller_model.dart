// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class TransactionSellerModel extends Equatable {
  const TransactionSellerModel({
    required this.txid,
    required this.date_order,
    this.promo,
    this.promo_code,
    required this.status,
    required this.customer_name,
    required this.seller_name,
    required this.total,
    required this.seller_id,
    required this.customer_id,
    this.operator_id,
  });

  final String txid;
  final DateTime date_order;
  final String? promo;
  final String? promo_code;
  final String status;
  final String customer_name;
  final String seller_name;
  final int total;
  final int? operator_id;
  final int seller_id;
  final int customer_id;

  @override
  List<Object?> get props => [
    txid,
    date_order,
    promo,
    status,
    customer_name,
    seller_name,
    total,
    seller_id,
    customer_id,
  ];
}
