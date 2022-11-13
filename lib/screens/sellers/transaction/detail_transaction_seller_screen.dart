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

class DetailTransactionSellerScreen extends StatefulWidget {
  const DetailTransactionSellerScreen({Key? key}) : super(key: key);

  static const String route = '/detail_transaction_seller';

  @override
  _DetailTransactionSellerScreenState createState() =>
      _DetailTransactionSellerScreenState();
}

class _DetailTransactionSellerScreenState
    extends State<DetailTransactionSellerScreen> {
  late TransactionSellerModel transactionSellerModel;

  String packageName(String package) {
    String result = package.split('-')[2];
    return result;
  }

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
        backgroundColor: Colours.deepGreen,
        title: const Text(
          'Detail Transaksi',
          style: TextStyle(
            color: Colours.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Lora',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
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
                                const SizedBox(height: 4),
                                // *Package
                                Visibility(
                                  visible: snapshot.data![index]['grouping'] != 'none',
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4,),
                                    color: Colours.deepGreen,
                                    child: Text(
                                      packageName(snapshot.data![index]['grouping']),
                                      style: const TextStyle(
                                        color: Colours.white,
                                        fontSize: 16,
                                        fontFamily: FontStyles.leagueSpartan,
                                        fontWeight: FontStyles.regular,
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
            ),
            const SizedBox(height: 16),
            Text(
              'Pengiriman Tanggal : ${DateFormat('dd - MM - yyyy').format(transactionSellerModel.date_order)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontStyles.regular,
                fontFamily: FontStyles.leagueSpartan,
                color: Colours.gray,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Pemesan : ${transactionSellerModel.customer_name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontStyles.regular,
                fontFamily: FontStyles.leagueSpartan,
                color: Colours.gray,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Alamat : \n\n${transactionSellerModel.information}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontStyles.regular,
                fontFamily: FontStyles.leagueSpartan,
                color: Colours.gray,
              ),
            ),
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
                if (transactionSellerModel.status == 'paid') {
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
                        message: 'Apakah anda yakin untuk mengkonfirmasi transaksi ${transactionSellerModel.txid}?',
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
                            onPressed: () => confirmTheTransaction(context, transactionSellerModel),
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
                backgroundColor: transactionSellerModel.status == 'paid' ? Colours.deepGreen : Colours.gray,
              ),
              child: Text(
                transactionSellerModel.status == 'paid' ? 'Konfirmasi' : (transactionSellerModel.status == 'waiting' ? 'Sudah Dikonfirmasi' : (transactionSellerModel.status == 'canceled' ? 'Dibatalkan' : 'Menunggu...')),
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
