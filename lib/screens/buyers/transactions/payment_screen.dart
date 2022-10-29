// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:melijo/screens/buyers/transactions/payment_method_screen.dart';
import 'package:melijo/screens/buyers/transactions/promo_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  static const String route = '/payment_screen';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late List<Map> products;
  String? payment_method;
  String? selected_promo;
  bool paid = false;

  int totalEachProduct(int index) {
    return products[index]['price'] * products[index]['quantity'];
  }

  int totalProduct() {
    int total = 0;
    for (Map element in products) {
      total += (element['price'] * element['quantity']) as int;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    products = arguments['products'];
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
        title: const Text(
          'Pembayaran',
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
          // * Product List
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // * Product
                Expanded(
                  flex: 3,
                  child: Text(
                    '${products[index]['name']} (x${products[index]['quantity']})',
                    style: const TextStyle(
                      color: Colours.black,
                      fontFamily: FontStyles.leagueSpartan,
                      fontWeight: FontStyles.regular,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
                // * Total Price for each product
                Expanded(
                  flex: 1,
                  child: Text(
                    'Rp${totalEachProduct(index)}',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colours.gray,
                      fontFamily: FontStyles.leagueSpartan,
                      fontWeight: FontStyles.regular,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: Colours.gray,
                    width: 1,
                  )),
                ),
              )),
              const Text(
                ' +',
                style: TextStyle(
                  color: Colours.gray,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topRight,
            child: Text(
              'Rp${totalProduct()}',
              style: const TextStyle(
                color: Colours.gray,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // * Payment Method
          GestureDetector(
            onTap: () async {
              String? result = await Navigator.of(context)
                  .pushNamed(PaymentMethodScreen.route) as String?;
              setState(() {
                payment_method = result;
              });
            },
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        payment_method ?? 'Pilih Metode Pembayaran',
                        style: const TextStyle(
                          color: Colours.black,
                          fontSize: 16,
                          fontFamily: FontStyles.leagueSpartan,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 32,
                      color: Colours.black,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // * Promo
          GestureDetector(
            onTap: () async {
              String? result = await Navigator.of(context)
                  .pushNamed(PromoScreen.route) as String?;
              setState(() {
                selected_promo = result;
              });
            },
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        selected_promo ?? 'Pilih Promo yang Tersedia',
                        style: const TextStyle(
                          color: Colours.black,
                          fontSize: 16,
                          fontFamily: FontStyles.leagueSpartan,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 32,
                      color: Colours.black,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: payment_method == null ? false : true,
            child: Column(
              children: [
                const Text(
                  'Midtrans adalah salah satu layanan online terbaik yang dapat memudahkan anda dalam menyelesaikan proses pembayaran dengan cepat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontFamily: FontStyles.leagueSpartan,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Silahkan Klik Tombol dibawah untuk transaksi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontFamily: FontStyles.leagueSpartan,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () {
                    setState(() {
                      paid = true;
                    });
                  },
                  child: const Text(
                    'Bayar',
                    style: TextStyle(
                      color: Colours.white,
                      fontSize: 18,
                      fontWeight: FontStyles.medium,
                      fontFamily: FontStyles.leagueSpartan,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  paid
                      ? 'Status : Anda sudah membayar'
                      : 'Status : Anda belum membayar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: paid ? Colours.deepGreen : Colours.gray,
                    fontSize: 20,
                    fontFamily: FontStyles.lora,
                    fontWeight: FontStyles.medium,
                  ),
                ),
              ],
            ),
          ),
        ],
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
            // *Total Price
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
                  'Rp${totalProduct()}',
                  style: const TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontWeight: FontStyles.bold,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              ],
            ),
            // *Buy Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                backgroundColor: !paid ? Colours.gray : Colours.deepGreen,
              ),
              onPressed: () {
                if (paid) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Pesanan Selesai'),
                  ));
                }
              },
              child: const Text(
                'Selesaikan Pesanan',
                style: TextStyle(
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
