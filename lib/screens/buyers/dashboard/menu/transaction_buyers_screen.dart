// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:melijo/bloc/sellers/transactions/transaction_seller_bloc.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/sellers/transaction_seller_model.dart';
import 'package:melijo/screens/buyers/transactions/detail_transactions_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class TransactionBuyersScreen extends StatelessWidget {
  const TransactionBuyersScreen({Key? key}) : super(key: key);

  // ! Retrieve Transaction
  Future<void> retrieveTransaction(BuildContext context) async {
    try {
      await getTransactionCustomer(context);
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

  // ! Cancel Status
  Future<void> cancelTheTransaction(BuildContext context,
      TransactionSellerModel transactionSellerModel) async {
    try {
      LoadingWidget.show(context);
      await cancelTransaction(
        transactionSellerModel.txid,
      );
      await pushNotifToSeller('Transaksi ${transactionSellerModel.txid} Dibatalkan oleh pembeli!', 'Pembatalan Transaksi!');
      await retrieveTransaction(context);
      LoadingWidget.close(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.deepGreen,
        duration: Duration(seconds: 2),
        content: Text('Transaksi Dibatalkan!'),
      ));
      Navigator.of(context).pop();
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

  // ! Change Status to Indonesia
  String translateStatus(String status) {
    if (status == 'canceled') {
      return 'Dibatalkan';
    } else if (status == 'paid') {
      return 'Sudah Bayar';
    } else if (status == 'unpaid') {
      return 'Belum Bayar';
    } else if (status == 'waiting') {
      return 'Menunggu Produk';
    } else {
      return 'Pembayaran Diproses';
    }
  }

  @override
  Widget build(BuildContext context) {
    retrieveTransaction(context);
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
        leading: const SizedBox(),
        leadingWidth: 24,
        title: const Text(
          'Transaksi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontStyles.bold,
            fontFamily: FontStyles.lora,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => retrieveTransaction(context),
        child: BlocBuilder<TransactionSellerBloc, TransactionSellerState>(
          builder: (context, state) {
            if (state is TransactionSellerLoading) {
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
            if (state is TransactionSellerInit) {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.transactionSellerModel.length,
                itemBuilder: (context, index) {
                  final String total_price =
                      thousandFormat(state.transactionSellerModel[index].total);
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                        DetailTransactionScreen.route,
                        arguments: state.transactionSellerModel[index]),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ClipRRect(
                          //   borderRadius: const BorderRadius.only(
                          //     topLeft: Radius.circular(12),
                          //     bottomLeft: Radius.circular(12),
                          //   ),
                          //   child: Image(
                          //     image: const AssetImage('lib/assets/images/jambu.jpg'),
                          //     fit: BoxFit.cover,
                          //     height: screenSize.height / 4,
                          //     width: screenSize.width / 4,
                          //   ),
                          // ),
                          const SizedBox(width: 8),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // *Total
                                  Text(
                                    'Rp. $total_price',
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
                                    state.transactionSellerModel[index].txid,
                                    style: TextStyle(
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'League Spartan',
                                      color: Colours.black.withOpacity(.8),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // *Customer
                                  Text(
                                    translateStatus(state
                                        .transactionSellerModel[index].status),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontStyles.bold,
                                      fontFamily: FontStyles.leagueSpartan,
                                      color: Colours.deepGreen,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // *Delivery Date
                                  Text(
                                    'Pengiriman : ${DateFormat('dd-MMMM-yyyy').format(state.transactionSellerModel[index].date_order)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'League Spartan',
                                      color: Colours.black.withOpacity(.8),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // * Cancel Transaction Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (state.transactionSellerModel[index].status != 'canceled') {
                                          // * Confirmation
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
                                                title: 'Apakah anda yakin?',
                                                message: 'Apakah anda yakin ingin menghapus transaksi ${state.transactionSellerModel[index].txid}?',
                                                widgets: [
                                                  OutlinedButton(
                                                    style: OutlinedButton.styleFrom(
                                                      side: const BorderSide(color: Colours.deepGreen, width: 1),
                                                      fixedSize: const Size.fromWidth(80),
                                                    ),
                                                    onPressed: () => Navigator.of(context).pop(),
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
                                                      side: const BorderSide(color: Colours.deepGreen, width: 1),
                                                      fixedSize: const Size.fromWidth(80),
                                                    ),
                                                    onPressed: () => cancelTheTransaction(context, state.transactionSellerModel[index]),
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
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            state.transactionSellerModel[index]
                                                        .status !=
                                                    'canceled'
                                                ? Colours.deepGreen
                                                : Colours.gray,
                                      ),
                                      child: Text(
                                        state.transactionSellerModel[index]
                                                    .status ==
                                                'canceled'
                                            ? 'Dibatalkan'
                                            : 'Batalkan',
                                        style: const TextStyle(
                                          fontFamily: 'League Spartan',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colours.white,
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
                },
              );
            } else {
              return const Center(child: Text('Terjadi Kesalahan'));
            }
          },
        ),
      ),
    );
  }
}
