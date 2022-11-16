// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/screens/sellers/communications/notification_sellers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/widgets/notification_widget.dart';

class MenuSellersScreen extends StatefulWidget {
  const MenuSellersScreen({Key? key}) : super(key: key);

  @override
  State<MenuSellersScreen> createState() => _MenuSellersScreenState();
}

class _MenuSellersScreenState extends State<MenuSellersScreen> {
  String name = '';

  @override
  initState() {
    super.initState();
    getUserDetail();
  }

  Future<void> getUserDetail() async {
    final Map user_data = await getUserInfo();
    setState(() {
      name = user_data['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.deepGreen,
        title: Text(
          'Halo, $name',
          style: const TextStyle(
            color: Colours.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Lora',
          ),
        ),
        actions: [
          NotificationWidget(
            onPress: () => Navigator.of(context).pushNamed(NotificationSellersScreen.route),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => sellerInfoCount(),
        child: FutureBuilder(
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
                          snapshot.connectionState == ConnectionState.waiting
                              ? 'Memuat...'
                              : (snapshot.hasError
                                  ? 'Terjadi Kesalahan!'
                                  : '${snapshot.data?['product_count']}'),
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
                          snapshot.connectionState == ConnectionState.waiting
                              ? 'Memuat...'
                              : (snapshot.hasError
                                  ? 'Terjadi Kesalahan!'
                                  : '${snapshot.data?['transaction_count']}'),
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
      ),
    );
  }
}
