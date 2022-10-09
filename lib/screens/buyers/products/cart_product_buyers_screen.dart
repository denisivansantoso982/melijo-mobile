// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:intl/intl.dart';

class CartProductBuyersScreen extends StatefulWidget {
  const CartProductBuyersScreen({ Key? key }) : super(key: key);

  static const String route = '/cart_product_buyers_screen';

  @override
  _CartProductBuyersScreenState createState() => _CartProductBuyersScreenState();
}

class _CartProductBuyersScreenState extends State<CartProductBuyersScreen> {
  final List<Map<String, dynamic>> _listOfCart = [
    {
      'name': 'Buah Naga',
      'price': 14000,
      'quantity': 2,
      'image': 'buah_naga.jpg',
      'status': 'Menunggu Konfirmasi',
      'checked': false,
    },
  ];

  double totalPrice() {
    double total = 0;
    for (var element in _listOfCart) {
      if (element['checked']) total += element['price'] * element['quantity'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
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
          'Keranjang',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontStyles.bold,
            fontFamily: FontStyles.lora,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _listOfCart.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          elevation: 4,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image(
                        image: AssetImage('lib/assets/images/${_listOfCart[index]['image']}'),
                        fit: BoxFit.cover,
                        height: 80,
                      ),
                    ),
                    Checkbox(
                      value: _listOfCart[index]['checked'],
                      checkColor: Colours.white,
                      activeColor: Colours.deepGreen,
                      side: const BorderSide(color: Colours.deepGreen, width: 2,),
                      onChanged: (value) {
                        setState(() {
                          _listOfCart[index]['checked'] = !_listOfCart[index]['checked'];
                        });
                      },
                    ),
                  ],
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
                      // *Total Price
                      Text(
                        'Rp${NumberFormat('###,###').format(_listOfCart[index]['price']).replaceAll(',', '.')}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontStyles.lora,
                          color: Colours.deepGreen,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // *Product Name
                      Text(
                        _listOfCart[index]['name'],
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontStyles.regular,
                          fontFamily: FontStyles.leagueSpartan,
                          color: Colours.black.withOpacity(.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _listOfCart.removeAt(index);
                  });
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colours.black,
                  size: 36,
                ),
              ),
            ],
          ),
        ),
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
                  'Rp${totalPrice().round()}',
                  style: const TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontWeight: FontStyles.bold,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Batalkan Pesanan (${_listOfCart.where((element) => element['checked'] == true).length})',
                style: const TextStyle(
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