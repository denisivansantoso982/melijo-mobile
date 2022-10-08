// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melijo/utils/colours.dart';

class LoginBuyersScreen extends StatefulWidget {
  const LoginBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/login_buyers_screen';

  @override
  State<LoginBuyersScreen> createState() => _LoginBuyersScreenState();
}

class _LoginBuyersScreenState extends State<LoginBuyersScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _userFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _isVisible = false;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    _userFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // *Appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Colours.black,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Image(
          image: AssetImage('lib/assets/images/logo.png'),
          fit: BoxFit.cover,
          height: 42,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 64,
          horizontal: 40,
        ),
        child: Form(
          child: Column(
            children: [
              // *Title
              const Text(
                'Selangkah lagi menjadi Pembeli',
                style: TextStyle(
                  fontFamily: 'Lora',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colours.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 56),
              // *Email or Username Field
              Container(
                decoration: const BoxDecoration(
                  color: Colours.lightGray,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextFormField(
                  controller: _userController,
                  focusNode: _userFocus,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colours.black,
                    fontSize: 18,
                    fontFamily: 'League Spartan',
                    fontWeight: FontWeight.w400,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Email atau Username',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // *Password Field
              Container(
                decoration: const BoxDecoration(
                  color: Colours.lightGray,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: _isVisible,
                        style: const TextStyle(
                          color: Colours.black,
                          fontSize: 18,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\\s')),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Kata Sandi',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          _isVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colours.gray,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // *Forgot Password
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Lupa Kata Sandi?',
                  style: TextStyle(
                    fontFamily: 'League Spartan',
                    fontSize: 18,
                    color: Colours.gray,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // *Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    elevation: 8,
                    shadowColor: Colours.deepGreen,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colours.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
