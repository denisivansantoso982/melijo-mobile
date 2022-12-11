// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melijo/models/buyers/recipe_buyers_model.dart';

part 'recipe_buyers_event.dart';
part 'recipe_buyers_state.dart';

class RecipeBuyersBloc extends Bloc<RecipeBuyersEvent, RecipeBuyersState> {
  RecipeBuyersBloc() : super(RecipeBuyersLoading()) {
    on<FillRecipe>((event, emit) => _onFillRecipe(event, emit));
    on<DeleteRecipe>((event, emit) => _onDeleteRecipe(event, emit));
    on<LoadingRecipe>((event, emit) => _onLoadingRecipe(event, emit));
  }

  void _onFillRecipe(FillRecipe event, Emitter<RecipeBuyersState> emit) {
    final RecipeBuyersState state = RecipeBuyersInit(recipes: event.listRecipe);

    if (state is RecipeBuyersInit) {
      emit(
        RecipeBuyersInit(recipes: state.recipes),
      );
    }
  }

  void _onDeleteRecipe(DeleteRecipe event, Emitter<RecipeBuyersState> emit) {
    final RecipeBuyersState state = this.state;

    if (state is RecipeBuyersInit) {
      emit(
        const RecipeBuyersInit(recipes: []),
      );
    }
  }

  void _onLoadingRecipe(LoadingRecipe event, Emitter<RecipeBuyersState> emit) {
    emit(RecipeBuyersLoading());
  }
}
