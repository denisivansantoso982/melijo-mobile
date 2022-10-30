import 'package:flutter/material.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/utils/colours.dart';

class MenuSellersScreen extends StatelessWidget {
  const MenuSellersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colours.deepGreen,
        title: const Text(
          'Halo, Ardi Sanjaya',
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
          )
        ],
      ),
      body: FutureBuilder(
        future: sellerInfoCount(),
        builder: (context, snapshot) {
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              // *Product Count
              Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Jumlah Produk',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'League Spartan',
                          color: Colours.deepGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.connectionState == ConnectionState.waiting ? 'Memuat...' : (
                          snapshot.hasError ? 'Terjadi Kesalahan!' : '${snapshot.data?['product_count']}'
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'League Spartan',
                          color: Colours.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // *New Order
              Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Pesanan Baru',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'League Spartan',
                          color: Colours.deepGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.connectionState == ConnectionState.waiting ? 'Memuat...' : (
                          snapshot.hasError ? 'Terjadi Kesalahan!' : '${snapshot.data?['transaction_count']}'
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'League Spartan',
                          color: Colours.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
