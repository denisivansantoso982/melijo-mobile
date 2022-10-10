// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/screens/buyers/communications/chat_buyers_screen.dart';
import 'package:melijo/screens/buyers/communications/notification_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/detail_product_buyers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class HomeBuyersScreen extends StatefulWidget {
  const HomeBuyersScreen({Key? key}) : super(key: key);

  @override
  _HomeBuyersScreenState createState() => _HomeBuyersScreenState();
}

class _HomeBuyersScreenState extends State<HomeBuyersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  final List<Map<String, String>> _listCategory = [
    {
      'title': 'Sayur',
      'image': 'vegetables.png',
    },
    {
      'title': 'Daging',
      'image': 'meats.png',
    },
    {
      'title': 'Unggas',
      'image': 'poultries.png',
    },
    {
      'title': 'Seafood',
      'image': 'seafoods.png',
    },
    {
      'title': 'Protein',
      'image': 'eggs.png',
    },
    {
      'title': 'Bumbu',
      'image': 'spices.png',
    },
  ];
  final List<Map<String, dynamic>> _listProduct = [
    {
      'name': 'Bawang Daun',
      'price': 16000,
      'image': 'bawang_daun.jpg',
    },
    {
      'name': 'Bawang Merah',
      'price': 21000,
      'image': 'bawang_merah.jpg',
    },
    {
      'name': 'Bawang Putih',
      'price': 27000,
      'image': 'bawang_putih.jpg',
    },
    {
      'name': 'Beras',
      'price': 13000,
      'image': 'beras.jpg',
    },
    {
      'name': 'Kangkung',
      'price': 8000,
      'image': 'kangkung.jpg',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    hintText: 'Cari nama produk',
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
            onPressed: () => Navigator.of(context).pushNamed(NotificationBuyersScreen.route),
            color: Colours.white,
            iconSize: 28,
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(ChatBuyersScreen.route),
            color: Colours.white,
            iconSize: 28,
            icon: const Icon(Icons.mail_outline_sharp),
          ),
        ],
        elevation: 0,
      ),
      body: ListView(
        children: [
          // *Welcome Panel
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1, -1),
                end: Alignment(-0.1, 0.6),
                colors: [
                  Colours.oliveGreen,
                  Colours.deepGreen,
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 56,
                  width: 56,
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(64)),
                    color: Colours.white,
                  ),
                  child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(64)),
                    child: Image(
                      image: AssetImage('lib/assets/images/jambu.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Halo, selamat datang Frans Achmad!',
                      style: TextStyle(
                        color: Colours.white,
                        fontSize: 18,
                        fontFamily: FontStyles.leagueSpartan,
                        fontWeight: FontStyles.regular,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Mau masak apa kamu hari ini?',
                      style: TextStyle(
                        color: Colours.white,
                        fontSize: 18,
                        fontFamily: FontStyles.leagueSpartan,
                        fontWeight: FontStyles.regular,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // *Category Panel
          SizedBox(
            height: 120,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _listCategory.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colours.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(64)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colours.black.withOpacity(.25),
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        child: Image(
                          image: AssetImage(
                              'lib/assets/images/category/${_listCategory[index]['image']}'),
                          fit: BoxFit.cover,
                          height: 32,
                          width: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${_listCategory[index]['title']}',
                      style: const TextStyle(
                        color: Colours.deepGreen,
                        fontSize: 16,
                        fontWeight: FontStyles.medium,
                        fontFamily: FontStyles.leagueSpartan,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // *Promo or Ads Panel
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              image: DecorationImage(
                image: AssetImage('lib/assets/images/recipes/nasgor.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: const Alignment(-1, -1),
                  end: const Alignment(0.2, 0.8),
                  colors: [
                    Colours.oliveGreen.withOpacity(.8),
                    Colours.deepGreen.withOpacity(.8),
                  ],
                ),
              ),
              child: const Text(
                'Temukan berbagai resep sehat di sini 🤩',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colours.white,
                  fontSize: 20,
                  fontWeight: FontStyles.bold,
                  fontFamily: FontStyles.lora,
                ),
              ),
            ),
          ),
          // *Products Panel
          GridView.builder(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            itemCount: _listProduct.length,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 4 / 5,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                DetailProductBuyersScreen.route,
                arguments: _listProduct[index],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colours.black.withOpacity(.25),
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // *Images
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: Image(
                        image: AssetImage(
                            'lib/assets/images/products/${_listProduct[index]['image']}'),
                        fit: BoxFit.cover,
                        height: screenSize.height / 6,
                      ),
                    ),
                    // *Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        _listProduct[index]['name'],
                        style: const TextStyle(
                          color: Colours.black,
                          fontFamily: FontStyles.leagueSpartan,
                          fontWeight: FontStyles.regular,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // *Price
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Rp${_listProduct[index]['price']}',
                        style: const TextStyle(
                          color: Colours.deepGreen,
                          fontFamily: FontStyles.leagueSpartan,
                          fontWeight: FontStyles.medium,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
