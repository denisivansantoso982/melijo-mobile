// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({ Key? key }) : super(key: key);

  static const String route = '/payment_method_screen';

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
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
          'Metode Pembayaran',
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
          // * Online Payment
          GestureDetector(
            onTap: () => Navigator.of(context).pop('Online Payment Via Midtrans'),
            child: const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
                child: Text(
                  'Online Payment Via Midtrans',
                  style: TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // * Online Payment
          GestureDetector(
            onTap: () => Navigator.of(context).pop('Bayar di tempat'),
            child: const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
                child: Text(
                  'Bayar di tempat',
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