// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melijo/bloc/buyers/cart/cart_buyers_bloc.dart';
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
  _CartProductBuyersScreenState createState() =>
      _CartProductBuyersScreenState();
}

class _CartProductBuyersScreenState extends State<CartProductBuyersScreen> {
  List<CartBuyersModel> _listCart = [];

  int totalPrice() {
    int total = 0;
    for (var element in _listCart) {
      if (element.checked) {
        total += element.product.price * element.quantity;
      }
    }
    return total;
  }

  Future<void> getCarts(BuildContext context) async {
    try {
      await retrieveCart(context);
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

  Future<void> deleteCart(
      BuildContext context, int cart_id, int product_id) async {
    try {
      LoadingWidget.show(context);
      await deleteProductCart(context, cart_id);
      setState(() {});
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
      body: FutureBuilder(
        future: getCarts(context),
        builder: (context, snapshot) => RefreshIndicator(
          onRefresh: () => getCarts(context),
          child: BlocBuilder<CartBuyersBloc, CartBuyersState>(
            builder: (context, state) {
              if (state is CartBuyersLoading) {
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
              if (state is CartBuyersInit) {
                _listCart = state.carts;
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.carts.length,
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
                                      '${ApiRequest.baseStorageUrl}/${state.carts[index].product.image_uri}'),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  height: 80,
                                ),
                              ),
                              Checkbox(
                                value: state.carts[index].checked,
                                checkColor: Colours.white,
                                activeColor: Colours.deepGreen,
                                side: const BorderSide(
                                  color: Colours.deepGreen,
                                  width: 2,
                                ),
                                onChanged: (value) {
                                  context.read<CartBuyersBloc>().add(ToggleCart(
                                      carts: state.carts,
                                      cart_id: state.carts[index].id));
                                  setState(() {});
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
                                  'Rp. ${thousandFormat(state.carts[index].product.price * state.carts[index].quantity)}',
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
                                  '${state.carts[index].product.product_name} (x${state.carts[index].quantity})',
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
                              context,
                              state.carts[index].id,
                              state.carts[index].product_id),
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colours.black,
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('Terjadi Kesalahan'));
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBuyersBloc, CartBuyersState>(
        builder: (context, state) {
          return Container(
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
                      state is CartBuyersLoading
                          ? 'Memuat...'
                          : 'Rp. ${thousandFormat(totalPrice())}',
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
                        totalPrice() > 0 ? Colours.deepGreen : Colours.gray,
                  ),
                  onPressed: () {
                    if (totalPrice() > 0) {
                      Navigator.of(context).pushNamed(
                        DistributionDateScreen.route,
                        arguments: state is CartBuyersInit ? state.carts : _listCart,
                      );
                    }
                  },
                  child: Text(
                    'Beli (${_listCart.where((element) => element.checked).toList().length})',
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
          );
        },
      ),
    );
  }
}
