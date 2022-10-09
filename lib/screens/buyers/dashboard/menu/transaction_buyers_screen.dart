import 'package:flutter/material.dart';
import 'package:melijo/screens/buyers/transactions/detail_transactions_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class TransactionBuyersScreen extends StatelessWidget {
  const TransactionBuyersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
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
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // *Products
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(DetailTransactionScreen.route),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            image: AssetImage('lib/assets/images/jambu.jpg'),
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage('lib/assets/images/buah_naga.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // *Total
                          const Text(
                            'Rp42.000',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontStyles.lora,
                              color: Colours.deepGreen,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // *Product Name
                          Text(
                            'Jambu Crystal, Buah Naga',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontStyles.leagueSpartan,
                              color: Colours.black.withOpacity(.8),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // *Status
                          const Text(
                            'Menunggu Konfirmasi',
                            style: TextStyle(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontStyles.medium,
                              fontFamily: FontStyles.leagueSpartan,
                              color: Colours.deepGreen,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // *Delivery Date
                          const Text(
                            'Pengiriman : 24 Oktober 2022',
                            style: TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontStyles.leagueSpartan,
                              color: Colours.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
