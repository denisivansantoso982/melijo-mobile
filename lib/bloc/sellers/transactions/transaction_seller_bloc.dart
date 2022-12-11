// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melijo/models/sellers/transaction_seller_model.dart';

part 'transaction_seller_event.dart';
part 'transaction_seller_state.dart';

class TransactionSellerBloc extends Bloc<TransactionSellerEvent, TransactionSellerState> {
  TransactionSellerBloc() : super(TransactionSellerLoading()) {
    on<FillTransaction>((event, emit) => _onAddTransaction(event, emit));
    on<DeleteTransaction>((event, emit) => _onDeleteTransaction(event, emit));
    on<LoadingTransaction>((event, emit) => _onLoadingTransaction(event, emit));
  }

  void _onAddTransaction(FillTransaction event, Emitter<TransactionSellerState> emit) {
    final TransactionSellerState state = TransactionSellerInit(transactionSellerModel: event.transactionSellerModel);

    if (state is TransactionSellerInit) {
      emit(
        TransactionSellerInit(transactionSellerModel: state.transactionSellerModel),
      );
    }
  }

  void _onDeleteTransaction(DeleteTransaction event, Emitter<TransactionSellerState> emit) {
    final TransactionSellerState state = this.state;

    if (state is TransactionSellerInit) {
      emit(
        const TransactionSellerInit(transactionSellerModel: []),
      );
    }
  }

  void _onLoadingTransaction(LoadingTransaction event, Emitter<TransactionSellerState> emit) {
    emit(TransactionSellerLoading());
  }
}
