// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melijo/bloc/buyers/cart_action/cart_action_bloc.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/buyers/product_buyers_model.dart';
import 'package:melijo/models/search_model.dart';
import 'package:melijo/screens/buyers/communications/chat_buyers_screen.dart';
import 'package:melijo/screens/buyers/communications/notification_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/search_product_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class DetailProductBuyersScreen extends StatefulWidget {
  const DetailProductBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/detail_product_screen';

  @override
  State<DetailProductBuyersScreen> createState() =>
      _DetailProductBuyersScreenState();
}

class _DetailProductBuyersScreenState extends State<DetailProductBuyersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  final PageController _pageController = PageController();
  late ProductBuyersModel product;
  final List<dynamic> _listOfPicture = [];
  final StreamController streamController = StreamController();
  String? grouping;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
  }

  // ! Add to Cart Action
  void doAddToCart(BuildContext context, ProductBuyersModel arguments) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            // *First Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // *Image
                Expanded(
                  flex: 3,
                  child: Image(
                    image: NetworkImage(
                        '${ApiRequest.baseStorageUrl}/${product.image_uri}'),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                // *Name and Price
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // *Price
                      Text(
                        'Rp. ${thousandFormat(product.price)}',
                        style: const TextStyle(
                          color: Colours.deepGreen,
                          fontSize: 22,
                          fontWeight: FontStyles.bold,
                          fontFamily: FontStyles.lora,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // *Title
                      Text(
                        product.product_name,
                        style: const TextStyle(
                          color: Colours.gray,
                          fontSize: 18,
                          fontWeight: FontStyles.regular,
                          fontFamily: FontStyles.leagueSpartan,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // *Close Button
                Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      color: Colours.gray,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // *Second Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jumlah',
                  style: TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontFamily: FontStyles.leagueSpartan,
                    fontWeight: FontStyles.medium,
                  ),
                ),
                BlocBuilder<CartActionBloc, int>(
                  builder: (context, state) {
                    quantity = state;
                    return Row(
                      children: [
                        // *Reduce Button
                        GestureDetector(
                          onTap: () {
                            if (state > 1) {
                              context
                                  .read<CartActionBloc>()
                                  .add(DecrementEvent());
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            color: Colours.lightGray,
                            child: const Icon(
                              Icons.remove,
                              color: Colours.gray,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // *Quantity
                        Text(
                          '$state',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colours.gray,
                            fontFamily: FontStyles.leagueSpartan,
                            fontWeight: FontStyles.regular,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // *Add Button
                        GestureDetector(
                          onTap: () {
                            context
                                .read<CartActionBloc>()
                                .add(IncrementEvent());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            color: Colours.lightGray,
                            child: const Icon(
                              Icons.add,
                              color: Colours.gray,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            // *Third Row
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  onPressed: () => addProductToCart(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Tambahkan ke Keranjang',
                        style: TextStyle(
                          color: Colours.white,
                          fontSize: 16,
                          fontFamily: FontStyles.leagueSpartan,
                          fontWeight: FontStyles.medium,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colours.white,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ! Get Product Images
  Future<List> getImage(context) async {
    try {
      final Map productDetail =
          await getDetailProductSeller(context, product.id);
      final List productImages = productDetail['images'];
      for (Map image in productImages) {
        _listOfPicture.add(image['image']);
      }
      return Future.error(productImages);
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

  // ! Add Product to Cart
  Future<void> addProductToCart() async {
    try {
      if (quantity < 1) {
        throw 'Masukkan Kuantitas!';
      }
      LoadingWidget.show(context);
      await addToCart(product.id, quantity, grouping);
      LoadingWidget.close(context);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Produk dimasukkan ke Keranjang!'),
        backgroundColor: Colours.deepGreen,
        duration: Duration(seconds: 2),
      ));
      context.read<CartActionBloc>().add(ZeroPointEvent());
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
    final Size screenSize = MediaQuery.of(context).size;
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    product = arguments['product'];
    grouping = arguments['grouping'];
    return WillPopScope(
      onWillPop: () async {
        context.read<CartActionBloc>().add(ZeroPointEvent());
        return true;
      },
      child: Scaffold(
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
                      SearchModel.product = value;
                      Navigator.of(context).pushNamed(
                        SearchProductScreen.route,
                        arguments: {
                          'grouping': null,
                        }
                      );
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.all(4),
                      hintText: 'Cari produk',
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
              onPressed: () => Navigator.of(context)
                  .pushNamed(NotificationBuyersScreen.route),
              color: Colours.white,
              iconSize: 28,
              icon: const Icon(Icons.notifications_outlined),
            ),
          ],
          elevation: 0,
        ),
        body: ListView(
          children: [
            // *Images
            FutureBuilder(
                future: getImage(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: screenSize.width,
                      height: screenSize.width,
                      child: const Center(
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            color: Colours.deepGreen,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    width: screenSize.width,
                    height: screenSize.width,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _listOfPicture.length,
                      itemBuilder: (context, index) => Image(
                        image: NetworkImage(
                            '${ApiRequest.baseStorageUrl}/${_listOfPicture[index]}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 12),
            // *Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Rp. ${thousandFormat(product.price)}',
                style: const TextStyle(
                  color: Colours.deepGreen,
                  fontSize: 22,
                  fontWeight: FontStyles.bold,
                  fontFamily: FontStyles.lora,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // *Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                product.product_name,
                style: const TextStyle(
                  color: Colours.black,
                  fontSize: 22,
                  fontWeight: FontStyles.bold,
                  fontFamily: FontStyles.lora,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // *Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                product.description,
                style: const TextStyle(
                  color: Colours.gray,
                  fontSize: 18,
                  fontWeight: FontStyles.regular,
                  fontFamily: FontStyles.leagueSpartan,
                  height: 1.2,
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colours.lightGray),
            ),
          ),
          child: Row(
            children: [
              // *Chat Button
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colours.deepGreen),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(ChatBuyersScreen.route),
                  child: const Text(
                    'Chat',
                    style: TextStyle(
                      color: Colours.deepGreen,
                      fontSize: 14,
                      fontWeight: FontStyles.regular,
                      fontFamily: FontStyles.leagueSpartan,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // *Cart Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () => doAddToCart(context, product),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        size: 16,
                        color: Colours.white,
                      ),
                      Text(
                        'Keranjang',
                        style: TextStyle(
                          color: Colours.white,
                          fontSize: 16,
                          fontWeight: FontStyles.regular,
                          fontFamily: FontStyles.leagueSpartan,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
