// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/buyers/cart_buyers_model.dart';
import 'package:melijo/screens/buyers/transactions/distribution_address_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class DistributionDateScreen extends StatefulWidget {
  const DistributionDateScreen({Key? key}) : super(key: key);

  static const String route = '/distribution_date_screen';

  @override
  _DistributionDateScreenState createState() => _DistributionDateScreenState();
}

class _DistributionDateScreenState extends State<DistributionDateScreen> {
  int _selectedDateIndex = -1;
  final List<DateTime> _listOfDate = [];
  late List<CartBuyersModel> _listCart;

  @override
  void initState() {
    _listOfDate.add(DateTime.now().add(const Duration(days: 1)));
    _listOfDate.add(DateTime.now().add(const Duration(days: 2)));
    super.initState();
  }

  int totalPrice() {
    int total = 0;
    for (var element in _listCart) {
      if (element.checked) {
        total += element.product.price * element.quantity;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    _listCart = ModalRoute.of(context)!.settings.arguments as List<CartBuyersModel>;
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
          'Tanggal Pengiriman',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontStyles.bold,
            fontFamily: FontStyles.lora,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 36, 20, 8),
        children: [
          // *Title
          const Text(
            'Silahkan pilih hari dan tanggal pengiriman terlebih dahulu',
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              color: Colours.black,
              fontSize: 16,
              fontWeight: FontStyles.regular,
              fontFamily: FontStyles.leagueSpartan,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(24),
                  side: BorderSide(
                    color: _selectedDateIndex == index
                        ? Colours.deepGreen
                        : Colours.gray,
                    width: 2,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedDateIndex = index;
                  });
                },
                child: Text(
                  DateFormat('EEEE, dd MMMM yyyy').format(_listOfDate[index]),
                  style: TextStyle(
                    color: _selectedDateIndex == index
                        ? Colours.deepGreen
                        : Colours.gray,
                    fontSize: 16,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              ),
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
                  'Rp. ${thousandFormat(totalPrice().round())}',
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
                padding: const EdgeInsets.symmetric(horizontal: 48),
                backgroundColor:
                    _selectedDateIndex < 0 ? Colours.gray : Colours.deepGreen,
              ),
              onPressed: () {
                if (_selectedDateIndex < 0) return;
                Navigator.of(context).pushNamed(
                  DistributionAddressScreen.route,
                  arguments: {
                    'products': _listCart,
                    'distribution_date': _listOfDate[_selectedDateIndex],
                  },
                );
              },
              child: const Text(
                'Selanjutnya',
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
