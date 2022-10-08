import 'package:flutter/material.dart';
import 'package:melijo/screens/starts/first_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String route = '/splash_screen';

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(FirstScreen.route);
    });

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
