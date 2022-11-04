// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melijo/models/buyers/product_buyers_model.dart';

part 'product_buyers_event.dart';
part 'product_buyers_state.dart';

class ProductBuyersBloc extends Bloc<ProductBuyersEvent, ProductBuyersState> {
  ProductBuyersBloc() : super(ProductBuyersLoading()) {
    on<FillProductBuyer>((event, emit) => _onAddProduct(event, emit));
    on<DeleteProductBuyer>((event, emit) => _onDeleteProduct(event, emit));
  }

  void _onAddProduct(FillProductBuyer event, Emitter<ProductBuyersState> emit) {
    final ProductBuyersState state = ProductBuyersInit(listOfProduct: event.productBuyerModel);

    if (state is ProductBuyersInit) {
      emit(
        ProductBuyersInit(
          listOfProduct: state.listOfProduct,
        ),
      );
    }
  }

  void _onDeleteProduct(DeleteProductBuyer event, Emitter<ProductBuyersState> emit) {
    final ProductBuyersState state = this.state;

    if (state is ProductBuyersInit) {
      emit(
        const ProductBuyersInit(listOfProduct: []),
      );
    }
  }
}
