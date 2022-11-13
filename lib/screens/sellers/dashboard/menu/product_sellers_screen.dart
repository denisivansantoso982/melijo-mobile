// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melijo/bloc/sellers/products/product_seller_bloc.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/sellers/product_seller_model.dart';
import 'package:melijo/screens/sellers/products/add_product_sellers_screen.dart';
import 'package:melijo/screens/sellers/products/edit_product_sellers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class ProductSellersScreen extends StatefulWidget {
  const ProductSellersScreen({Key? key}) : super(key: key);

  @override
  State<ProductSellersScreen> createState() => _ProductSellersScreenState();
}

class _ProductSellersScreenState extends State<ProductSellersScreen> {
  Widget productIsEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Upload produk pertama anda sekarang',
            style: TextStyle(
              color: Colours.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: 'League Spartan',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddProductSellerScreen.route),
            style: ElevatedButton.styleFrom().copyWith(
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 24,
              )),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              )),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.add),
                SizedBox(width: 4),
                Text(
                  'Tambahkan Produk',
                  style: TextStyle(
                    color: Colours.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'League Spartan',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productIsExist(
      BuildContext context, List<ProductSellerModel> listProduct) {
    final Size screenSize = MediaQuery.of(context).size;
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: listProduct.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image(
                image: NetworkImage(
                    '${ApiRequest.baseStorageUrl}/${listProduct[index].image_uri}'),
                fit: BoxFit.cover,
                height: screenSize.height / 4,
                width: screenSize.width / 4,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // *Total
                    Text(
                      'Rp. ${thousandFormat(listProduct[index].price)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lora',
                        color: Colours.deepGreen,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // *Product Name
                    Text(
                      listProduct[index].product_name,
                      style: TextStyle(
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'League Spartan',
                        color: Colours.black.withOpacity(.8),
                      ),
                    ),
                    // *Edit Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                          EditProductSellerScreen.route,
                          arguments: listProduct[index],
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colours.deepGreen),
                        ),
                        child: const Text(
                          'Ubah Harga',
                          style: TextStyle(
                            fontFamily: 'League Spartan',
                            fontWeight: FontStyles.regular,
                            fontSize: 18,
                            color: Colours.deepGreen,
                          ),
                        ),
                      ),
                    ),
                    // *Delete Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 28, horizontal: 20),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                color: Colours.white,
                              ),
                              child: ModalBottom(
                                title: 'Apakah anda yakin?',
                                message:
                                    'Apakah anda yakin untuk menghpus produk ${listProduct[index].product_name}?',
                                widgets: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colours.deepGreen, width: 1),
                                      fixedSize: const Size.fromWidth(80),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text(
                                      'Tidak',
                                      style: TextStyle(
                                        color: Colours.deepGreen,
                                        fontSize: 18,
                                        fontWeight: FontStyles.regular,
                                        fontFamily: FontStyles.leagueSpartan,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colours.deepGreen, width: 1),
                                      fixedSize: const Size.fromWidth(80),
                                    ),
                                    onPressed: () => deleteProduct(
                                        context, listProduct[index].id),
                                    child: const Text(
                                      'Ya',
                                      style: TextStyle(
                                        color: Colours.white,
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
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colours.deepGreen),
                        ),
                        child: const Text(
                          'Hapus Produk',
                          style: TextStyle(
                            fontFamily: 'League Spartan',
                            fontWeight: FontStyles.regular,
                            fontSize: 18,
                            color: Colours.deepGreen,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> retrieveProducts(BuildContext context) async {
    try {
      await getProductsSeller(context);
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

  Future<void> deleteProduct(BuildContext context, int id) async {
    try {
      LoadingWidget.show(context);
      await deleteProductSeller(id);
      await getProductsSeller(context);
      LoadingWidget.close(context);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.deepGreen,
        duration: Duration(seconds: 2),
        content: Text('Produk dihapus!'),
      ));
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
    retrieveProducts(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.deepGreen,
        title: const Text(
          'Daftar Produk',
          style: TextStyle(
            color: Colours.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Lora',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddProductSellerScreen.route),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => retrieveProducts(context),
        child: BlocBuilder<ProductSellerBloc, ProductSellerState>(
          builder: (context, state) {
            if (state is ProductSellerLoading) {
              return const Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    color: Colours.deepGreen,
                    strokeWidth: 4,
                  ),
                ),
              );
            }
            if (state is ProductSellerInit) {
              if (state.productsSeller.isEmpty) {
                return productIsEmpty(context);
              }
              return productIsExist(context, state.productsSeller);
            } else {
              return const Center(child: Text('Terjadi Kesalahan'));
            }
          },
        ),
      ),
    );
  }
}
