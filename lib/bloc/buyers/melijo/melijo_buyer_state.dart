part of 'melijo_buyer_bloc.dart';

abstract class MelijoBuyerState extends Equatable {
  const MelijoBuyerState();

  @override
  List<Object> get props => [];
}

class MelijoBuyerLoading extends MelijoBuyerState {}

class MelijoBuyerInit extends MelijoBuyerState {
  const MelijoBuyerInit({required this.melijoBuyers});

  final List<MelijoBuyersModel> melijoBuyers;

  @override
  List<Object> get props => [melijoBuyers];
}
