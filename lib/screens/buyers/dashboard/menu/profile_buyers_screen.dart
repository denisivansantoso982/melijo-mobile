// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/screens/starts/first_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class ProfileBuyersScreen extends StatefulWidget {
  const ProfileBuyersScreen({Key? key}) : super(key: key);

  @override
  _ProfileBuyersScreenState createState() => _ProfileBuyersScreenState();
}

class _ProfileBuyersScreenState extends State<ProfileBuyersScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  String imageUrl = '';
  bool _isEditable = false;

  @override
  void initState() {
    retrieveProfile();
    super.initState();
  }

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
      Navigator.of(context)
          .pushNamedAndRemoveUntil(FirstScreen.route, (route) => false);
    }
  }

  // ! Get Profile
  Future<void> retrieveProfile() async {
    try {
      await getProfileInfo();
      final Map user_data = await getUserInfo();
      final Map location = await getLocation();
      setState(() {
        _nameController.text = user_data['name'];
        _usernameController.text = user_data['username'];
        _emailController.text = user_data['email'];
        _phoneController.text = user_data['phone'];
        _addressController.text =
            'Kelurahan ${location['ward']}, Kecamatan ${location['district']}, ${location['city']}, ${location['province']}';
        imageUrl = user_data['avatar'];
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
          ),
        ),
      );
    }
  }

  // ! Pick Image
  Future<void> pickImage(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colours.deepGreen,
          duration: Duration(seconds: 2),
          content: Text('Mengunggah gambar!'),
        ));
        await uploadAvatar(image);
        await retrieveProfile();
      }
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
          ),
        ),
      );
    }
  }

  // ! Edit User Profile
  Future<void> editUserProfile(BuildContext context) async {
    try {
      if (validation()) {
        LoadingWidget.show(context);
        await editProfile(
          _nameController.text,
          _usernameController.text,
          _phoneController.text,
          _emailController.text,
        );
        final Map user_data = await getUserInfo();
        setState(() {
          _nameController.text = user_data['name'];
          _usernameController.text = user_data['username'];
          _emailController.text = user_data['email'];
          _phoneController.text = user_data['phone'];
          imageUrl = user_data['avatar'];
        });
        LoadingWidget.close(context);
      }
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
          ),
        ),
      );
    }
  }

  // ! Validation
  bool validation() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Nama harus diisi!'),
      ));
      _nameFocus.requestFocus();
      return false;
    } else if (_usernameController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Username minimal memiliki 6 Karakter!'),
      ));
      _usernameFocus.requestFocus();
      return false;
    } else if (_phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Nomor Telepon minimal memiliki 10 Karakter!'),
      ));
      _phoneFocus.requestFocus();
      return false;
    } else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Email tidak sesuai!'),
      ));
      _emailFocus.requestFocus();
      return false;
    }
    return true;
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
            onPressed: () async {
              if (_isEditable) {
                await editUserProfile(context);
              }
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
      body: RefreshIndicator(
        onRefresh: () => retrieveProfile(),
        child: Form(
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
                      child: imageUrl != ''
                          ? ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(64)),
                              child: Image(
                                image: NetworkImage(
                                    '${ApiRequest.baseStorageUrl}/$imageUrl'),
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            )
                          : const ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(64)),
                              child: Image(
                                image:
                                    AssetImage('lib/assets/images/profile.jpg'),
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
                        child: GestureDetector(
                          onTap: () => pickImage(context),
                          child: Container(
                            height: 48,
                            width: 48,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colours.deepGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(64)),
                            ),
                            child: const Icon(
                              Icons.photo_camera_sharp,
                              color: Colours.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
              Visibility(
                visible: !_isEditable,
                child: Row(
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
              ),
              const SizedBox(height: 48),
              // *Logout or Cancel
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    if (_isEditable) {
                      setState(() {
                        _isEditable = !_isEditable;
                      });
                    } else {
                      doLogoutProcess(context);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colours.deepGreen,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _isEditable ? 'Batal' : 'Keluar Akun',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontStyles.regular,
                      fontFamily: FontStyles.leagueSpartan,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
