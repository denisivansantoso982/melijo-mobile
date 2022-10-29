// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/screens/buyers/dashboard/dashboard_buyers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/modal_bottom.dart';

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
  bool _isLoading = false;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    _userFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // ! Login Process
  Future<void> doLoginProcess(BuildContext context) async {
    try {
      if (validation()) {
        setState(() {
          _isLoading = true;
        });
        await login(_userController.text, _passwordController.text, false);
        Navigator.of(context).pushNamedAndRemoveUntil(DashboardBuyersScreen.route, (route) => false);
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
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
              title: 'Terjadi Kesalahan!',
              message: '$error',
              widgets: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colours.deepGreen, width: 1),
                    fixedSize: const Size.fromWidth(80),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Oke',
                    style: TextStyle(
                      color: Colours.deepGreen,
                      fontSize: 18,
                      fontWeight: FontStyles.regular,
                      fontFamily: FontStyles.leagueSpartan,
                    ),
                  ),
                )
              ],
            )),
      );
    }
  }

  // ! Validation
  bool validation() {
    if (_userController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Username atau Email tidak boleh kosong!'),
      ));
      _userFocus.requestFocus();
      return false;
    } else if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Kata Sandi tidak boleh kosong!'),
      ));
      _passwordFocus.requestFocus();
      return false;
    }
    return true;
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
              // *Email Field
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
                    hintText: 'Email',
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
                        keyboardType: TextInputType.name,
                        obscureText: !_isVisible,
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
                  onPressed: () {
                    if (!_isLoading) doLoginProcess(context);
                  },
                  child: !_isLoading
                      ? const Text(
                          'Masuk',
                          style: TextStyle(
                            fontFamily: FontStyles.lora,
                            fontSize: 20,
                            fontWeight: FontStyles.medium,
                            color: Colours.white,
                          ),
                        )
                      : const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colours.white, strokeWidth: 2),
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
