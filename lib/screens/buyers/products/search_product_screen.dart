// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/buyers/product_buyers_model.dart';
import 'package:melijo/models/search_model.dart';
import 'package:melijo/screens/buyers/communications/notification_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/detail_product_buyers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  static const String route = '/search_product_screen';

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    _searchController.text = SearchModel.product;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  Future<List<ProductBuyersModel>> searchTheProduct() async {
    try {
      final List<ProductBuyersModel> products =
          await searchProduct(_searchController.text);
      return Future.value(products);
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
  ImageProvider<Object> renderImage(ProductBuyersModel product) {
    if (product.image_uri == '') {
      return const AssetImage('lib/assets/images/recipe.png');
    }
    return NetworkImage('${ApiRequest.baseStorageUrl}/${product.image_uri}');
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
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.all(4),
                    hintText: 'Cari Produk di Melijo.id',
                  ),
                  onFieldSubmitted: (value) {
                    _searchController.text = value;
                  },
                ),
              ),
              GestureDetector(
                onTap: () => searchTheProduct(),
                child: const Icon(
                  Icons.search_sharp,
                  color: Colours.gray,
                  size: 28,
                ),
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
      body: FutureBuilder(
        future: searchTheProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  color: Colours.deepGreen,
                  strokeWidth: 4,
                ),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            itemCount: snapshot.data != null ? snapshot.data!.length : 0,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 4 / 5,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                DetailProductBuyersScreen.route,
                arguments: snapshot.data![index],
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
                child: Column(
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
                        image: renderImage(snapshot.data![index]),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: screenSize.height / 6,
                      ),
                    ),
                    // *Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        snapshot.data![index].product_name,
                        style: const TextStyle(
                          color: Colours.black,
                          fontFamily: FontStyles.leagueSpartan,
                          fontWeight: FontStyles.regular,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // *Price
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Rp. ${thousandFormat(snapshot.data![index].price)}',
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
              ),
            ),
          );
        },
      ),
    );
  }
}
