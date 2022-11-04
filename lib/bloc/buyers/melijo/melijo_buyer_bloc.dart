// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melijo/models/buyers/melijo_buyers_model.dart';

part 'melijo_buyer_event.dart';
part 'melijo_buyer_state.dart';

class MelijoBuyerBloc extends Bloc<MelijoBuyerEvent, MelijoBuyerState> {
  MelijoBuyerBloc() : super(MelijoBuyerLoading()) {
    on<FillMelijo>((event, emit) => _onFillProduct(event, emit));
    on<DeleteMelijo>((event, emit) => _onDeleteProduct(event, emit));
  }

  void _onFillProduct(FillMelijo event, Emitter<MelijoBuyerState> emit) {
    final MelijoBuyerState state = MelijoBuyerInit(melijoBuyers: event.melijoBuyers);

    if (state is MelijoBuyerInit) {
      emit(
        MelijoBuyerInit(melijoBuyers: state.melijoBuyers),
      );
    }
  }

  void _onDeleteProduct(DeleteMelijo event, Emitter<MelijoBuyerState> emit) {
    final MelijoBuyerState state = this.state;

    if (state is MelijoBuyerInit) {
      emit(
        const MelijoBuyerInit(melijoBuyers: []),
      );
    }
  }
}
