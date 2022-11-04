part of 'recipe_buyers_bloc.dart';

abstract class RecipeBuyersEvent extends Equatable {
  const RecipeBuyersEvent();

  @override
  List<Object> get props => [];
}

class FillRecipe extends RecipeBuyersEvent {
  const FillRecipe({required this.listRecipe});

  final List<RecipeBuyersModel> listRecipe;

  @override
  List<Object> get props => [listRecipe];
}

class DeleteRecipe extends RecipeBuyersEvent {
  @override
  List<Object> get props => [];
}
