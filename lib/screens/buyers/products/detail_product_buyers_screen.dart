import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class DetailProductBuyersScreen extends StatelessWidget {
  const DetailProductBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/detail_product_screen';

  static final TextEditingController _searchController = TextEditingController();
  static final FocusNode _searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Size screenSize = MediaQuery.of(context).size;
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
        title: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colours.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  focusNode: _searchFocus,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.all(4),
                    hintText: 'Cari Resep produk',
                  ),
                ),
              ),
              const Icon(
                Icons.search_sharp,
                color: Colours.gray,
                size: 28,
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            color: Colours.white,
            iconSize: 28,
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
        elevation: 0,
      ),
      body: ListView(
        children: [
          // *Images
          Image(
            image: AssetImage('lib/assets/images/products/${arguments['image']}'),
            fit: BoxFit.cover,
            height: screenSize.height * 0.4,
          ),
          const SizedBox(height: 12),
          // *Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Rp${arguments['price']}',
              style: const TextStyle(
                color: Colours.deepGreen,
                fontSize: 22,
                fontWeight: FontStyles.bold,
                fontFamily: FontStyles.lora,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // *Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${arguments['name']}',
              style: const TextStyle(
                color: Colours.black,
                fontSize: 22,
                fontWeight: FontStyles.bold,
                fontFamily: FontStyles.lora,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // *Description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis id varius urna, vel facilisis diam. Donec auctor pretium porta. Aenean in odio at est hendrerit rhoncus vel sit amet tortor. Aenean consequat ...',
              style: TextStyle(
                color: Colours.gray,
                fontSize: 18,
                fontWeight: FontStyles.regular,
                fontFamily: FontStyles.leagueSpartan,
                height: 1.2
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colours.lightGray),
          ),
        ),
        child: Row(
          children: [
            // *Chat Button
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colours.deepGreen),
                ),
                onPressed: () {},
                child: const Text(
                  'Chat',
                  style: TextStyle(
                    color: Colours.deepGreen,
                    fontSize: 14,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // *Cart Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add,
                      size: 16,
                      color: Colours.white,
                    ),
                    Text(
                      'Keranjang',
                      style: TextStyle(
                        color: Colours.white,
                        fontSize: 16,
                        fontWeight: FontStyles.regular,
                        fontFamily: FontStyles.leagueSpartan,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
