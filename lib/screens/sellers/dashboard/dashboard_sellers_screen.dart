// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/screens/sellers/dashboard/menu/menu_sellers_screen.dart';
import 'package:melijo/screens/sellers/dashboard/menu/product_sellers_screen.dart';
import 'package:melijo/screens/sellers/dashboard/menu/profile_sellers_screen.dart';
import 'package:melijo/screens/sellers/dashboard/menu/transaction_sellers_screen.dart';
import 'package:melijo/utils/colours.dart';

class DashboardSellersScreen extends StatefulWidget {
  const DashboardSellersScreen({Key? key}) : super(key: key);

  static const String route = '/dashboard_sellers_screen';

  @override
  _DashboardSellersScreenState createState() => _DashboardSellersScreenState();
}

class _DashboardSellersScreenState extends State<DashboardSellersScreen> {
  int _navIndex = 0;

  Widget generatePage() {
    if (_navIndex == 0) {
      return const MenuSellersScreen();
    } else if (_navIndex == 1) {
      return const ProductSellersScreen();
    } else if (_navIndex == 2) {
      return const TransactionSellersScreen();
    }
    return const ProfileSellersScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: generatePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        selectedItemColor: Colours.deepGreen,
        unselectedItemColor: Colours.gray,
        iconSize: 30,
        showUnselectedLabels: true,
        selectedFontSize: 16,
        unselectedFontSize: 16,
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
            icon: Icon(Icons.backpack_outlined),
            activeIcon: Icon(Icons.backpack),
            label: 'Produk',
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
    );
  }
}
