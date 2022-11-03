part of 'transaction_seller_bloc.dart';

abstract class TransactionSellerEvent extends Equatable {
  const TransactionSellerEvent();

  @override
  List<Object> get props => [];
}

class FillTransaction extends TransactionSellerEvent {
  const FillTransaction({required this.transactionSellerModel});

  final List<TransactionSellerModel> transactionSellerModel;

  @override
  List<Object> get props => [transactionSellerModel];
}

class DeleteTransaction extends TransactionSellerEvent {
  @override
  List<Object> get props => [];
}
