// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melijo/models/sellers/product_seller_model.dart';

part 'product_seller_event.dart';
part 'product_seller_state.dart';

class ProductSellerBloc extends Bloc<ProductSellerEvent, ProductSellerState> {
  ProductSellerBloc() : super(ProductSellerLoading()) {
    on<AddProductSeller>((event, emit) => _onAddProduct(event, emit));
    on<DeleteProductSeller>((event, emit) => _onDeleteProduct(event, emit));
    on<RestoreProductSeller>((event, emit) => _onRestoreProduct(event, emit));
  }

  void _onAddProduct(AddProductSeller event, Emitter<ProductSellerState> emit) {
    final ProductSellerState state = ProductSellerInit(productsSeller: event.productSellerModel);

    if (state is ProductSellerInit) {
      emit(
        ProductSellerInit(
          productsSeller: state.productsSeller,
        ),
      );
    }
  }

  void _onDeleteProduct(DeleteProductSeller event, Emitter<ProductSellerState> emit) {
    final ProductSellerState state = this.state;

    if (state is ProductSellerInit) {
      emit(
        const ProductSellerInit(productsSeller: []),
      );
    }
  }

  void _onRestoreProduct(RestoreProductSeller event, Emitter<ProductSellerState> emit) {
    emit(
      ProductSellerLoading(),
    );
  }
}
