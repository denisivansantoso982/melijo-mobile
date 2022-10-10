// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class FavouriteRecipesBuyersScreen extends StatefulWidget {
  const FavouriteRecipesBuyersScreen({ Key? key }) : super(key: key);

  static const String route = '/favourite_recipes_buyers_screen';

  @override
  _FavouriteRecipesBuyersScreenState createState() => _FavouriteRecipesBuyersScreenState();
}

class _FavouriteRecipesBuyersScreenState extends State<FavouriteRecipesBuyersScreen> {
  final List<Map<String, dynamic>> _listOfRecipes = [
    {
      'name': 'Resep Nasi Goreng Aesthetic',
      'image': 'nasgor.jpg',
    },
    {
      'name': 'Resep Tongseng Kangkung Pasaran',
      'image': 'tumis_kangkung.jpg',
    },
    {
      'name': 'Capcay Jalanan Kelas',
      'image': 'capcay.jpg',
    },
    {
      'name': 'Mie Goreng Enak Abang-Abang',
      'image': 'mie_goreng.jpg',
    },
    {
      'name': 'Resep Sup Wortel Kentang Bening Segar Enak',
      'image': 'sup.jpg',
    },
  ];

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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        itemCount: _listOfRecipes.length,
        itemBuilder: (context, index) => Card(
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
                    image: AssetImage('lib/assets/images/recipes/${_listOfRecipes[index]['image']}'),
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
                    _listOfRecipes[index]['name'],
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
                onPressed: () {
                  setState(() {
                    _listOfRecipes.removeAt(index);
                  });
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colours.black,
                  size: 36,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}