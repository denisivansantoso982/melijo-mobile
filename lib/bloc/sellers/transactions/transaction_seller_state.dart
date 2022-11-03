part of 'transaction_seller_bloc.dart';

abstract class TransactionSellerState extends Equatable {
  const TransactionSellerState();

  @override
  List<Object> get props => [];
}

class TransactionSellerLoading extends TransactionSellerState {}

class TransactionSellerInit extends TransactionSellerState {
  const TransactionSellerInit({required this.transactionSellerModel});

  final List<TransactionSellerModel> transactionSellerModel;

  @override
  List<Object> get props => [transactionSellerModel];
}
