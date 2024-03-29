import 'package:flutter/material.dart';
import 'package:melijo/screens/buyers/register/register_buyers_screen.dart';
import 'package:melijo/screens/sellers/register/register_sellers_screen.dart';
import 'package:melijo/utils/colours.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String route = '/register_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // *Appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Colours.black,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 64,
            horizontal: 48,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // *Logo
              const Image(
                image: AssetImage('lib/assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),
              // *Title
              const Text(
                'Belanja sayur fresh gak pake ribet',
                style: TextStyle(
                  fontFamily: 'Lora',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colours.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // *Description
              const Text(
                'Melijo.id membantu anda menyiapkan semua bahan memasak dengan proses pemesanan anti ribet dan produk segar berkualitas',
                style: TextStyle(
                  fontFamily: 'League Spartan',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colours.gray,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // *Active Button
              _activeButton(context),
              const SizedBox(height: 16),
              // *Neutral Button
              _neutralButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _activeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          elevation: 8,
          shadowColor: Colours.deepGreen,
        ),
        onPressed: () => Navigator.of(context).pushNamed(RegisterBuyersScreen.route),
        child: const Text(
          'Daftar Sebagai Pembeli',
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colours.white,
          ),
        ),
      ),
    );
  }

  Widget _neutralButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 16)),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)))),
          elevation: MaterialStateProperty.all(8),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () => Navigator.of(context).pushNamed(RegisterSellersScreen.route),
        child: const Text(
          'Daftar Sebagai Penjual',
          style: TextStyle(
            fontFamily: 'League Spartan',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colours.gray,
          ),
        ),
      ),
    );
  }
}
