// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';

class AddProductSellerScreen extends StatefulWidget {
  const AddProductSellerScreen({Key? key}) : super(key: key);

  static const String route = '/add_product_sellers_screen';

  @override
  _AddProductSellerScreenState createState() => _AddProductSellerScreenState();
}

class _AddProductSellerScreenState extends State<AddProductSellerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController(text: 'Sayur');
  final TextEditingController _priceController = TextEditingController(text: '0');
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _categoryFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final List<dynamic> _listOfPicture = [];
  final List<Map<String, String>> _listOfCategory = [
    {
      'value': 'Sayur',
      'image': 'vegetables.png'
    },
    {
      'value': 'Daging',
      'image': 'meats.png'
    },
    {
      'value': 'Unggas',
      'image': 'poultries.png'
    },
    {
      'value': 'Seafood',
      'image': 'seafoods.png'
    },
    {
      'value': 'Protein',
      'image': 'eggs.png'
    },
    {
      'value': 'Bumbu',
      'image': 'spices.png'
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _nameFocus.dispose();
    _categoryFocus.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.deepGreen,
        title: const Text(
          'Tambah Produk',
          style: TextStyle(
            color: Colours.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Lora',
          ),
        ),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            // *Product Pictures Field
            Row(
              children: const [
                Text(
                  'Foto Produk',
                  style: TextStyle(
                    color: Colours.black,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: _listOfPicture.isEmpty ? 64 : screenSize.width / 4,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: _listOfPicture.isEmpty ? 2 / 1 : 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: _listOfPicture.isEmpty
                    ? 1
                    : (_listOfPicture.length < 6
                        ? _listOfPicture.length + 1
                        : _listOfPicture.length),
                itemBuilder: (context, index) {
                  if (_listOfPicture.isEmpty) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(4),
                            side: const BorderSide(
                              color: Colours.deepGreen,
                              width: 1,
                            )),
                        child: const Text(
                          'Tambah Foto',
                          style: TextStyle(
                            color: Colours.deepGreen,
                            fontFamily: FontStyles.leagueSpartan,
                            fontSize: 16,
                            fontWeight: FontStyles.regular,
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            const SizedBox(height: 8),
            // *Product Name Field
            Row(
              children: const [
                Text(
                  'Tuliskan nama produk yang akan anda jual',
                  style: TextStyle(
                    color: Colours.black,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              focusNode: _nameFocus,
              style: const TextStyle(
                color: Colours.black,
                fontSize: 16,
                fontWeight: FontStyles.regular,
                fontFamily: FontStyles.leagueSpartan,
              ),
              decoration: InputDecoration(
                enabledBorder: outlineInputBorder(Colours.gray),
                focusedBorder: outlineInputBorder(Colours.deepGreen),
                hintText: 'Nama Produk',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                isDense: true,
              ),
            ),
            const SizedBox(height: 8),
            // *Product Category Field
            Row(
              children: const [
                Text(
                  'Pilih kategori dari produk anda',
                  style: TextStyle(
                    color: Colours.black,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              value: _categoryController.text,
              focusNode: _categoryFocus,
              decoration: InputDecoration(
                enabledBorder: outlineInputBorder(Colours.gray),
                focusedBorder: outlineInputBorder(Colours.deepGreen),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12,),
              ),
              isExpanded: true,
              items: _listOfCategory.map<DropdownMenuItem<String>>(
                (item) => DropdownMenuItem<String>(
                  value: item['value'],
                  child: SizedBox(
                    height: 32,
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //     bottom: item == _listOfCategory.last ? BorderSide.none : const BorderSide(color: Colours.deepGreen, width: 2,),
                    //   ),
                    // ),
                    child: Row(
                      children: [
                        Image(image: AssetImage('lib/assets/images/category/${item['image']}'), fit: BoxFit.cover, height: 30, width: 30,),
                        const SizedBox(width: 8),
                        Text(
                          item['value']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontStyles.regular,
                            color: Colours.deepGreen,
                            fontFamily: FontStyles.leagueSpartan,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).toList(),
              onChanged: (value) {
                setState(() {
                  _categoryController.text = value!;
                });
              },
            ),
            const SizedBox(height: 8),
            // *Product Price Field
            Row(
              children: const [
                Text(
                  'Harga',
                  style: TextStyle(
                    color: Colours.black,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _priceController,
              focusNode: _priceFocus,
              style: const TextStyle(
                color: Colours.black,
                fontSize: 16,
                fontWeight: FontStyles.regular,
                fontFamily: FontStyles.leagueSpartan,
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefix: const Text(
                  'Rp  ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
                enabledBorder: underlineInputBorder(Colours.gray),
                focusedBorder: underlineInputBorder(Colours.deepGreen),
                hintText: 'Harga',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                isDense: true,
              ),
            ),
            const SizedBox(height: 8),
            // *Product Description Field
            Row(
              children: const [
                Text(
                  'Deskripsi Produk',
                  style: TextStyle(
                    color: Colours.black,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              focusNode: _descriptionFocus,
              keyboardType: TextInputType.multiline,
              maxLength: null,
              maxLines: null,
              textInputAction: TextInputAction.newline,
              style: const TextStyle(
                color: Colours.black,
                fontSize: 16,
                fontWeight: FontStyles.regular,
                fontFamily: FontStyles.leagueSpartan,
              ),
              decoration: InputDecoration(
                enabledBorder: underlineInputBorder(Colours.gray),
                focusedBorder: underlineInputBorder(Colours.deepGreen),
                hintText: 'Deskripsi Produk',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                isDense: true,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      // *Button
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
          onPressed: () {},
          child: const Text(
            'Tambahkan Produk',
            style: TextStyle(
                fontWeight: FontStyles.medium,
                fontFamily: FontStyles.leagueSpartan,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  InputBorder outlineInputBorder(Color color) => OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
      );

  InputBorder underlineInputBorder(Color color) => UnderlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
      );
}
