// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({ Key? key }) : super(key: key);

  static const String route = '/promo_screen';

  @override
  _PromoScreenState createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
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
          'Pilih Promo yang Tersedia',
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
          // * Promo 1
          GestureDetector(
            onTap: () => Navigator.of(context).pop('Diskon Rp5.000 untuk pengguna baru'),
            child: const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
                child: Text(
                  'Diskon Rp5.000 untuk pengguna baru',
                  style: TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}