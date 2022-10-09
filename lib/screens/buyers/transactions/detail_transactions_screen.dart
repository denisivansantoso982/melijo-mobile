// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class DetailTransactionScreen extends StatefulWidget {
  const DetailTransactionScreen({ Key? key }) : super(key: key);

  static const String route = '/detail_transaction_screen';

  @override
  _DetailTransactionScreenState createState() => _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends State<DetailTransactionScreen> {
  final List<Map<String, dynamic>> _listOfTransaction = [
    {
      'name': 'Buah Naga',
      'price': '14.000',
      'image': 'buah_naga.jpg',
      'status': 'Menunggu Konfirmasi',
      'checked': false,
    },
    {
      'name': 'Jambu Crystal',
      'price': '28.000',
      'image': 'jambu.jpg',
      'status': 'Menunggu Konfirmasi',
      'checked': false,
    },
  ];

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
          'Transaksi',
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
        itemCount: _listOfTransaction.length,
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
                        image: AssetImage('lib/assets/images/${_listOfTransaction[index]['image']}'),
                        fit: BoxFit.cover,
                        height: 80,
                      ),
                    ),
                    Checkbox(
                      value: _listOfTransaction[index]['checked'],
                      checkColor: Colours.white,
                      activeColor: Colours.deepGreen,
                      side: const BorderSide(color: Colours.deepGreen),
                      onChanged: (value) {
                        setState(() {
                          _listOfTransaction[index]['checked'] = !_listOfTransaction[index]['checked'];
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
                        'Rp${_listOfTransaction[index]['price']}',
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
                        _listOfTransaction[index]['name'],
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontStyles.regular,
                          fontFamily: FontStyles.leagueSpartan,
                          color: Colours.black.withOpacity(.8),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // *Status
                      Text(
                        _listOfTransaction[index]['status'],
                        style: const TextStyle(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontStyles.medium,
                          fontFamily: FontStyles.leagueSpartan,
                          color: Colours.deepGreen,
                        ),
                      ),
                    ],
                  ),
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
              children: const [
                Text(
                  'Total Harga',
                  style: TextStyle(
                    color: Colours.black,
                    fontSize: 14,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
                Text(
                  'Rp42.000',
                  style: TextStyle(
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
                'Batalkan Pesanan (${_listOfTransaction.where((element) => element['checked'] == true).length})',
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