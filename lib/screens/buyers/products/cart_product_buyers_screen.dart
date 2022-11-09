// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/buyers/cart_buyers_model.dart';
import 'package:melijo/screens/buyers/transactions/distribution_date_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class CartProductBuyersScreen extends StatefulWidget {
  const CartProductBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/cart_product_buyers_screen';

  @override
  State<CartProductBuyersScreen> createState() =>
      _CartProductBuyersScreenState();
}

class _CartProductBuyersScreenState extends State<CartProductBuyersScreen> {
  final List<CartBuyersModel> carts = [];
  bool _loadingCart = true;

  @override
  void initState() {
    getCarts();
    super.initState();
  }

  int totalPrice(List<CartBuyersModel> _listCart) {
    int total = 0;
    for (var element in _listCart) {
      if (element.checked) {
        total += element.product.price * element.quantity;
      }
    }
    return total;
  }

  Future<void> getCarts() async {
    try {
      final List<CartBuyersModel> resCarts = await retrieveCart();
      setState(() {
        carts.clear();
        carts.addAll(resCarts);
        _loadingCart = false;
      });
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

  // Future<void> getCarts(BuildContext context) async {
  //   try {
  //     final List<CartBuyersModel> carts = await retrieveCart(context);
  //     context.read<CartBuyersBloc>().add(FillCart(carts: carts));
  //   } catch (error) {
  //     showModalBottomSheet(
  //       backgroundColor: Colors.transparent,
  //       context: context,
  //       builder: (context) => Container(
  //         padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
  //         decoration: const BoxDecoration(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //           color: Colours.white,
  //         ),
  //         child: ModalBottom(
  //           title: 'Terjadi Kesalahan!',
  //           message: '$error',
  //           widgets: [
  //             OutlinedButton(
  //               style: OutlinedButton.styleFrom(
  //                 side: const BorderSide(color: Colours.deepGreen, width: 1),
  //                 fixedSize: const Size.fromWidth(80),
  //               ),
  //               onPressed: () => Navigator.of(context).pop(),
  //               child: const Text(
  //                 'Oke',
  //                 style: TextStyle(
  //                   color: Colours.deepGreen,
  //                   fontSize: 18,
  //                   fontWeight: FontStyles.regular,
  //                   fontFamily: FontStyles.leagueSpartan,
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }

  Future<void> deleteCart(
      BuildContext context, int cart_id, int product_id) async {
    try {
      LoadingWidget.show(context);
      await deleteProductCart(cart_id);
      setState(() {
        carts.removeWhere((element) => element.id == cart_id);
      });
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
          'Keranjang',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontStyles.bold,
            fontFamily: FontStyles.lora,
          ),
        ),
      ),
      body: _loadingCart ? const Center(
        child: SizedBox(
          width: 56,
          height: 56,
          child: CircularProgressIndicator(
            color: Colours.deepGreen,
            strokeWidth: 4,
          ),
        ),
      ) : RefreshIndicator(
        onRefresh: () => getCarts(),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: carts.length,
          itemBuilder: (context, index) => Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // *Product Image
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: Image(
                          image: NetworkImage(
                              '${ApiRequest.baseStorageUrl}/${carts[index].product.image_uri}'),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          height: 80,
                        ),
                      ),
                      Checkbox(
                        value: carts[index].checked,
                        checkColor: Colours.white,
                        activeColor: Colours.deepGreen,
                        side: const BorderSide(
                          color: Colours.deepGreen,
                          width: 2,
                        ),
                        onChanged: (value) {
                          // context.read<CartBuyersBloc>().add(ToggleCart(
                          //     carts: carts,
                          //     cart_id: carts[index].id));
                          setState(() {
                            carts[index].checked = !carts[index].checked;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // *Product Information
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // *Total Price
                        Text(
                          'Rp. ${thousandFormat(carts[index].product.price * carts[index].quantity)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontStyles.lora,
                            color: Colours.deepGreen,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // *Product Name
                        Text(
                          '${carts[index].product.product_name} (x${carts[index].quantity})',
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
                IconButton(
                  onPressed: () => deleteCart(
                      context, carts[index].id, carts[index].product_id),
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
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        height: 72,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colours.lightGray,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // *Total Price
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Harga',
                  style: TextStyle(
                    color: Colours.black,
                    fontSize: 14,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
                Text(
                  'Rp. ${thousandFormat(totalPrice(carts))}',
                  style: const TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontWeight: FontStyles.bold,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              ],
            ),
            // *Buy Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                backgroundColor:
                    totalPrice(carts) > 0 ? Colours.deepGreen : Colours.gray,
              ),
              onPressed: () {
                if (totalPrice(carts) > 0) {
                  Navigator.of(context).pushNamed(
                    DistributionDateScreen.route,
                    arguments: carts,
                  );
                }
              },
              child: Text(
                'Beli (${carts.where((element) => element.checked).toList().length})',
                style: const TextStyle(
                  color: Colours.white,
                  fontSize: 14,
                  fontWeight: FontStyles.medium,
                  fontFamily: FontStyles.leagueSpartan,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
