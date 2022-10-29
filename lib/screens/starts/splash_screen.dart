// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/screens/buyers/dashboard/dashboard_buyers_screen.dart';
import 'package:melijo/screens/sellers/dashboard/dashboard_sellers_screen.dart';
import 'package:melijo/screens/starts/first_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String route = '/splash_screen';

  // ! check user auth
  Future<void> initUser(BuildContext context) async {
    final int? role = await checkUserRole();
    await Future.delayed(const Duration(milliseconds: 1500));
    if (role == null) {
      Navigator.of(context).pushReplacementNamed(FirstScreen.route);
    } else if (role == 3) {
      Navigator.of(context).pushReplacementNamed(DashboardBuyersScreen.route);
    } else {
      Navigator.of(context).pushReplacementNamed(DashboardSellersScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    initUser(context);
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Image(
            image: AssetImage('lib/assets/images/logo.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
