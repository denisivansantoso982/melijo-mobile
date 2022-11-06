// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melijo/models/buyers/recipe_favourite_model.dart';

part 'recipe_favourite_event.dart';
part 'recipe_favourite_state.dart';

class RecipeFavouriteBloc
    extends Bloc<RecipeFavouriteEvent, RecipeFavouriteState> {
  RecipeFavouriteBloc() : super(const RecipeFavouriteInitial(recipeFavs: [])) {
    on<FillRecipeFav>((event, emit) {
      final RecipeFavouriteState state = RecipeFavouriteInitial(recipeFavs: event.recipeFavs);

      if (state is RecipeFavouriteInitial) {
        emit(
          RecipeFavouriteInitial(
            recipeFavs: state.recipeFavs,
          ),
        );
      }
    });
  }
}
