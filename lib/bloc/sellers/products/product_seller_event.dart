part of 'product_seller_bloc.dart';

abstract class ProductSellerEvent extends Equatable {
  const ProductSellerEvent();

  @override
  List<Object> get props => [];
}

class AddProductSeller extends ProductSellerEvent {
  const AddProductSeller({required this.productSellerModel});

  final List<ProductSellerModel> productSellerModel;

  @override
  List<Object> get props => [productSellerModel];
}

class DeleteProductSeller extends ProductSellerEvent {
  const DeleteProductSeller();

  @override
  List<Object> get props => [];
}

class RestoreProductSeller extends ProductSellerEvent {
  @override
  List<Object> get props => [];
}