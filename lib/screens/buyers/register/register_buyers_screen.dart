// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/screens/buyers/login/login_buyers_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class RegisterBuyersScreen extends StatefulWidget {
  const RegisterBuyersScreen({Key? key}) : super(key: key);

  static const String route = '/register_buyers_screen.dart';

  @override
  State<RegisterBuyersScreen> createState() => _RegisterBuyersScreenState();
}

class _RegisterBuyersScreenState extends State<RegisterBuyersScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPassController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _repeatPassFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _districtFocus = FocusNode();
  final FocusNode _villageFocus = FocusNode();
  final PageController _pageController = PageController(initialPage: 0);
  int id_province = 0;
  int id_city = 0;
  int id_district = 0;
  int id_village = 0;
  List<dynamic> provinces = [];
  List<dynamic> cities = [];
  List<dynamic> districts = [];
  List<dynamic> villages = [];
  bool _visiblePass = false;
  bool _visibleRepeatPass = false;

  @override
  void initState() {
    initProvinces();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _repeatPassController.dispose();
    _emailFocus.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _repeatPassFocus.dispose();
    _pageController.dispose();
    _provinceFocus.dispose();
    _cityFocus.dispose();
    _districtFocus.dispose();
    _villageFocus.dispose();
    super.dispose();
  }

  Future<void> initProvinces() async {
    try {
      List<dynamic> response = await retrieveProvinces();
      setState(() {
        provinces = response;
      });
    } catch (error) {
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

  Future<void> initCities() async {
    try {
      List<dynamic> response = await retrieveCities(id_province);
      setState(() {
        cities = response;
      });
    } catch (error) {
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

  Future<void> initDistricts() async {
    try {
      List<dynamic> response = await retrieveDistricts(id_city);
      setState(() {
        districts = response;
      });
    } catch (error) {
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

  Future<void> initVillages() async {
    try {
      List<dynamic> response = await retrieveVillages(id_district);
      setState(() {
        villages = response;
      });
    } catch (error) {
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

  void firstPageAction(BuildContext context) {
    // if (_usernameController.text.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     backgroundColor: Colours.red,
    //     content: Text('Username tidak boleh kosong!'),
    //   ));
    //   _usernameFocus.requestFocus();
    // } else
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Email tidak boleh kosong!'),
      ));
      _emailFocus.requestFocus();
    } else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Email tidak sesuai!'),
      ));
      _emailFocus.requestFocus();
    } else {
      _emailFocus.unfocus();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  void secondPageAction(BuildContext context) {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Nama tidak boleh kosong!'),
      ));
      _nameFocus.requestFocus();
    } else if (_phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Nomor Telepon minimal 10 karakter!'),
      ));
      _phoneFocus.requestFocus();
    } else {
      _nameFocus.unfocus();
      _phoneFocus.unfocus();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  void thirdPageAction(BuildContext context) {
    if (id_province == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Harap pilih Provinsi anda tinggal!'),
      ));
      _provinceFocus.requestFocus();
    } else if (id_city == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Harap pilih Kabupaten/Kota anda tinggal!'),
      ));
      _cityFocus.requestFocus();
    } else if (id_district == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Harap pilih Kecamatan anda tinggal!'),
      ));
      _districtFocus.requestFocus();
    } else if (id_village == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Harap pilih Kelurahan anda tinggal!'),
      ));
      _villageFocus.requestFocus();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  void fourthPageAction(BuildContext context) {
    if (_passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Password minimal 8 karakter!'),
      ));
      _passwordFocus.requestFocus();
    } else if (_repeatPassController.text != _passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Konfirmasi Password tidak sesuai!'),
      ));
      _repeatPassFocus.requestFocus();
    } else {
      doProcessRegistration(context);
    }
  }

  Future doProcessRegistration(BuildContext context) async {
    try {
      LoadingWidget.show(context);
      await register(
        _nameController.text,
        _emailController.text,
        _phoneController.text,
        _passwordController.text,
        3,
        id_province,
        id_city,
        id_district,
        id_village,
      );
      LoadingWidget.close(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registrasi berhasil!'),
        backgroundColor: Colours.deepGreen,
        duration: Duration(seconds: 2),
      ));
      Navigator.of(context).pushNamed(LoginBuyersScreen.route);
    } catch (error) {
      LoadingWidget.close(context);
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
        body: ListView(
          padding: const EdgeInsets.only(top: 64),
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
              height: 550,
              child: PageView(
                controller: _pageController,
                physics:
                    const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
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
    );
  }

  Widget firstPage(BuildContext context, double screenWidth) {
    return Column(
      children: [
        const SizedBox(height: 56),
        Center(
          child: Stack(
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
        ),
        // *Username Field
        // Container(
        //   decoration: const BoxDecoration(
        //     color: Colours.lightGray,
        //     borderRadius: BorderRadius.all(Radius.circular(12)),
        //   ),
        //   child: TextFormField(
        //     controller: _usernameController,
        //     focusNode: _usernameFocus,
        //     keyboardType: TextInputType.name,
        //     style: const TextStyle(
        //       color: Colours.black,
        //       fontSize: 18,
        //       fontFamily: 'League Spartan',
        //       fontWeight: FontWeight.w400,
        //     ),
        //     inputFormatters: [
        //       FilteringTextInputFormatter.deny(RegExp(r'\s')),
        //       LengthLimitingTextInputFormatter(50),
        //     ],
        //     decoration: const InputDecoration(
        //       border: OutlineInputBorder(
        //         borderSide: BorderSide.none,
        //       ),
        //       hintText: 'Username',
        //       contentPadding: EdgeInsets.symmetric(
        //         vertical: 20,
        //         horizontal: 16,
        //       ),
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 32),
        // *Email Field
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
              LengthLimitingTextInputFormatter(50),
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
            onPressed: () => firstPageAction(context),
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
        Center(
          child: Stack(
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
              FilteringTextInputFormatter.deny(RegExp(r'\s a-z A-Z 0-9')),
              LengthLimitingTextInputFormatter(80),
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
              FilteringTextInputFormatter.deny(RegExp(r'0-9')),
              LengthLimitingTextInputFormatter(20),
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
            onPressed: () => secondPageAction(context),
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
    return ListView(
      controller: ScrollController(),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 56),
        Center(
          child: Stack(
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
        ),
        // * Province Field
        Container(
          decoration: const BoxDecoration(
            color: Colours.lightGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: DropdownButtonFormField(
            focusNode: _provinceFocus,
            isExpanded: true,
            style: const TextStyle(
              color: Colours.black,
              fontSize: 18,
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: const InputDecoration(
              fillColor: Colours.lightGray,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              contentPadding: EdgeInsets.all(16),
              hintText: 'Provinsi',
            ),
            value: provinces.isNotEmpty
                ? (id_province != 0
                    ? provinces.firstWhere(
                        (element) => element['id'] == id_province)['id']
                    : provinces[0]['id'])
                : 0,
            items: provinces
                .map<DropdownMenuItem>((element) => DropdownMenuItem(
                      value: element['id'],
                      child: Text(
                        element['nama'],
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              cities.clear();
              districts.clear();
              villages.clear();
              setState(() {
                id_province = value;
                id_city = 0;
                id_district = 0;
                id_village = 0;
              });
              initCities();
            },
          ),
        ),
        const SizedBox(height: 16),
        // * City or Regency
        Container(
          decoration: const BoxDecoration(
            color: Colours.lightGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: DropdownButtonFormField(
            focusNode: _cityFocus,
            isExpanded: true,
            style: const TextStyle(
              color: Colours.black,
              fontSize: 18,
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: const InputDecoration(
              fillColor: Colours.lightGray,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              contentPadding: EdgeInsets.all(16),
              hintText: 'Kota atau Kabupaten',
            ),
            value: cities.isNotEmpty
                ? (id_city != 0
                    ? cities
                        .firstWhere((element) => element['id'] == id_city)['id']
                    : cities[0]['id'])
                : 0,
            items: cities
                .map<DropdownMenuItem>((element) => DropdownMenuItem(
                      value: element['id'],
                      child: SizedBox(
                        width: screenWidth * .75,
                        child: Text(
                          element['nama'],
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              districts.clear();
              villages.clear();
              setState(() {
                id_city = value;
                id_district = 0;
                id_village = 0;
              });
              initDistricts();
            },
          ),
        ),
        const SizedBox(height: 16),
        // * District Field
        Container(
          decoration: const BoxDecoration(
            color: Colours.lightGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: DropdownButtonFormField(
            focusNode: _districtFocus,
            isExpanded: true,
            style: const TextStyle(
              color: Colours.black,
              fontSize: 18,
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: const InputDecoration(
              fillColor: Colours.lightGray,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              contentPadding: EdgeInsets.all(16),
              hintText: 'Kecamatan',
            ),
            value: districts.isNotEmpty
                ? (id_district != 0
                    ? districts.firstWhere(
                        (element) => element['id'] == id_district)['id']
                    : districts[0]['id'])
                : 0,
            items: districts
                .map<DropdownMenuItem>((element) => DropdownMenuItem(
                      value: element['id'],
                      child: Text(element['nama']),
                    ))
                .toList(),
            onChanged: (value) {
              villages.clear();
              setState(() {
                id_district = value;
                id_village = 0;
              });
              initVillages();
            },
          ),
        ),
        const SizedBox(height: 16),
        // * Village Field
        Container(
          decoration: const BoxDecoration(
            color: Colours.lightGray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: DropdownButtonFormField(
            focusNode: _villageFocus,
            isExpanded: true,
            style: const TextStyle(
              color: Colours.black,
              fontSize: 18,
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: const InputDecoration(
              fillColor: Colours.lightGray,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              contentPadding: EdgeInsets.all(16),
              hintText: 'Kelurahan',
            ),
            value: villages.isNotEmpty
                ? (id_village != 0
                    ? villages.firstWhere(
                        (element) => element['id'] == id_village)['id']
                    : villages[0]['id'])
                : 0,
            items: villages
                .map<DropdownMenuItem>((element) => DropdownMenuItem(
                      value: element['id'],
                      child: Text(element['nama']),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                id_village = value;
              });
            },
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
            onPressed: () => thirdPageAction(context),
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
        Center(
          child: Stack(
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
                  obscureText: !_visiblePass,
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
                  obscureText: !_visibleRepeatPass,
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
            onPressed: () => fourthPageAction(context),
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
