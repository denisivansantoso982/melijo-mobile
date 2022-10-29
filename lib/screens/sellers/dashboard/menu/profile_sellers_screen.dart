// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/screens/starts/first_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class ProfileSellersScreen extends StatefulWidget {
  const ProfileSellersScreen({Key? key}) : super(key: key);

  @override
  _ProfileSellersScreenState createState() => _ProfileSellersScreenState();
}

class _ProfileSellersScreenState extends State<ProfileSellersScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Rudi Budiman Arif Yudistira Wawan');
  final TextEditingController _usernameController =
      TextEditingController(text: 'rdayw_1');
  final TextEditingController _emailController =
      TextEditingController(text: 'gataugue123@gmail.com');
  final TextEditingController _phoneController =
      TextEditingController(text: '12345678901234');
  final TextEditingController _addressController = TextEditingController(
      text: 'Jl. Mayjend Panjaitan no. 3 sebelah selatan');
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  bool _isEditable = false;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _nameFocus.dispose();
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  // ! Logout process
  Future<void> doLogoutProcess(BuildContext context) async {
    try {
      LoadingWidget.show(context);
      await logout();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(FirstScreen.route, (route) => false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.white,
        title: const Text(
          'Informasi Akun',
          style: TextStyle(
            color: Colours.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Lora',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isEditable = !_isEditable;
              });
            },
            color: _isEditable ? Colours.deepGreen : Colours.gray,
            icon:
                Icon(_isEditable ? Icons.check_outlined : Icons.edit_outlined),
          ),
        ],
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            12,
            32,
            12,
            12,
          ),
          children: [
            // *Avatar
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(64)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colours.black.withOpacity(.4),
                              offset: const Offset(2, 2),
                            ),
                          ]),
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(64)),
                        child: Image(
                          image: AssetImage('lib/assets/images/jambu.jpg'),
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isEditable,
                      child: Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          height: 48,
                          width: 48,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colours.deepGreen,
                            borderRadius: BorderRadius.all(Radius.circular(64)),
                          ),
                          child: const Icon(
                            Icons.photo_camera_sharp,
                            color: Colours.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // *Name Field
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 4,
                  child: Text(
                    'Nama',
                    style: TextStyle(
                      color: Colours.deepGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    readOnly: !_isEditable,
                    style: const TextStyle(
                      color: Colours.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'League Spartan',
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: _isEditable
                            ? const BorderSide(
                                width: 2,
                                color: Colours.black,
                              )
                            : BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: _isEditable
                            ? const BorderSide(
                                width: 2,
                                color: Colours.black,
                              )
                            : BorderSide.none,
                      ),
                      hintText: 'Nama Lengkap',
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // *Username Field
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 4,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      color: Colours.deepGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: _usernameController,
                    focusNode: _usernameFocus,
                    readOnly: !_isEditable,
                    style: const TextStyle(
                      color: Colours.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'League Spartan',
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: _isEditable
                            ? const BorderSide(
                                width: 2,
                                color: Colours.black,
                              )
                            : BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: _isEditable
                            ? const BorderSide(
                                width: 2,
                                color: Colours.black,
                              )
                            : BorderSide.none,
                      ),
                      hintText: 'Username',
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // *Phone Field
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 4,
                  child: Text(
                    'Nomor Telepon',
                    style: TextStyle(
                      color: Colours.deepGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    readOnly: !_isEditable,
                    style: const TextStyle(
                      color: Colours.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'League Spartan',
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: _isEditable
                            ? const BorderSide(
                                width: 2,
                                color: Colours.black,
                              )
                            : BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: _isEditable
                            ? const BorderSide(
                                width: 2,
                                color: Colours.black,
                              )
                            : BorderSide.none,
                      ),
                      hintText: 'Nomor Telepon',
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // *Email Field
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 4,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Colours.deepGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    readOnly: !_isEditable,
                    style: const TextStyle(
                      color: Colours.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'League Spartan',
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: _isEditable
                            ? const BorderSide(
                                width: 2,
                                color: Colours.black,
                              )
                            : BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: _isEditable
                            ? const BorderSide(
                                width: 2,
                                color: Colours.black,
                              )
                            : BorderSide.none,
                      ),
                      hintText: 'Alamat Email',
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // *Address Field
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 4,
                  child: Text(
                    'Alamat',
                    style: TextStyle(
                      color: Colours.deepGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: _addressController,
                    focusNode: _addressFocus,
                    readOnly: !_isEditable,
                    textInputAction: TextInputAction.newline,
                    maxLength: null,
                    maxLines: null,
                    style: const TextStyle(
                      color: Colours.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'League Spartan',
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: _isEditable
                            ? const BorderSide(
                                width: 2,
                                color: Colours.black,
                              )
                            : BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: _isEditable
                            ? const BorderSide(
                                width: 2,
                                color: Colours.black,
                              )
                            : BorderSide.none,
                      ),
                      hintText: 'Alamat',
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            // *Logout
            Visibility(
              visible: !_isEditable,
              child: Center(
                child: OutlinedButton(
                  onPressed: () => doLogoutProcess(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colours.deepGreen,
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    'Keluar Akun',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontStyles.regular,
                      fontFamily: FontStyles.leagueSpartan,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
