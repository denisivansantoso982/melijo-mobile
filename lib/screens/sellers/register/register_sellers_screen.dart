// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melijo/screens/sellers/login/login_sellers_screen.dart';
import 'package:melijo/utils/colours.dart';

class RegisterSellersScreen extends StatefulWidget {
  const RegisterSellersScreen({Key? key}) : super(key: key);

  static const String route = '/register_sellers_screen.dart';

  @override
  State<RegisterSellersScreen> createState() => _RegisterSellersScreenState();
}

class _RegisterSellersScreenState extends State<RegisterSellersScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPassController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _repeatPassFocus = FocusNode();
  final PageController _pageController = PageController(initialPage: 0);
  bool _visiblePass = false;
  bool _visibleRepeatPass = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _repeatPassController.dispose();
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
    _passwordFocus.dispose();
    _repeatPassFocus.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (_pageController.page != 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        // *Appbar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              if (_pageController.page != 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
                return;
              }
              Navigator.of(context).pop();
            },
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
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: Column(
            children: [
              // *Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Daftar Sebagai Penjual',
                  style: TextStyle(
                    fontFamily: 'Lora',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colours.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 450,
                child: PageView(
                  controller: _pageController,
                  physics: const ScrollPhysics(
                      parent: NeverScrollableScrollPhysics()),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: firstPage(context, screenWidth),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: secondPage(context, screenWidth),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: thirdPage(context, screenWidth),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: fourthPage(context, screenWidth),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstPage(BuildContext context, double screenWidth) {
    return Column(
      children: [
        const SizedBox(height: 56),
        Stack(
          children: [
            const SizedBox(height: 56),
            Container(
              width: screenWidth * 0.65,
              height: 6,
              decoration: const BoxDecoration(
                color: Colours.lightGray,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            Container(
              width: (screenWidth * 0.65) * 1 / 5,
              height: 6,
              decoration: const BoxDecoration(
                color: Colours.deepGreen,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ],
        ),
        // *Email or Username Field
        Container(
          decoration: const BoxDecoration(
            color: Colours.lightGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: TextFormField(
            controller: _usernameController,
            focusNode: _usernameFocus,
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
              hintText: 'Username',
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        // *Email or Username Field
        Container(
          decoration: const BoxDecoration(
            color: Colours.lightGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: TextFormField(
            controller: _emailController,
            focusNode: _emailFocus,
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
        const SizedBox(height: 48),
        // *Next Button
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
              _pageController.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            },
            child: const Text(
              'Selanjutya',
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
    );
  }

  Widget secondPage(BuildContext context, double screenWidth) {
    return Column(
      children: [
        const SizedBox(height: 56),
        Stack(
          children: [
            const SizedBox(height: 56),
            Container(
              width: screenWidth * 0.65,
              height: 6,
              decoration: const BoxDecoration(
                color: Colours.lightGray,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            Container(
              width: (screenWidth * 0.65) * 2 / 5,
              height: 6,
              decoration: const BoxDecoration(
                color: Colours.deepGreen,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ],
        ),
        // *Name Field
        Container(
          decoration: const BoxDecoration(
            color: Colours.lightGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: TextFormField(
            controller: _nameController,
            focusNode: _nameFocus,
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Colours.black,
              fontSize: 18,
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w400,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'\s a-z A-Z 0-9')),
            ],
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: 'Nama Lengkap',
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        // *Phone Field
        Container(
          decoration: const BoxDecoration(
            color: Colours.lightGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: TextFormField(
            controller: _phoneController,
            focusNode: _phoneFocus,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              color: Colours.black,
              fontSize: 18,
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w400,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'0-9')),
            ],
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: 'Nomor Handphone',
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),
        // *Next Button
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
              _pageController.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            },
            child: const Text(
              'Selanjutya',
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
    );
  }

  Widget thirdPage(BuildContext context, double screenWidth) {
    return Column(
      children: [
        const SizedBox(height: 56),
        Stack(
          children: [
            const SizedBox(height: 56),
            Container(
              width: screenWidth * 0.65,
              height: 6,
              decoration: const BoxDecoration(
                color: Colours.lightGray,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            Container(
              width: (screenWidth * 0.65) * 3 / 5,
              height: 6,
              decoration: const BoxDecoration(
                color: Colours.deepGreen,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ],
        ),
        // *Address Field
        Container(
          height: 142,
          decoration: const BoxDecoration(
            color: Colours.lightGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: TextFormField(
            controller: _addressController,
            focusNode: _addressFocus,
            keyboardType: TextInputType.multiline,
            maxLength: null,
            maxLines: null,
            textInputAction: TextInputAction.newline,
            style: const TextStyle(
              color: Colours.black,
              fontSize: 18,
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w400,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: 'Alamat',
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),
        // *Next Button
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
              _pageController.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            },
            child: const Text(
              'Selanjutya',
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
    );
  }

  Widget fourthPage(BuildContext context, double screenWidth) {
    return Column(
      children: [
        const SizedBox(height: 56),
        Stack(
          children: [
            const SizedBox(height: 56),
            Container(
              width: screenWidth * 0.65,
              height: 6,
              decoration: const BoxDecoration(
                color: Colours.lightGray,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            Container(
              width: (screenWidth * 0.65) * 4 / 5,
              height: 6,
              decoration: const BoxDecoration(
                color: Colours.deepGreen,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ],
        ),
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
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _visiblePass,
                  style: const TextStyle(
                    color: Colours.black,
                    fontSize: 18,
                    fontFamily: 'League Spartan',
                    fontWeight: FontWeight.w400,
                  ),
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
                    _visiblePass = !_visiblePass;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    _visiblePass ? Icons.visibility : Icons.visibility_off,
                    color: Colours.gray,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // *Repeat Password Field
        Container(
          decoration: const BoxDecoration(
            color: Colours.lightGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _repeatPassController,
                  focusNode: _repeatPassFocus,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _visibleRepeatPass,
                  style: const TextStyle(
                    color: Colours.black,
                    fontSize: 18,
                    fontFamily: 'League Spartan',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Konfirmasi Kata Sandi',
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
                    _visibleRepeatPass = !_visibleRepeatPass;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    _visibleRepeatPass
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colours.gray,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),
        // *Next Button
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
              Navigator.of(context)
                  .restorablePushNamed(LoginSellersScreen.route);
            },
            child: const Text(
              'Daftar Sekarang',
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
    );
  }
}
