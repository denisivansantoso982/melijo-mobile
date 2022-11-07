// ignore_for_file: library_private_types_in_public_api, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/buyers/product_recom_model.dart';
import 'package:melijo/models/buyers/recipe_buyers_model.dart';
import 'package:melijo/models/search_model.dart';
import 'package:melijo/screens/buyers/communications/notification_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/search_product_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class DetailRecipeBuyersScreen extends StatefulWidget {
  const DetailRecipeBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/detail_recipe_buyers_screen';

  @override
  _DetailRecipeBuyersScreenState createState() =>
      _DetailRecipeBuyersScreenState();
}

class _DetailRecipeBuyersScreenState extends State<DetailRecipeBuyersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  late RecipeBuyersModel recipe;
  final List<Map> _listOfProducts = [];
  late String htmlData;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  // ! Total Price
  double totalPrice() {
    double total = 0;
    for (var element in _listOfProducts) {
      if (element['checked']) total += element['price'] * element['quantity'];
    }
    return total;
  }

  // ! Get Recipe Recommendation
  Future<List<ProductRecomModel>> getRecipeRecom(BuildContext context) async {
    try {
      final List<ProductRecomModel> recom =
          await retrieveProductRecom(recipe.id);
      return Future.value(recom);
      // setState(() {
      //   _listOfProducts.addAll(recom);
      // });
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
      return [];
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
    recipe = ModalRoute.of(context)!.settings.arguments as RecipeBuyersModel;
    htmlData = recipe.step;
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
                    hintText: 'Cari Resep di Melijo.id',
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
            onPressed: () =>
                Navigator.of(context).pushNamed(NotificationBuyersScreen.route),
            color: Colours.white,
            iconSize: 28,
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
        elevation: 0,
      ),
      body: ListView(
        children: [
          // *Recipe Image
          Image(
            image: renderImage(recipe),
            fit: BoxFit.cover,
            width: screenSize.width,
            height: screenSize.width * 0.7,
          ),
          const SizedBox(height: 16),
          // const SizedBox(height: 12),
          // *Recipe Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              recipe.recipe_title,
              style: const TextStyle(
                color: Colours.black,
                fontSize: 28,
                fontFamily: FontStyles.lora,
                fontWeight: FontStyles.medium,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // *Cook Ingredients and Procedure
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Html(data: htmlData),
          ),
          // const SizedBox(height: 8),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 12),
          //   child: Text(
          //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis id varius urna, vel facilisis diam. Donec auctor pretium porta. Aenean in odio at est hendrerit rhoncus vel sit amet tortor. Aenean consequat ...',
          //     style: TextStyle(
          //       color: Colours.gray,
          //       fontSize: 18,
          //       fontFamily: FontStyles.leagueSpartan,
          //       fontWeight: FontStyles.regular,
          //       height: 1.4,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 24),
          // *Recommendation Ingredients of Recipe
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Rekomendasi Pemesanan Bahan',
              style: TextStyle(
                color: Colours.gray,
                fontSize: 20,
                fontFamily: FontStyles.leagueSpartan,
                fontWeight: FontStyles.medium,
              ),
            ),
          ),
          const SizedBox(height: 12),
          FutureBuilder(
            future: getRecipeRecom(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(
                      color: Colours.deepGreen,
                      strokeWidth: 4,
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    String? keyword = snapshot.data?[index].keyword;
                    SearchModel.product = keyword ?? '';
                    Navigator.of(context).pushNamed(SearchProductScreen.route);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    elevation: 4,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: Image(
                              image: NetworkImage(
                                  '${ApiRequest.baseStorageUrl}/${snapshot.data![index].image}'),
                              fit: BoxFit.cover,
                              height: 80,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // *Product Name
                                Text(
                                  snapshot.data![index].keyword,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontStyles.regular,
                                    fontFamily: FontStyles.leagueSpartan,
                                    color: Colours.black.withOpacity(.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
