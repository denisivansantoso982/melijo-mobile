// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/sellers/transaction_seller_model.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class DetailTransactionScreen extends StatefulWidget {
  const DetailTransactionScreen({ Key? key }) : super(key: key);

  static const String route = '/detail_transaction_screen';

  @override
  _DetailTransactionScreenState createState() => _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends State<DetailTransactionScreen> {
  late TransactionSellerModel transactionSellerModel;

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

  Future<List> getDetailTransaction() async {
    try {
      final List result =
          await retrieveDetailTransactionSeller(transactionSellerModel.txid);
      return result;
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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    transactionSellerModel =
        ModalRoute.of(context)!.settings.arguments as TransactionSellerModel;
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
          'Detail Transaksi',
          style: TextStyle(
            color: Colours.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Lora',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getDetailTransaction(),
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
                  shrinkWrap: true,
                  itemCount: snapshot.hasData ? snapshot.data!.length : 0,
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
                                '${ApiRequest.baseStorageUrl}/${snapshot.data![index]['image']}'),
                            fit: BoxFit.cover,
                            height: screenSize.height / 8,
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
                                  'Rp. ${thousandFormat(snapshot.data![index]['subtotal'])}',
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
                                  '${snapshot.data![index]['product_name']} (x${snapshot.data![index]['quantity']})',
                                  style: TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'League Spartan',
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
                );
              },
            ),
            // const SizedBox(height: 16),
            // Text(
            //   'Pengiriman Tanggal : ${DateFormat('dd - MM - yyyy').format(transactionSellerModel.date_order)}',
            //   style: const TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontStyles.regular,
            //     fontFamily: FontStyles.leagueSpartan,
            //     color: Colours.gray,
            //   ),
            // ),
            // const SizedBox(height: 16),
            // Text(
            //   'Pemesan : ${transactionSellerModel.customer_name}',
            //   style: const TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontStyles.regular,
            //     fontFamily: FontStyles.leagueSpartan,
            //     color: Colours.gray,
            //   ),
            // ),
            // const SizedBox(height: 16),
            // Text(
            //   'Alamat : \n\n${transactionSellerModel.information}',
            //   style: const TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontStyles.regular,
            //     fontFamily: FontStyles.leagueSpartan,
            //     color: Colours.gray,
            //   ),
            // ),
          ],
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
                  'Rp. ${thousandFormat(transactionSellerModel.total)}',
                  style: const TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontWeight: FontStyles.bold,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (transactionSellerModel.status != 'canceled') {
                  cancelTheTransaction(
                    context,
                    transactionSellerModel,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: transactionSellerModel.status != 'canceled' ? Colours.deepGreen : Colours.gray,
              ),
              child: Text(
                transactionSellerModel.status != 'canceled' ? 'Batalkan' : 'Dibatalkan',
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