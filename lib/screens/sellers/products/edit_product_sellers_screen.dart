// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/sellers/product_seller_model.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class EditProductSellerScreen extends StatefulWidget {
  const EditProductSellerScreen({Key? key}) : super(key: key);

  static const String route = '/edit_product_sellers_screen';

  @override
  _EditProductSellerScreenState createState() =>
      _EditProductSellerScreenState();
}

class _EditProductSellerScreenState extends State<EditProductSellerScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  late int id;
  final TextEditingController _nameController = TextEditingController();
  int _categoryValue = 1;
  int _unitValue = 1;
  final TextEditingController _priceController =
      TextEditingController(text: '0');
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _categoryFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _unitFocus = FocusNode();
  final List<dynamic> _listOfPicture = [];
  final List _listOfCategory = [];
  final List _listOfUnit = [];

  @override
  void initState() {
    retrieveCategoryAndUnit();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _nameFocus.dispose();
    _categoryFocus.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _unitFocus.dispose();
    super.dispose();
  }

  // ! init detail product
  void initial(ProductSellerModel argue) {
    id = argue.id;
    _nameController.text = argue.product_name;
    _categoryValue = argue.category_id;
    _unitValue = argue.unit_id;
    _priceController.text = argue.price.toString();
    _descriptionController.text = argue.description;
  }

  // ! Generate picture
  Widget generatePictures(BuildContext context, int index) {
    if (_listOfPicture.length < 3) {
      if (index <= _listOfPicture.length - 1) {
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Colours.deepGreen,
          ),
          child: Image(
            image: NetworkImage(
                '${ApiRequest.baseStorageUrl}/${_listOfPicture[index]}'),
            fit: BoxFit.cover,
          ),
        );
      }
      return const SizedBox();
      // return GestureDetector(
      //   onTap: () {},
      //   child: Center(
      //     child: Container(
      //       decoration: const BoxDecoration(
      //         color: Colours.deepGreen,
      //         borderRadius: BorderRadius.all(Radius.circular(64)),
      //       ),
      //       child: const Icon(
      //         Icons.add,
      //         color: Colours.white,
      //         size: 28,
      //       ),
      //     ),
      //   ),
      // );
    }
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colours.deepGreen,
      ),
      child: Image(
        image: NetworkImage(
            '${ApiRequest.baseStorageUrl}/${_listOfPicture[index]}'),
        fit: BoxFit.cover,
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

  // ! Retrieve Category & Unit
  Future<void> retrieveCategoryAndUnit() async {
    try {
      final List categories = await getCategoryProduct();
      final List units = await getUnit();
      setState(() {
        _listOfCategory.addAll(categories);
        _listOfUnit.addAll(units);
      });
    } catch (error) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: _globalKey.currentContext!,
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

  // ! Get Product Images
  Future<List> getImage(context) async {
    try {
      final Map productDetail = await getDetailProductSeller(context, id);
      final List productImages = productDetail['images'];
      for (Map image in productImages) {
        _listOfPicture.clear();
        _listOfPicture.add(image['image']);
      }
      return Future.error(productImages);
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
      return [];
    }
  }

  // ! Edit Process
  Future<void> editProcess(BuildContext context) async {
    try {
      if (validation()) {
        LoadingWidget.show(context);
        await editProduct(ProductSellerModel(
          id: id,
          price: int.parse(_priceController.text),
          category_id: _categoryValue,
          unit_id: _unitValue,
          product_name: _nameController.text,
          image_uri: '',
          description: _descriptionController.text,
        ));
        await getProductsSeller(context);
        LoadingWidget.close(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colours.deepGreen,
          duration: Duration(seconds: 2),
          content: Text('Produk berhasil diubah!'),
        ));
        Navigator.of(context).pop();
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
        content: Text('Nama produk minimal 6 karakter!'),
      ));
      _nameFocus.requestFocus();
      return false;
    } else if (_categoryValue < 1 || _categoryValue > 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Pilih category!'),
      ));
      _categoryFocus.requestFocus();
      return false;
    } else if (_priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Harga harus diisi!'),
      ));
      _priceFocus.requestFocus();
      return false;
    } else if (int.parse(_priceController.text) < 100) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Harga minimal Rp.100 !'),
      ));
      _priceFocus.requestFocus();
      return false;
    } else if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colours.red,
        content: Text('Deskripsi tidak boleh kosong!'),
      ));
      _descriptionFocus.requestFocus();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final ProductSellerModel argue =
        ModalRoute.of(context)!.settings.arguments as ProductSellerModel;
    initial(argue);
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colours.deepGreen,
        title: const Text(
          'Ubah Produk',
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
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              child: FutureBuilder(
                  future: getImage(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 80,
                        child: Text(
                          'Memuat Foto Produk...',
                          style: TextStyle(
                            color: Colours.gray,
                            fontSize: 16,
                            fontWeight: FontStyles.medium,
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: _listOfPicture.isEmpty ? 2 / 1 : 1,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: _listOfPicture.isEmpty
                          ? 1
                          : (_listOfPicture.length < 3
                              ? _listOfPicture.length + 1
                              : _listOfPicture.length),
                      itemBuilder: (context, index) =>
                          generatePictures(context, index),
                    );
                  }),
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
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
              value: _categoryValue,
              focusNode: _categoryFocus,
              decoration: InputDecoration(
                enabledBorder: outlineInputBorder(Colours.gray),
                focusedBorder: outlineInputBorder(Colours.deepGreen),
                hintText: 'Memuat...',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
              isExpanded: true,
              items: _listOfCategory
                  .map<DropdownMenuItem<int>>(
                    (item) => DropdownMenuItem<int>(
                      value: item['id'],
                      child: SizedBox(
                        height: 32,
                        // decoration: BoxDecoration(
                        //   border: Border(
                        //     bottom: item == _listOfCategory.last ? BorderSide.none : const BorderSide(color: Colours.deepGreen, width: 2,),
                        //   ),
                        // ),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'lib/assets/images/category/${item['category_name']}.png'),
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item['category_name']!,
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
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _categoryValue = value!;
                });
              },
            ),
            const SizedBox(height: 8),
            // *Product Unit Field
            Row(
              children: const [
                Text(
                  'Pilih satuan dari produk anda',
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
              value: _unitValue,
              focusNode: _unitFocus,
              decoration: InputDecoration(
                enabledBorder: outlineInputBorder(Colours.gray),
                focusedBorder: outlineInputBorder(Colours.deepGreen),
                hintText: 'Memuat...',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
              isExpanded: true,
              items: _listOfUnit
                  .map<DropdownMenuItem<int>>(
                    (item) => DropdownMenuItem<int>(
                      value: item['id'],
                      child: Text(
                        item['unit_name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontStyles.regular,
                          color: Colours.deepGreen,
                          fontFamily: FontStyles.leagueSpartan,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _unitValue = value!;
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),
              ],
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(300),
              ],
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
          onPressed: () => editProcess(context),
          child: const Text(
            'Simpan',
            style: TextStyle(
                fontWeight: FontStyles.medium,
                fontFamily: FontStyles.leagueSpartan,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}
