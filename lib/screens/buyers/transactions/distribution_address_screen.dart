// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/screens/buyers/transactions/payment_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class DistributionAddressScreen extends StatefulWidget {
  const DistributionAddressScreen({Key? key}) : super(key: key);

  static const String route = '/distribution_address_screen';

  @override
  _DistributionAddressScreenState createState() =>
      _DistributionAddressScreenState();
}

class _DistributionAddressScreenState extends State<DistributionAddressScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _signController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _districtFocus = FocusNode();
  final FocusNode _wardFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _signFocus = FocusNode();
  int id_province = 0, id_city = 0, id_district = 0, id_ward = 0;
  bool _isCommited = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _provinceController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _wardController.dispose();
    _addressController.dispose();
    _signController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _provinceFocus.dispose();
    _cityFocus.dispose();
    _districtFocus.dispose();
    _wardFocus.dispose();
    _addressFocus.dispose();
    _signFocus.dispose();
    super.dispose();
  }

  // ! Get Profile
  Future<void> retrieveProfile() async {
    try {
      await getProfileInfo();
      final Map user_data = await getUserInfo();
      final Map location = await getLocation();
      _nameController.text = user_data['name'];
      _phoneController.text = user_data['phone'];
      _provinceController.text = location['province'];
      _cityController.text = location['city'];
      _districtController.text = location['district'];
      _wardController.text = location['ward'];
      id_province = int.parse(user_data['province']);
      id_city = int.parse(user_data['city']);
      id_district = int.parse(user_data['district']);
      id_ward = int.parse(user_data['ward']);
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

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1, -1),
              end: Alignment(0.2, 0.8),
              colors: [
                Colours.oliveGreen,
                Colours.deepGreen,
              ],
            ),
          ),
        ),
        title: const Text(
          'Atur Alamat Pengiriman',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontStyles.bold,
            fontFamily: FontStyles.lora,
          ),
        ),
      ),
      body: FutureBuilder(
          future: retrieveProfile(),
          builder: (context, snapshot) {
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              children: [
                // * Name and Phone
                Visibility(
                  visible: !_isCommited,
                  child: Form(
                    child: Card(
                      color: Colours.deepGreen,
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20),
                        margin: const EdgeInsets.only(top: 8),
                        color: Colours.white,
                        child: Column(
                          children: [
                            // *Name Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Nama Penerima *',
                                  style: TextStyle(
                                    fontWeight: FontStyles.medium,
                                    fontFamily: FontStyles.leagueSpartan,
                                    color: Colours.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                    color: Colours.black,
                                    fontSize: 14,
                                    fontWeight: FontStyles.regular,
                                    fontFamily: FontStyles.leagueSpartan,
                                  ),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    isDense: true,
                                    hintText: 'Nama Penerima',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // *Whatsapp Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Nomor HP (Whatsapp) *',
                                  style: TextStyle(
                                    fontWeight: FontStyles.medium,
                                    fontFamily: FontStyles.leagueSpartan,
                                    color: Colours.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _phoneController,
                                  focusNode: _phoneFocus,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(
                                    color: Colours.black,
                                    fontSize: 14,
                                    fontWeight: FontStyles.regular,
                                    fontFamily: FontStyles.leagueSpartan,
                                  ),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    isDense: true,
                                    hintText: 'Nomor HP (Whatsapp)',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // * Province, City, District, Ward
                Visibility(
                  visible: !_isCommited,
                  child: Form(
                    child: Card(
                      color: Colours.deepGreen,
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20),
                        margin: const EdgeInsets.only(top: 8),
                        color: Colours.white,
                        child: Column(
                          children: [
                            // * Province
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Provinsi',
                                  style: TextStyle(
                                    fontWeight: FontStyles.medium,
                                    fontFamily: FontStyles.leagueSpartan,
                                    color: Colours.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _provinceController,
                                  focusNode: _provinceFocus,
                                  readOnly: true,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                    color: Colours.black,
                                    fontSize: 14,
                                    fontWeight: FontStyles.regular,
                                    fontFamily: FontStyles.leagueSpartan,
                                  ),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    isDense: true,
                                    hintText: 'Provinsi',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // * City
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Kota',
                                  style: TextStyle(
                                    fontWeight: FontStyles.medium,
                                    fontFamily: FontStyles.leagueSpartan,
                                    color: Colours.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _cityController,
                                  focusNode: _cityFocus,
                                  readOnly: true,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                    color: Colours.black,
                                    fontSize: 14,
                                    fontWeight: FontStyles.regular,
                                    fontFamily: FontStyles.leagueSpartan,
                                  ),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    isDense: true,
                                    hintText: 'Kota',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // * District
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Kecamatan',
                                  style: TextStyle(
                                    fontWeight: FontStyles.medium,
                                    fontFamily: FontStyles.leagueSpartan,
                                    color: Colours.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _districtController,
                                  focusNode: _districtFocus,
                                  readOnly: true,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                    color: Colours.black,
                                    fontSize: 14,
                                    fontWeight: FontStyles.regular,
                                    fontFamily: FontStyles.leagueSpartan,
                                  ),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    isDense: true,
                                    hintText: 'Kecamatan',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // * Ward
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Provinsi',
                                  style: TextStyle(
                                    fontWeight: FontStyles.medium,
                                    fontFamily: FontStyles.leagueSpartan,
                                    color: Colours.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _wardController,
                                  focusNode: _wardFocus,
                                  readOnly: true,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                    color: Colours.black,
                                    fontSize: 14,
                                    fontWeight: FontStyles.regular,
                                    fontFamily: FontStyles.leagueSpartan,
                                  ),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    isDense: true,
                                    hintText: 'Kelurahan',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // *Address and Sign
                Visibility(
                  visible: !_isCommited,
                  child: Form(
                    child: Card(
                      color: Colours.deepGreen,
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20),
                        margin: const EdgeInsets.only(top: 8),
                        color: Colours.white,
                        child: Column(
                          children: [
                            // *Address Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Alamat *',
                                  style: TextStyle(
                                    fontWeight: FontStyles.medium,
                                    fontFamily: FontStyles.leagueSpartan,
                                    color: Colours.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colours.gray,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                  ),
                                  child: TextFormField(
                                    controller: _addressController,
                                    focusNode: _addressFocus,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    maxLines: null,
                                    maxLength: null,
                                    style: const TextStyle(
                                      color: Colours.black,
                                      fontSize: 14,
                                      fontWeight: FontStyles.regular,
                                      fontFamily: FontStyles.leagueSpartan,
                                      height: 1.1,
                                    ),
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      hintText: 'Alamat',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // *Sign Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Detail (Patokan / Blok)',
                                  style: TextStyle(
                                    fontWeight: FontStyles.medium,
                                    fontFamily: FontStyles.leagueSpartan,
                                    color: Colours.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _signController,
                                  focusNode: _signFocus,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                    color: Colours.black,
                                    fontSize: 14,
                                    fontWeight: FontStyles.regular,
                                    fontFamily: FontStyles.leagueSpartan,
                                  ),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colours.gray,
                                      ),
                                    ),
                                    isDense: true,
                                    hintText: 'Blok atau patokan',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // *Result
                Visibility(
                  visible: _isCommited,
                  child: Form(
                    child: Card(
                      color: Colours.deepGreen,
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20),
                        margin: const EdgeInsets.only(top: 8),
                        color: Colours.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Alamat Pengiriman',
                                  style: TextStyle(
                                    fontWeight: FontStyles.medium,
                                    fontFamily: FontStyles.leagueSpartan,
                                    color: Colours.black,
                                    fontSize: 16,
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isCommited = false;
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      width: 1,
                                      color: Colours.deepGreen,
                                    ),
                                  ),
                                  child: const Text(
                                    'Ubah',
                                    style: TextStyle(
                                      color: Colours.deepGreen,
                                      fontSize: 16,
                                      fontWeight: FontStyles.medium,
                                      fontFamily: FontStyles.leagueSpartan,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colours.gray,
                                  width: 1,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                              ),
                              child: Text(
                                '${_nameController.text} - ${_phoneController.text} \n\nKelurahan ${_wardController.text}, Kecamatan ${_districtController.text}, ${_cityController.text}, ${_provinceController.text} \n\n${_addressController.text} \n\n${_signController.text}',
                                style: const TextStyle(
                                  color: Colours.gray,
                                  fontSize: 16,
                                  fontWeight: FontStyles.regular,
                                  fontFamily: FontStyles.leagueSpartan,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colours.lightGray,
              width: 2,
            ),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            if (!_isCommited) {
              setState(() {
                _isCommited = true;
              });
            } else {
              Navigator.of(context).pushNamed(PaymentScreen.route, arguments: {
                'products': arguments['products'],
                'distribution_date': arguments['distribution_date'],
                'distribution_info': '${_nameController.text} - ${_phoneController.text} \n\nKelurahan ${_wardController.text}, Kecamatan ${_districtController.text}, ${_cityController.text}, ${_provinceController.text} \n\n${_addressController.text} \n\n${_signController.text}',
              });
            }
          },
          child: Text(
            _isCommited ? 'Lanjut ke Pembayaran' : 'Simpan Detail Pengiriman',
            style: const TextStyle(
              fontWeight: FontStyles.medium,
              fontFamily: FontStyles.leagueSpartan,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
