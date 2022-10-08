import 'package:flutter/material.dart';
import 'package:melijo/screens/sellers/products/add_product_sellers_screen.dart';
import 'package:melijo/screens/sellers/products/edit_product_sellers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

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
            onPressed: () =>
                Navigator.of(context).pushNamed(AddProductSellerScreen.route),
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

  static Widget productIsExist(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // *Product Count
        Card(
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        'Jambu Crystal',
                        style: TextStyle(
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'League Spartan',
                          color: Colours.black.withOpacity(.8),
                        ),
                      ),
                      // *Edit Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pushNamed(
                            EditProductSellerScreen.route,
                            arguments: {
                              'pictures': [
                                'jambu.jpg',
                                'buah_naga.jpg',
                              ],
                              'name': 'Jambu Crystal',
                              'category': 'Sayur',
                              'price': '28000',
                              'description': 'gatau!!!',
                            },
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colours.deepGreen),
                          ),
                          child: const Text(
                            'Ubah Harga',
                            style: TextStyle(
                              fontFamily: 'League Spartan',
                              fontWeight: FontStyles.regular,
                              fontSize: 18,
                              color: Colours.deepGreen,
                            ),
                          ),
                        ),
                      ),
                      // *Delete Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colours.deepGreen),
                          ),
                          child: const Text(
                            'Hapus Produk',
                            style: TextStyle(
                              fontFamily: 'League Spartan',
                              fontWeight: FontStyles.regular,
                              fontSize: 18,
                              color: Colours.deepGreen,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    // final List<dynamic>? argu =
    //     ModalRoute.of(context)?.settings.arguments as List<dynamic>?;

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
            onPressed: () =>
                Navigator.of(context).pushNamed(AddProductSellerScreen.route),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: productIsExist(context),
      // body: argu == null || argu.isEmpty
      //     ? productIsEmpty(context)
      //     : productIsExist(context),
    );
  }
}
