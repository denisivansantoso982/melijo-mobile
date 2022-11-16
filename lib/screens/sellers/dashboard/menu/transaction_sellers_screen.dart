// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:melijo/bloc/sellers/transactions/transaction_seller_bloc.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/sellers/transaction_seller_model.dart';
import 'package:melijo/screens/sellers/communications/notification_sellers_screen.dart';
import 'package:melijo/screens/sellers/transaction/detail_transaction_seller_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';
import 'package:melijo/widgets/notification_widget.dart';

class TransactionSellersScreen extends StatelessWidget {
  const TransactionSellersScreen({Key? key}) : super(key: key);

  // ! Retrieve Transaction
  Future<void> retrieveTransaction(BuildContext context) async {
    try {
      await getTransactionSeller(context);
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

  // ! Confirm Status
  Future<void> confirmTheTransaction(BuildContext context,
      TransactionSellerModel transactionSellerModel) async {
    try {
      LoadingWidget.show(context);
      await confirmTransaction(
        transactionSellerModel.txid,
        transactionSellerModel.promo_code,
        transactionSellerModel.seller_id,
        transactionSellerModel.customer_id,
        transactionSellerModel.total,
        transactionSellerModel.operator_id,
      );
      await pushNotifToCust(transactionSellerModel.customer_id, 'Transaksi ${transactionSellerModel.txid} telah dikonfirmasi oleh penjual!', 'Konfirmasi Transaksi!');
      await retrieveTransaction(context);
      LoadingWidget.close(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.deepGreen,
        duration: Duration(seconds: 2),
        content: Text('Transaksi dikonfirmasi!'),
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

  @override
  Widget build(BuildContext context) {
    retrieveTransaction(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.deepGreen,
        title: const Text(
          'Daftar Transaksi',
          style: TextStyle(
            color: Colours.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Lora',
          ),
        ),
        actions: [
          NotificationWidget(
            onPress: () => Navigator.of(context).pushNamed(NotificationSellersScreen.route),
          ),
        ],
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
                    onTap: () => Navigator.of(context).pushNamed(DetailTransactionSellerScreen.route, arguments: state.transactionSellerModel[index]),
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
                                  // *Customer
                                  Text(
                                    'Pembeli : ${state.transactionSellerModel[index].customer_name}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'League Spartan',
                                      color: Colours.black.withOpacity(.8),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // *Confirmation Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (state.transactionSellerModel[index].status == 'paid') {
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
                                                message: 'Apakah anda yakin untuk mengkonfirmasi transaksi ${state.transactionSellerModel[index].txid}?',
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
                                                    onPressed: () => confirmTheTransaction(context, state.transactionSellerModel[index]),
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
                                        backgroundColor: state.transactionSellerModel[index].status == 'paid' ? Colours.deepGreen : Colours.gray,
                                      ),
                                      child: Text(
                                        state.transactionSellerModel[index].status == 'paid' ? 'Konfirmasi' : (state.transactionSellerModel[index].status == 'waiting' ? 'Sudah Dikonfirmasi' : (state.transactionSellerModel[index].status == 'canceled' ? 'Dibatalkan' : 'Menunggu...')),
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
