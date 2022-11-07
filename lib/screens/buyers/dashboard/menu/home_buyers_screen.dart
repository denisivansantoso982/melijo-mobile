// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melijo/bloc/buyers/product/product_buyers_bloc.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/buyers/product_buyers_model.dart';
import 'package:melijo/screens/buyers/communications/chat_buyers_screen.dart';
import 'package:melijo/screens/buyers/communications/notification_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/detail_product_buyers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class HomeBuyersScreen extends StatefulWidget {
  const HomeBuyersScreen({Key? key}) : super(key: key);

  @override
  _HomeBuyersScreenState createState() => _HomeBuyersScreenState();
}

class _HomeBuyersScreenState extends State<HomeBuyersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  final List<Map<String, String>> _listCategory = [
    {
      'title': 'Sayur',
      'image': 'Sayur.png',
    },
    {
      'title': 'Daging',
      'image': 'Daging.png',
    },
    {
      'title': 'Unggas',
      'image': 'Unggas.png',
    },
    {
      'title': 'Seafood',
      'image': 'Seafood.png',
    },
    {
      'title': 'Protein',
      'image': 'Protein.png',
    },
    {
      'title': 'Bumbu',
      'image': 'Bumbu.png',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  // ! Retrieve Melijo
  Future<void> getProducts(context) async {
    try {
      await getProductsBuyers(context);
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

  // ! render recipe picture
  ImageProvider<Object> renderImage(ProductBuyersModel product) {
    if (product.image_uri == '') {
      return const AssetImage('lib/assets/images/recipe.png');
    }
    return NetworkImage('${ApiRequest.baseStorageUrl}/${product.image_uri}');
  }

  Widget renderGridProducts(
      BuildContext context, ProductBuyersState state, Size screenSize) {
    if (state is ProductBuyersLoading) {
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
    if (state is ProductBuyersInit) {
      return GridView.builder(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        itemCount: state.listOfProduct.length,
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
            arguments: state.listOfProduct[index],
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
                    image: renderImage(state.listOfProduct[index]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: screenSize.height / 6,
                  ),
                ),
                // *Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    state.listOfProduct[index].product_name,
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
                    'Rp. ${thousandFormat(state.listOfProduct[index].price)}',
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
    } else {
      return const Center(child: Text('Terjadi Kesalahan'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    getProducts(context);
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
                    hintText: 'Cari nama produk',
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
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(ChatBuyersScreen.route),
            color: Colours.white,
            iconSize: 28,
            icon: const Icon(Icons.mail_outline_sharp),
          ),
        ],
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => getProducts(context),
        child: BlocBuilder<ProductBuyersBloc, ProductBuyersState>(
          builder: (context, state) {
            return ListView(
              children: [
                // *Welcome Panel
                FutureBuilder(
                    future: getUserInfo(),
                    builder: (context, snapshot) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-1, -1),
                            end: Alignment(-0.1, 0.6),
                            colors: [
                              Colours.oliveGreen,
                              Colours.deepGreen,
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 56,
                              width: 56,
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(64)),
                                color: Colours.white,
                              ),
                              child: const ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(64)),
                                child: Image(
                                  image:
                                      AssetImage('lib/assets/images/logo.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Halo, selamat datang ${snapshot.data?['name']}!',
                                  style: const TextStyle(
                                    color: Colours.white,
                                    fontSize: 18,
                                    fontFamily: FontStyles.leagueSpartan,
                                    fontWeight: FontStyles.regular,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Mau masak apa kamu hari ini?',
                                  style: TextStyle(
                                    color: Colours.white,
                                    fontSize: 18,
                                    fontFamily: FontStyles.leagueSpartan,
                                    fontWeight: FontStyles.regular,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                // *Category Panel
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: _listCategory.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colours.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(64)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colours.black.withOpacity(.25),
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              child: Image(
                                image: AssetImage(
                                    'lib/assets/images/category/${_listCategory[index]['image']}'),
                                fit: BoxFit.cover,
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${_listCategory[index]['title']}',
                            style: const TextStyle(
                              color: Colours.deepGreen,
                              fontSize: 16,
                              fontWeight: FontStyles.medium,
                              fontFamily: FontStyles.leagueSpartan,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // *Promo or Ads Panel
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/recipes/nasgor.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
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
                      'Temukan berbagai resep sehat di sini 🤩',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colours.white,
                        fontSize: 20,
                        fontWeight: FontStyles.bold,
                        fontFamily: FontStyles.lora,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // *Products Panel
                renderGridProducts(context, state, screenSize),
              ],
            );
          },
        ),
      ),
    );
  }
}
