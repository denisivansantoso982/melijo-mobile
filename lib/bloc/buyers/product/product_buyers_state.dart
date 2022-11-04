part of 'product_buyers_bloc.dart';

abstract class ProductBuyersState extends Equatable {
  const ProductBuyersState();

  @override
  List<Object> get props => [];
}

class ProductBuyersLoading extends ProductBuyersState {}

class ProductBuyersInit extends ProductBuyersState {
  const ProductBuyersInit({required this.listOfProduct});

  final List<ProductBuyersModel> listOfProduct;

  @override
  List<Object> get props => [listOfProduct];
}
