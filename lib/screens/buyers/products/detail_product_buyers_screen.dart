import 'package:flutter/material.dart';
import 'package:melijo/screens/buyers/communications/chat_buyers_screen.dart';
import 'package:melijo/screens/buyers/communications/notification_buyers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class DetailProductBuyersScreen extends StatefulWidget {
  const DetailProductBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/detail_product_screen';

  @override
  State<DetailProductBuyersScreen> createState() => _DetailProductBuyersScreenState();
}

class _DetailProductBuyersScreenState extends State<DetailProductBuyersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  final PageController _pageController = PageController(initialPage: 0);


  void doAddToCart(BuildContext context, Map<String, dynamic> arguments) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            // *First Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // *Image
                Expanded(
                  flex: 3,
                  child: Image(
                    image: AssetImage('lib/assets/images/products/${arguments['image']}'),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                // *Name and Price
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // *Price
                      Text(
                        'Rp${arguments['price']}',
                        style: const TextStyle(
                          color: Colours.deepGreen,
                          fontSize: 22,
                          fontWeight: FontStyles.bold,
                          fontFamily: FontStyles.lora,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // *Title
                      Text(
                        '${arguments['name']}',
                        style: const TextStyle(
                          color: Colours.gray,
                          fontSize: 18,
                          fontWeight: FontStyles.regular,
                          fontFamily: FontStyles.leagueSpartan,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // *Close Button
                Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      color: Colours.gray,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // *Second Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jumlah',
                  style: TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontFamily: FontStyles.leagueSpartan,
                    fontWeight: FontStyles.medium,
                  ),
                ),
                Row(
                  children: [
                    // *Reduce Button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        color: Colours.lightGray,
                        child: const Icon(
                          Icons.remove,
                          color: Colours.gray,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // *Quantity
                    const Text(
                      '1',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colours.gray,
                        fontFamily: FontStyles.leagueSpartan,
                        fontWeight: FontStyles.regular,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // *Add Button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        color: Colours.lightGray,
                        child: const Icon(
                          Icons.add,
                          color: Colours.gray,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // *Third Row
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Tambahkan ke Keranjang',
                        style: TextStyle(
                          color: Colours.white,
                          fontSize: 16,
                          fontFamily: FontStyles.leagueSpartan,
                          fontWeight: FontStyles.medium,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colours.white,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            onPressed: () => Navigator.of(context).pushNamed(NotificationBuyersScreen.route),
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
          SizedBox(
            width: screenSize.width,
            height: screenSize.width,
            child: PageView(
              controller: _pageController,
              children: [
                Image(
                  image: AssetImage('lib/assets/images/products/${arguments['image']}'),
                  fit: BoxFit.cover,
                  width: screenSize.width,
                  height: screenSize.width,
                ),
                Image(
                  image: AssetImage('lib/assets/images/products/${arguments['image']}'),
                  fit: BoxFit.cover,
                  width: screenSize.width,
                  height: screenSize.width,
                ),
              ],
            ),
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
                onPressed: () => Navigator.of(context).pushNamed(ChatBuyersScreen.route),
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
                onPressed: () => doAddToCart(context, arguments),
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
