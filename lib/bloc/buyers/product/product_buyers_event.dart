part of 'product_buyers_bloc.dart';

abstract class ProductBuyersEvent extends Equatable {
  const ProductBuyersEvent();

  @override
  List<Object> get props => [];
}

class FillProductBuyer extends ProductBuyersEvent {
  const FillProductBuyer({required this.productBuyerModel});

  final List<ProductBuyersModel> productBuyerModel;

  @override
  List<Object> get props => [productBuyerModel];
}

class DeleteProductBuyer extends ProductBuyersEvent {
  const DeleteProductBuyer();

  @override
  List<Object> get props => [];
}

class LoadingProductBuyer extends ProductBuyersEvent {
  const LoadingProductBuyer();

  @override
  List<Object> get props => [];
}