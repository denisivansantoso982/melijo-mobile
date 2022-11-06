part of 'recipe_favourite_bloc.dart';

abstract class RecipeFavouriteState extends Equatable {
  const RecipeFavouriteState();

  @override
  List<Object> get props => [];
}

class RecipeFavouriteInitial extends RecipeFavouriteState {
  const RecipeFavouriteInitial({required this.recipeFavs});

  final List<RecipeFavouriteModel> recipeFavs;

  @override
  List<Object> get props => [recipeFavs];
}
