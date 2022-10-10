// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/screens/buyers/communications/notification_buyers_screen.dart';
import 'package:melijo/screens/buyers/recipes/detail_recipe_buyers_screen.dart';
import 'package:melijo/screens/buyers/recipes/favourite_recipes_buyers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class RecipeBuyersScreen extends StatefulWidget {
  const RecipeBuyersScreen({Key? key}) : super(key: key);

  @override
  _RecipeBuyersScreenState createState() => _RecipeBuyersScreenState();
}

class _RecipeBuyersScreenState extends State<RecipeBuyersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  final List<Map<String, dynamic>> _listRecipeCategory = [
    {
      'name': 'Semua',
      'selected': true,
    },
    {
      'name': 'Healthy',
      'selected': false,
    },
    {
      'name': 'Western',
      'selected': false,
    },
    {
      'name': 'Asian',
      'selected': false,
    },
    {
      'name': 'Manis',
      'selected': false,
    },
    {
      'name': 'Pedas',
      'selected': false,
    },
    {
      'name': 'Camilan',
      'selected': false,
    },
  ];
  final List<Map<String, dynamic>> _listRecipes = [
    {
      'name': 'Resep Nasi Goreng Aesthetic',
      'favourite': false,
      'difficulty': 'Mudah',
      'image': 'nasgor.jpg',
    },
    {
      'name': 'Resep Tongseng Kangkung Pasaran',
      'favourite': false,
      'difficulty': 'Mudah',
      'image': 'tumis_kangkung.jpg',
    },
    {
      'name': 'Capcay Jalanan Kelas',
      'favourite': false,
      'difficulty': 'Sedang',
      'image': 'capcay.jpg',
    },
    {
      'name': 'Mie Goreng Enak Abang-Abang',
      'favourite': true,
      'difficulty': 'Sedang',
      'image': 'mie_goreng.jpg',
    },
    {
      'name': 'Resep Sup Wortel Kentang Bening Segar Enak',
      'favourite': false,
      'difficulty': 'Sulit',
      'image': 'sup.jpg',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
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
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.all(4),
                    hintText: 'Cari Resep produk',
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
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(NotificationBuyersScreen.route),
            color: Colours.white,
            iconSize: 28,
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(FavouriteRecipesBuyersScreen.route),
            color: Colours.white,
            iconSize: 28,
            icon: const Icon(Icons.favorite_border_outlined),
          ),
        ],
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          // *Category Recipes
          SizedBox(
            height: 32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _listRecipeCategory.length,
              itemBuilder: (context, index) => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _listRecipeCategory[index]['selected']
                      ? Colours.deepGreen
                      : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(64)),
                ),
                child: Text(
                  _listRecipeCategory[index]['name'],
                  style: TextStyle(
                    color: _listRecipeCategory[index]['selected']
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
          GridView.builder(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            itemCount: _listRecipes.length,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 4 / 5,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                DetailRecipeBuyersScreen.route,
                arguments: _listRecipes[index],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // *Images
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Image(
                            image: AssetImage(
                                'lib/assets/images/recipes/${_listRecipes[index]['image']}'),
                            fit: BoxFit.cover,
                            height: screenSize.height / 6,
                          ),
                        ),
                        // *Title
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              _listRecipes[index]['name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colours.black,
                                fontFamily: FontStyles.leagueSpartan,
                                fontWeight: FontStyles.regular,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        // *Difficulty
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${_listRecipes[index]['difficulty']}',
                            style: const TextStyle(
                              color: Colours.deepGreen,
                              fontFamily: FontStyles.leagueSpartan,
                              fontWeight: FontStyles.medium,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(),
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
                          setState(() {
                            _listRecipes[index]['favourite'] = !_listRecipes[index]['favourite'];
                          });
                        },
                        child: Icon(
                          _listRecipes[index]['favourite'] ? Icons.favorite : Icons.favorite_border,
                          color: _listRecipes[index]['favourite'] ? Colors.red : Colours.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
