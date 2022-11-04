part of 'melijo_buyer_bloc.dart';

abstract class MelijoBuyerEvent extends Equatable {
  const MelijoBuyerEvent();

  @override
  List<Object> get props => [];
}

class FillMelijo extends MelijoBuyerEvent {
  const FillMelijo({required this.melijoBuyers});

  final List<MelijoBuyersModel> melijoBuyers;

  @override
  List<Object> get props => [melijoBuyers];
}

class DeleteMelijo extends MelijoBuyerEvent {
  const DeleteMelijo();

  @override
  List<Object> get props => [];
}