part of 'recipe_favourite_bloc.dart';

abstract class RecipeFavouriteEvent extends Equatable {
  const RecipeFavouriteEvent();

  @override
  List<Object> get props => [];
}

class FillRecipeFav extends RecipeFavouriteEvent {
  const FillRecipeFav({required this.recipeFavs});

  final List<RecipeFavouriteModel> recipeFavs;

  @override
  List<Object> get props => [recipeFavs];
}

class LoadingRecipeFav extends RecipeFavouriteEvent {
  const LoadingRecipeFav();

  @override
  List<Object> get props => [];
}
