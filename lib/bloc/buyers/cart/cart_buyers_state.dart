part of 'cart_buyers_bloc.dart';

abstract class CartBuyersState extends Equatable {
  const CartBuyersState();

  @override
  List<Object> get props => [];
}

class CartBuyersLoading extends CartBuyersState {}

class CartBuyersInit extends CartBuyersState {
  const CartBuyersInit({required this.carts});

  final List<CartBuyersModel> carts;

  @override
  List<Object> get props => [];
}