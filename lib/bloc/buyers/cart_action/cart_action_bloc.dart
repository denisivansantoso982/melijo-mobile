import 'package:flutter_bloc/flutter_bloc.dart';

class CartActionBloc extends Bloc<CartActionEvent, int> {
  CartActionBloc() : super(0) {
    on<IncrementEvent>((event, emit) => emit(state + 1));
    on<DecrementEvent>((event, emit) => emit(state - 1));
    on<ZeroPointEvent>((event, emit) {
      int state = event.zeroPoint;
      emit(state);
    });
  }
}

abstract class CartActionEvent {}

class IncrementEvent extends CartActionEvent {}

class DecrementEvent extends CartActionEvent {}

class ZeroPointEvent extends CartActionEvent {
  final int zeroPoint = 0;
}
