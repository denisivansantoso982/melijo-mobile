// ignore_for_file: non_constant_identifier_names

part of 'cart_buyers_bloc.dart';

abstract class CartBuyersEvent extends Equatable {
  const CartBuyersEvent();

  @override
  List<Object> get props => [];
}

class FillCart extends CartBuyersEvent {
  const FillCart({required this.carts});

  final List<CartBuyersModel> carts;

  @override
  List<Object> get props => [carts];
}

class DeleteCart extends CartBuyersEvent {
  @override
  List<Object> get props => [];
}

class ToggleCart extends CartBuyersEvent {
  const ToggleCart({required this.carts, required this.cart_id});

  final List<CartBuyersModel> carts;
  final int cart_id;

  @override
  List<Object> get props => [carts, cart_id];
}