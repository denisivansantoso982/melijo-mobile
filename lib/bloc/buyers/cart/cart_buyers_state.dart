part of 'cart_buyers_bloc.dart';

abstract class CartBuyersState extends Equatable {
  const CartBuyersState();
  
  @override
  List<Object> get props => [];
}

class CartBuyersInitial extends CartBuyersState {}
