// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/screens/buyers/dashboard/dashboard_buyers_screen.dart';
import 'package:melijo/screens/sellers/dashboard/dashboard_sellers_screen.dart';
import 'package:melijo/screens/starts/first_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/modal_bottom.dart';

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
      final Map user_info = await getUserInfo();
      Navigator.of(context).pushReplacementNamed(DashboardBuyersScreen.route);
      if (user_info['seller_id'] == 0 || user_info['seller_id'] == 14) {
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   backgroundColor: Colours.red,
          //   content: Text('Untuk saat ini tidak ada Melijo di wilayah anda!'),
          // ));
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colours.white,
              ),
              child: ModalBottom(
                title: 'Pemberitahuan!',
                message: 'Untuk saat ini tidak ada Melijo di wilayah anda!',
                widgets: [
                  SizedBox(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colours.deepGreen, width: 1),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Oke, Saya Mengerti',
                        style: TextStyle(
                          color: Colours.deepGreen,
                          fontSize: 18,
                          fontWeight: FontStyles.regular,
                          fontFamily: FontStyles.leagueSpartan,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
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
