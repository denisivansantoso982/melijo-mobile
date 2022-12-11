// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melijo/bloc/buyers/recipe/recipe_buyers_bloc.dart';
import 'package:melijo/bloc/buyers/recipe_favourite/recipe_favourite_bloc.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/buyers/recipe_buyers_model.dart';
import 'package:melijo/models/search_model.dart';
import 'package:melijo/screens/buyers/communications/notification_buyers_screen.dart';
import 'package:melijo/screens/buyers/recipes/detail_recipe_buyers_screen.dart';
import 'package:melijo/screens/buyers/recipes/favourite_recipes_buyers_screen.dart';
import 'package:melijo/screens/buyers/recipes/search_recipe_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';
import 'package:melijo/widgets/notification_widget.dart';

class RecipeBuyersScreen extends StatefulWidget {
  const RecipeBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/recipe_buyers_screen';

  @override
  _RecipeBuyersScreenState createState() => _RecipeBuyersScreenState();
}

class _RecipeBuyersScreenState extends State<RecipeBuyersScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  final List _listRecipeCategory = [
    {
      'id': 0,
      'recipe_category_name': 'Semua',
    },
  ];
  int recipe_category_id = 0;

  @override
  void initState() {
    retrieveRecipeCategory();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  // ! Retrieve Recipe Category
  Future<void> retrieveRecipeCategory() async {
    try {
      final List resCategories = await getCategoryRecipe();
      setState(() {
        _listRecipeCategory.addAll(resCategories);
      });
    } catch (error) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: _globalKey.currentContext!,
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

  // ! Toggle Favourite
  Future<void> toggleFavourite(context, int? fav_id, int recipe_id) async {
    try {
      LoadingWidget.show(context);
      if (fav_id == null) {
        await addRecipeFav(recipe_id);
      } else {
        await deleteRecipeFav(fav_id);
      }
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

  // ! render recipe picture
  ImageProvider<Object> renderImage(RecipeBuyersModel recipe) {
    if (recipe.image == null || recipe.image == '') {
      return const AssetImage('lib/assets/images/recipe.png');
    }
    return NetworkImage('${ApiRequest.baseStorageUrl}/${recipe.image}');
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    getRecipes(context);
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
        title: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colours.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  focusNode: _searchFocus,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (value) {
                    SearchModel.recipe = value;
                    Navigator.of(context).pushNamed(SearchRecipeScreen.route);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.all(4),
                    hintText: 'Cari Resep',
                  ),
                ),
              ),
              const Icon(
                Icons.search_sharp,
                color: Colours.gray,
                size: 28,
              )
            ],
          ),
        ),
        actions: [
          NotificationWidget(
            onPress: () => Navigator.of(context).pushNamed(NotificationBuyersScreen.route),
          ),
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushNamed(FavouriteRecipesBuyersScreen.route),
            color: Colours.white,
            iconSize: 28,
            icon: const Icon(Icons.favorite_border_outlined),
          ),
        ],
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getRecipe(context);
          await retrieveRecipeCategory();
        },
        child: ListView(
          children: [
            const SizedBox(height: 8),
            // *Category Recipes
            SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _listRecipeCategory.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    if (_listRecipeCategory[index]['id'] !=
                        recipe_category_id) {
                      setState(() {
                        recipe_category_id = _listRecipeCategory[index]['id'];
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color:
                          recipe_category_id == _listRecipeCategory[index]['id']
                              ? Colours.deepGreen
                              : Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(64)),
                    ),
                    child: Text(
                      _listRecipeCategory[index]['recipe_category_name'],
                      style: TextStyle(
                        color: recipe_category_id ==
                                _listRecipeCategory[index]['id']
                            ? Colours.white
                            : Colours.black,
                        fontSize: 14,
                        fontFamily: FontStyles.leagueSpartan,
                        fontWeight: FontStyles.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // *Promo or Ads Panel
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 36,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: const Alignment(-1, -1),
                  end: const Alignment(0.2, 0.8),
                  colors: [
                    Colours.oliveGreen.withOpacity(.8),
                    Colours.deepGreen.withOpacity(.8),
                  ],
                ),
              ),
              child: const Text(
                'Iklan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colours.white,
                  fontSize: 20,
                  fontWeight: FontStyles.bold,
                  fontFamily: FontStyles.lora,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // *Recipes Panel
            BlocBuilder<RecipeFavouriteBloc, RecipeFavouriteState>(
              builder: (context, favourite) {
                if (favourite is RecipeFavouriteLoading) {
                  const Center(
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
                        List<RecipeBuyersModel> recipes =
                            recipe_category_id == 0
                                ? recipe.recipes
                                : recipe.recipes
                                    .where((element) =>
                                        element.category_id == recipe_category_id)
                                    .toList();
                        return GridView.builder(
                          padding: const EdgeInsets.all(20),
                          shrinkWrap: true,
                          itemCount: recipes.length,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 4 / 5,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                              DetailRecipeBuyersScreen.route,
                              arguments: recipes[index],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Colours.black.withOpacity(.25),
                                    offset: const Offset(2, 4),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // *Images
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        child: Image(
                                          image: renderImage(recipes[index]),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: screenSize.height / 6,
                                        ),
                                      ),
                                      // *Title
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            recipes[index].recipe_title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colours.black,
                                              fontFamily:
                                                  FontStyles.leagueSpartan,
                                              fontWeight: FontStyles.regular,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(6),
                                        shape: const CircleBorder(),
                                        backgroundColor: Colours.white,
                                      ),
                                      onPressed: () {
                                        favourite.recipeFavs
                                                .where((element) =>
                                                    element.recipe_id ==
                                                    recipes[index].id)
                                                .isNotEmpty
                                            ? toggleFavourite(
                                                context,
                                                favourite.recipeFavs
                                                    .firstWhere((element) =>
                                                        element.recipe_id ==
                                                        recipe
                                                            .recipes[index].id)
                                                    .id,
                                                recipes[index].id)
                                            : toggleFavourite(context, null,
                                                recipes[index].id);
                                      },
                                      child: Icon(
                                        favourite.recipeFavs
                                                .where((element) =>
                                                    element.recipe_id ==
                                                    recipes[index].id)
                                                .isNotEmpty
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: favourite.recipeFavs
                                                .where((element) =>
                                                    element.recipe_id ==
                                                    recipes[index].id)
                                                .isNotEmpty
                                            ? Colors.red
                                            : Colours.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
          ],
        ),
      ),
    );
  }
}
