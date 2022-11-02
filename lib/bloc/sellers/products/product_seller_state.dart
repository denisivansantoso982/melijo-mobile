part of 'product_seller_bloc.dart';

abstract class ProductSellerState extends Equatable {
  const ProductSellerState();

  @override
  List<Object> get props => [];
}

class ProductSellerLoading extends ProductSellerState {}

class ProductSellerInit extends ProductSellerState {
  const ProductSellerInit({required this.productsSeller});

  final List<ProductSellerModel> productsSeller;

  @override
  List<Object> get props => [productsSeller];
}
