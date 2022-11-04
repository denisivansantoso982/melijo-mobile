part of 'recipe_buyers_bloc.dart';

abstract class RecipeBuyersState extends Equatable {
  const RecipeBuyersState();

  @override
  List<Object> get props => [];
}

class RecipeBuyersLoading extends RecipeBuyersState {}

class RecipeBuyersInit extends RecipeBuyersState {
  const RecipeBuyersInit({required this.recipes});

  final List<RecipeBuyersModel> recipes;

  @override
  List<Object> get props => [recipes];
}
