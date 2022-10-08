import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';

class TransactionSellersScreen extends StatelessWidget {
  const TransactionSellersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // *Product Count
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image(
                    image: const AssetImage('lib/assets/images/jambu.jpg'),
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
                      children: [
                        // *Total
                        const Text(
                          'Rp. 28.000',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lora',
                            color: Colours.deepGreen,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // *Product Name
                        Text(
                          'Jambu Crystal Asli Segar Murah',
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
                          'Pengiriman : 24 Oktober 2022',
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
                          'Pembeli : Denis Ivan',
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
                            onPressed: () {},
                            child: const Text(
                              'Konfirmasi',
                              style: TextStyle(
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
        ],
      ),
    );
  }
}
