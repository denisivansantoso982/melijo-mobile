// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_buyers_event.dart';
part 'cart_buyers_state.dart';

class CartBuyersBloc extends Bloc<CartBuyersEvent, CartBuyersState> {
  CartBuyersBloc() : super(CartBuyersInitial()) {
    on<CartBuyersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
