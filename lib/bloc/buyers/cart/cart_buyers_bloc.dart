// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melijo/models/buyers/cart_buyers_model.dart';

part 'cart_buyers_event.dart';
part 'cart_buyers_state.dart';

class CartBuyersBloc extends Bloc<CartBuyersEvent, CartBuyersState> {
  CartBuyersBloc() : super(CartBuyersLoading()) {
    on<FillCart>((event, emit) => _onCartFilled(event, emit));
    on<DeleteCart>((event, emit) => _onCartDeleted(event, emit));
    on<ToggleCart>((event, emit) => _onCartToggle(event, emit));
    on<LoadingCart>((event, emit) => _onCartLoading(event, emit));
  }

  void _onCartFilled(FillCart event, Emitter<CartBuyersState> emit) {
    final CartBuyersState state = CartBuyersInit(carts: event.carts);

    if (state is CartBuyersInit) {
      emit(
        CartBuyersInit(carts: state.carts),
      );
    }
  }

  void _onCartDeleted(DeleteCart event, Emitter<CartBuyersState> emit) {
    final CartBuyersState state = this.state;

    if (state is CartBuyersInit) {
      state.carts.clear();
      emit(
        CartBuyersInit(carts: state.carts),
      );
    }
  }

  void _onCartToggle(ToggleCart event, Emitter<CartBuyersState> emit) {
    final CartBuyersState state = CartBuyersInit(carts: event.carts);

    if (state is CartBuyersInit) {
      List<CartBuyersModel> newCarts = state.carts.map((element) {
        if (element.id == event.cart_id) {
          element.checked = !element.checked;
        }
        return element;
      }).toList();
      emit(
        CartBuyersInit(carts: newCarts),
      );
    }
  }

  void _onCartLoading(LoadingCart event, Emitter<CartBuyersState> emit) {
    // final CartBuyersState state = CartBuyersLoading();

    emit(
      CartBuyersLoading(),
    );
  }
}
