// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melijo/bloc/buyers/recipe/recipe_buyers_bloc.dart';
import 'package:melijo/bloc/buyers/recipe_favourite/recipe_favourite_bloc.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/buyers/recipe_buyers_model.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class FavouriteRecipesBuyersScreen extends StatelessWidget {
  const FavouriteRecipesBuyersScreen({ Key? key }) : super(key: key);

  static const String route = '/favourite_recipes_buyers_screen';

  // ! Retrieve Recipe
  Future<void> getRecipes(context) async {
    try {
      await getRecipe(context);
    } catch (error) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colours.white,
          ),
          child: ModalBottom(
            title: 'Terjadi Kesalahan!',
            message: '$error',
            widgets: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colours.deepGreen, width: 1),
                  fixedSize: const Size.fromWidth(80),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Oke',
                  style: TextStyle(
                    color: Colours.deepGreen,
                    fontSize: 18,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  // ! Remove Favourite
  Future<void> removeFavourite(context, int fav_id) async {
    try {
      LoadingWidget.show(context);
      await deleteRecipeFav(fav_id);
      await getRecipe(context);
      LoadingWidget.close(context);
    } catch (error) {
      LoadingWidget.close(context);
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colours.white,
          ),
          child: ModalBottom(
            title: 'Terjadi Kesalahan!',
            message: '$error',
            widgets: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colours.deepGreen, width: 1),
                  fixedSize: const Size.fromWidth(80),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Oke',
                  style: TextStyle(
                    color: Colours.deepGreen,
                    fontSize: 18,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1, -1),
              end: Alignment(0.2, 0.8),
              colors: [
                Colours.oliveGreen,
                Colours.deepGreen,
              ],
            ),
          ),
        ),
        title: const Text(
          'Resep Favorit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontStyles.bold,
            fontFamily: FontStyles.lora,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => getRecipes(context),
        child: BlocBuilder<RecipeFavouriteBloc, RecipeFavouriteState>(
          builder: (context, favourite) {
            if (favourite is RecipeFavouriteLoading) {
              return const Center(
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: CircularProgressIndicator(
                    color: Colours.deepGreen,
                    strokeWidth: 4,
                  ),
                ),
              );
            }
            if (favourite is RecipeFavouriteInitial) {
              return BlocBuilder<RecipeBuyersBloc, RecipeBuyersState>(
                builder: (context, recipe) {
                  if (recipe is RecipeBuyersLoading) {
                    return const Center(
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child: CircularProgressIndicator(
                          color: Colours.deepGreen,
                          strokeWidth: 4,
                        ),
                      ),
                    );
                  }
                  if (recipe is RecipeBuyersInit) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    itemCount: favourite.recipeFavs.length,
                    itemBuilder: (context, index) {
                      final RecipeBuyersModel theRecipe = recipe.recipes.firstWhere((element) => element.id == favourite.recipeFavs[index].recipe_id);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // *Recipe Image
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                                child: Image(
                                  image: NetworkImage('${ApiRequest.baseStorageUrl}/${theRecipe.image}'),
                                  fit: BoxFit.cover,
                                  height: 80,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // *Recipe Name
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  theRecipe.recipe_title,
                                  softWrap: true,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontStyles.bold,
                                    fontFamily: FontStyles.lora,
                                    color: Colours.deepGreen,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // *Remove Button
                            IconButton(
                              onPressed: () => removeFavourite(context, favourite.recipeFavs[index].id),
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colours.black,
                                size: 36,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  } else {
                    return const Center(child: Text('Terjadi Kesalahan'));
                  }
                },
              );
            } else {
              return const Center(child: Text('Terjadi Kesalahan'));
            }
          },
        ),
      ),
    );
  }
}