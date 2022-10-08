import 'package:flutter/material.dart';
import 'package:melijo/screens/sellers/products/add_product_sellers_screen.dart';
import 'package:melijo/utils/colours.dart';

class ProductSellersScreen extends StatelessWidget {
  const ProductSellersScreen({Key? key}) : super(key: key);

  static Widget productIsEmpty(BuildContext context) {
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
            onPressed: () => Navigator.of(context).pushNamed(AddProductSellerScreen.route),
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

  @override
  Widget build(BuildContext context) {
    final List<dynamic>? argu = ModalRoute.of(context)?.settings.arguments as List<dynamic>?;

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
            onPressed: () => Navigator.of(context).pushNamed(AddProductSellerScreen.route),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: argu == null || argu.isEmpty ? productIsEmpty(context) : ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // *Product Count
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: const [
                  Text(
                    'Jumlah Produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                      color: Colours.deepGreen,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1',
                    style: TextStyle(
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
      ),
    );
  }
}
