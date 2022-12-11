// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/configs/firebase/firebase.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/screens/buyers/dashboard/menu/home_buyers_screen.dart';
import 'package:melijo/screens/buyers/dashboard/menu/profile_buyers_screen.dart';
import 'package:melijo/screens/buyers/dashboard/menu/recipe_buyers_screen.dart';
import 'package:melijo/screens/buyers/dashboard/menu/transaction_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/cart_product_buyers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class DashboardBuyersScreen extends StatefulWidget {
  const DashboardBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/dashboard_buyers_screen';

  @override
  _DashboardBuyersScreenState createState() => _DashboardBuyersScreenState();
}

class _DashboardBuyersScreenState extends State<DashboardBuyersScreen> {
  int _navIndex = 0;
  FDatabase database = FDatabase();

  Widget generatePage() {
    if (_navIndex == 0) {
      return const HomeBuyersScreen();
    } else if (_navIndex == 1) {
      return const RecipeBuyersScreen();
    } else if (_navIndex == 3) {
      return const TransactionBuyersScreen();
    } else if (_navIndex == 4) {
      return const ProfileBuyersScreen();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    subscribeNotif();
    return Scaffold(
      body: generatePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        selectedItemColor: Colours.deepGreen,
        unselectedItemColor: Colours.gray,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        showUnselectedLabels: true,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'League Spartan', fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(
            fontFamily: 'League Spartan', fontWeight: FontWeight.w600),
        onTap: (index) {
          setState(() {
            _navIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined),
            activeIcon: Icon(Icons.newspaper),
            label: 'Resep',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(),
            activeIcon: SizedBox(),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => Navigator.of(context).pushNamed(CartProductBuyersScreen.route),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Spacer(),
              Icon(
                Icons.shopping_cart_outlined,
                size: 32,
                color: Colours.white,
              ),
              SizedBox(height: 2),
              Text(
                'Keranjang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colours.white,
                  fontSize: 14,
                  fontWeight: FontStyles.regular,
                  fontFamily: FontStyles.leagueSpartan,
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
