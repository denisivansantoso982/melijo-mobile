// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:melijo/bloc/buyers/melijo/melijo_buyer_bloc.dart';
import 'package:melijo/bloc/buyers/product/product_buyers_bloc.dart';
import 'package:melijo/bloc/buyers/recipe/recipe_buyers_bloc.dart';
import 'package:melijo/bloc/buyers/recipe_favourite/recipe_favourite_bloc.dart';
import 'package:melijo/bloc/sellers/products/product_seller_bloc.dart';
import 'package:melijo/bloc/sellers/transactions/transaction_seller_bloc.dart';
import 'package:melijo/configs/api/api_request.dart';
import 'package:melijo/configs/firebase/firebase.dart';
import 'package:melijo/configs/preferences/preferences.dart';
import 'package:melijo/models/buyers/cart_buyers_model.dart';
import 'package:melijo/models/buyers/melijo_buyers_model.dart';
import 'package:melijo/models/buyers/product_buyers_model.dart';
import 'package:melijo/models/buyers/product_recom_model.dart';
import 'package:melijo/models/buyers/promo_buyers_model.dart';
import 'package:melijo/models/buyers/recipe_buyers_model.dart';
import 'package:melijo/models/buyers/recipe_favourite_model.dart';
import 'package:melijo/models/sellers/product_seller_model.dart';
import 'package:melijo/models/sellers/transaction_seller_model.dart';

Preferences preferences = Preferences();
FDatabase database = FDatabase();
ApiRequest api_request = ApiRequest();

String thousandFormat(int val) {
  String result = NumberFormat('###,###,###').format(val).replaceAll(',', '.');
  return result;
}

Future<int?> checkUserRole() async {
  final int? role = await preferences.checkUserRole();
  return Future.value(role);
}

Future<void> logout() async {
  try {
    final Map<String, dynamic> user_data = await preferences.getUser();
    await preferences.deleteUser();
    await database.deleteUserToken(user_data['id'], user_data['role']);
  } catch (error) {
    return Future.error(Exception(error));
  }
}

Future<Map> getUserInfo() async {
  return Future.value(preferences.getUser());
}

Future<List<dynamic>> retrieveProvinces() async {
  try {
    List<dynamic> list_province = await api_request.getProvinces();
    return Future.value(list_province);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<dynamic>> retrieveCities(int id_province) async {
  try {
    List<dynamic> list_city = await api_request.getCities(id_province);
    return Future.value(list_city);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<dynamic>> retrieveDistricts(int id_city) async {
  try {
    List<dynamic> list_district = await api_request.getDistricts(id_city);
    return Future.value(list_district);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<dynamic>> retrieveVillages(int id_district) async {
  try {
    List<dynamic> list_village = await api_request.getVillages(id_district);
    return Future.value(list_village);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> login(String user, String password, bool is_seller) async {
  try {
    final Map response =
        await api_request.login(user, password);
    final Map<String, dynamic> user_data = response['user'];
    final Map<String, dynamic> user_detail = response['detail'];
    final Map<String, dynamic> user_address = response['address']['address'];
    final Map<String, dynamic>? plotting = response['plotting'].isNotEmpty ? response['plotting'][0] : null ;
    if (is_seller && user_data['role_id'] != 4) {
      throw 'Pengguna tidak ditemukan!';
    } else if (!is_seller && user_data['role_id'] != 3) {
      throw 'Pengguna tidak ditemukan!';
    }
    final String auth_token = response['token'];
    final String token_type = response['token_type'];
    final String fcm_token = await database.generateFCMToken();
    await api_request.setFCMToken(user_data['id'], fcm_token);
    await database.setUserWhenLogin(
        user_detail['id'], user_data['role_id'], fcm_token);
    await preferences.setUserLogin(
      id: user_data['id'],
      id_detail: user_detail['id'],
      role: user_data['role_id'],
      avatar: user_data['image'],
      username: user_data['username'] ?? '',
      email: user_data['email'],
      name: user_detail['name'],
      phone: user_detail['phone'],
      fcm_token: fcm_token,
      auth_token: auth_token,
      token_type: token_type,
      province: user_address['province'],
      city: user_address['city'],
      district: user_address['districts'],
      ward: user_address['ward'],
      seller_id: plotting?['user_seller_id'],
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> register(
  String name,
  String email,
  String phone,
  String password,
  int role_id,
  int province,
  int city,
  int districts,
  List<int> village,
) async {
  try {
    if (role_id == 3) {
      await api_request.register(name, email, phone, password, role_id,
          province, city, districts, village[0]);
    } else {
      await api_request.registerSeller(name, email, phone, password, role_id,
          province, city, districts, village);
    }
  } catch (error) {
    return Future.error(error);
  }
}

Future<Map<String, dynamic>> sellerInfoCount() async {
  try {
    final Map<String, dynamic> user = await preferences.getUser();
    final Map<String, dynamic> response = await api_request.getCount(
        user['id_detail'], user['token_type'], user['auth_token']);
    return Future.value(response);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> uploadProduct({
  required String name,
  required int category,
  required int price,
  required String description,
  required int unit,
  required List<XFile> pictures,
}) async {
  try {
    final Map<String, dynamic> user_data = await preferences.getUser();
    final Map<String, dynamic> response = await api_request.uploadProduct(
      seller_id: user_data['id_detail'],
      category: category,
      unit: unit,
      price: price,
      name: name,
      description: description,
      token_type: user_data['token_type'],
      token: user_data['auth_token'],
    );
    final int id_product = response['id'];
    for (XFile element in pictures) {
      await api_request.uploadPicture(
        element,
        id_product,
        user_data['token_type'],
        user_data['auth_token'],
      );
    }
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> getProductsSeller(BuildContext context) async {
  try {
    final Map user_data = await preferences.getUser();
    final List<ProductSellerModel> listProduct = [];
    final List<dynamic> response = await api_request.retrieveProductSeller(
      user_data['id_detail'],
      user_data['token_type'],
      user_data['auth_token'],
    );
    for (var element in response) {
      listProduct.add(ProductSellerModel(
        id: element['id'],
        price: element['price'],
        category_id: element['category_id'],
        unit_id: element['unit_id'],
        product_name: element['product_name'],
        image_uri: element['image'],
        description: element['description'],
      ));
    }
    context.read<ProductSellerBloc>().add(const DeleteProductSeller());
    context
        .read<ProductSellerBloc>()
        .add(AddProductSeller(productSellerModel: listProduct));
  } catch (error) {
    return Future.error(error);
  }
}

Future<Map> getDetailProductSeller(BuildContext context, int product_id) async {
  try {
    final Map user_data = await preferences.getUser();
    final Map response = await api_request.retrieveDetailProductSeller(
      user_data['token_type'],
      user_data['auth_token'],
      product_id,
    );
    return Future.value(response);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> deleteProductSeller(int id) async {
  try {
    final Map user_data = await preferences.getUser();
    await api_request.deleteProductSeller(
      user_data['token_type'],
      user_data['auth_token'],
      id,
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> editProduct(ProductSellerModel product) async {
  try {
    final Map<String, dynamic> user_data = await preferences.getUser();
    await api_request.editProductSeller(
      user_data['token_type'],
      user_data['auth_token'],
      user_data['id_detail'],
      product,
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> getTransactionSeller(BuildContext context) async {
  try {
    final Map user_data = await preferences.getUser();
    final List<TransactionSellerModel> listTransaction = [];
    final List<dynamic> response = await api_request.retrieveTransactionSeller(
      user_data['id_detail'],
      user_data['token_type'],
      user_data['auth_token'],
    );
    for (var element in response) {
      listTransaction.add(TransactionSellerModel(
        txid: element['txid'],
        date_order: DateTime.parse(element['date_order']),
        status: element['status'],
        promo: element['promo'],
        promo_code: element['promo_code'],
        customer_id: element['user_customer']['id'],
        seller_id: element['user_seller']['id'],
        customer_name: element['user_customer']['name'],
        seller_name: element['user_seller']['name'],
        total: element['total'],
        operator_id: element['user_operator_id'],
        information: element['information'],
      ));
    }
    context.read<TransactionSellerBloc>().add(DeleteTransaction());
    context
        .read<TransactionSellerBloc>()
        .add(FillTransaction(transactionSellerModel: listTransaction));
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> getProfileInfo() async {
  try {
    final Map user_data = await preferences.getUser();
    final Map response = await api_request.getProfile(
        user_data['id'], user_data['token_type'], user_data['auth_token']);
    await preferences.setUserProfile(
      role: response['user']['role_id'],
      name: response['user_detail']['name'],
      username: response['user']['username'] ?? '',
      email: response['user']['email'],
      phone: response['user_detail']['phone'],
      avatar: response['user']['image'] ?? '',
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> uploadAvatar(XFile file) async {
  try {
    final Map<String, dynamic> user_data = await preferences.getUser();
    final int id = user_data['id'];
    await api_request.uploadAvatar(
        file, id, user_data['token_type'], user_data['auth_token']);
  } catch (error) {
    return Future.error(error);
  }
}

Future<Map> getLocation() async {
  try {
    final Map<String, dynamic> user_data = await preferences.getUser();
    final String province =
        await api_request.getProvinceById(user_data['province']);
    final String city = await api_request.getCityById(user_data['city']);
    final String district =
        await api_request.getDistrictById(user_data['district']);
    final String ward = await api_request.getWardById(user_data['ward']);
    return Future.value({
      'province': province,
      'city': city,
      'district': district,
      'ward': ward,
    });
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> confirmTransaction(
  String txid,
  String? promo_code,
  int seller_id,
  int customer_id,
  int total,
  int? operator_id,
) async {
  try {
    final Map user_data = await preferences.getUser();
    await api_request.confirmTransactionSeller(
      txid,
      promo_code,
      seller_id,
      customer_id,
      total,
      operator_id,
      user_data['token_type'],
      user_data['auth_token'],
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> editProfile(
  String name,
  String username,
  String phone,
  String email,
) async {
  try {
    final Map user_data = await preferences.getUser();
    final Map response = await api_request.editProfile(
      user_data['id'],
      username,
      email,
      name,
      phone,
      user_data['token_type'],
      user_data['auth_token'],
    );
    await preferences.setUserProfile(
      role: response['user']['role_id'],
      name: response['user_detail']['name'],
      username: response['user']['username'],
      email: response['user']['email'],
      phone: response['user_detail']['phone'],
      avatar: response['user']['image'],
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> getMelijoByWard(BuildContext context) async {
  try {
    final Map user_data = await preferences.getUser();
    List<MelijoBuyersModel> listOfMelijo = [];
    final List response = await api_request.retrieveMelijoByWard(
      user_data['ward'],
      user_data['token_type'],
      user_data['auth_token'],
    );
    for (Map element in response) {
      listOfMelijo.add(MelijoBuyersModel(
        seller_id: element['seller_id'],
        user_id: element['user_id'],
        name: element['name'],
        phone: element['phone'],
        email: element['email'],
        fcm_token: element['fcm_token'],
        province: element['province'],
        city: element['city'],
        districts: element['districts'],
        ward: element['ward'],
        image: element['image'],
        username: element['username'],
      ));
    }
    context.read<MelijoBuyerBloc>().add(const DeleteMelijo());
    context.read<MelijoBuyerBloc>().add(FillMelijo(melijoBuyers: listOfMelijo));
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> getProductsBuyers(BuildContext context) async {
  try {
    final Map user_data = await preferences.getUser();
    final List<ProductBuyersModel> listProduct = [];
    final List<dynamic> response = await api_request.retrieveProductSeller(
      user_data['seller_id'],
      user_data['token_type'],
      user_data['auth_token'],
    );
    for (var element in response) {
      listProduct.add(ProductBuyersModel(
        id: element['id'],
        price: element['price'],
        category_id: element['category_id'],
        unit_id: element['unit_id'],
        product_name: element['product_name'],
        image_uri: element['image'],
        description: element['description'],
        user_seller_id: element['user_seller_id'],
      ));
    }
    context.read<ProductBuyersBloc>().add(const DeleteProductBuyer());
    context
        .read<ProductBuyersBloc>()
        .add(FillProductBuyer(productBuyerModel: listProduct));
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> getRecipe(BuildContext context) async {
  try {
    final Map user_data = await preferences.getUser();
    final List<RecipeBuyersModel> listRecipe = [];
    final List<RecipeFavouriteModel> listRecipeFav = [];
    final List<dynamic> recipes = await api_request.retrieveRecipes(
      user_data['token_type'],
      user_data['auth_token'],
    );
    final List<dynamic> recipe_fav = await api_request.retrieveRecipeFavourites(
      user_data['id_detail'],
      user_data['token_type'],
      user_data['auth_token'],
    );
    for (var element in recipes) {
      listRecipe.add(RecipeBuyersModel(
        id: element['id'],
        recipe_title: element['recipe_title'],
        category_id: element['recipe_category_id'],
        step: element['step'],
        image: element['image'],
      ));
    }
    for (var element in recipe_fav) {
      listRecipeFav.add(RecipeFavouriteModel(
        id: element['id'],
        user_customer_id: element['user_customer_id'],
        recipe_id: element['recipe_id'],
      ));
    }
    context
        .read<RecipeFavouriteBloc>()
        .add(FillRecipeFav(recipeFavs: listRecipeFav));
    context.read<RecipeBuyersBloc>().add(FillRecipe(listRecipe: listRecipe));
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> addRecipeFav(int recipe_id) async {
  try {
    final Map user_data = await preferences.getUser();
    await api_request.newRecipeFav(
      user_data['id_detail'],
      recipe_id,
      user_data['token_type'],
      user_data['auth_token'],
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> deleteRecipeFav(int fav_id) async {
  try {
    final Map user_data = await preferences.getUser();
    await api_request.removeRecipeFav(
      fav_id,
      user_data['token_type'],
      user_data['auth_token'],
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> addToCart(int product_id, int quantity) async {
  try {
    final Map user_data = await preferences.getUser();
    await api_request.addProductToCart(
      product_id,
      user_data['id_detail'],
      quantity,
      user_data['token_type'],
      user_data['auth_token'],
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<CartBuyersModel>> retrieveCart() async {
  try {
    final Map user_data = await preferences.getUser();
    final List<CartBuyersModel> listCart = [];
    final List<dynamic> response = await api_request.retrieveCart(
      user_data['id_detail'],
      user_data['token_type'],
      user_data['auth_token'],
    );
    for (var element in response) {
      listCart.add(CartBuyersModel(
        id: element['cart_id'],
        product_id: element['product_id'],
        user_customer_id: element['user_customer_id'],
        quantity: element['quantity'],
        product: ProductBuyersModel(
          id: element['product_id'],
          price: element['price'],
          category_id: element['category_id'],
          unit_id: element['unit_id'],
          product_name: element['product_name'],
          image_uri: element['image'],
          description: element['description'],
          user_seller_id: element['user_seller_id'],
        ),
      ));
    }
    // context.read<CartBuyersBloc>().add(FillCart(carts: listCart));
    // BlocProvider.of<CartBuyersBloc>(context, listen: false).add(FillCart(carts: listCart));
    return Future.value(listCart);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> deleteProductCart(int cart_id) async {
  try {
    final Map user_data = await preferences.getUser();
    await api_request.deleteProductCart(
      cart_id,
      user_data['token_type'],
      user_data['auth_token'],
    );
    // BlocProvider.of<CartBuyersBloc>(context, listen: false).add(DeleteCart());
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<PromoBuyersModel>> getPromos() async {
  try {
    final Map user_data = await preferences.getUser();
    final List<PromoBuyersModel> listPromo = [];
    final List<dynamic> response = await api_request.retrievePromo(
      user_data['token_type'],
      user_data['auth_token'],
    );
    for (var element in response) {
      listPromo.add(PromoBuyersModel(
        promo_code: element['promo_code'],
        promo_title: element['promo_title'],
        promo_description: element['promo_description'],
        promo_end: element['promo_end'],
        promo_total: element['promo_total'],
      ));
    }
    return Future.value(listPromo);
  } catch (error) {
    return Future.error(error);
  }
}

Future<Map> addTransaction(List<CartBuyersModel> carts, PromoBuyersModel? promo,
    DateTime date_distribution, int total, String distribution_info) async {
  try {
    final Map user_data = await preferences.getUser();
    Map response = await api_request.addNewTransacion(
      user_data['id_detail'],
      carts[0].product.user_seller_id,
      promo?.promo_code,
      date_distribution,
      total,
      distribution_info,
      carts,
      user_data['token_type'],
      user_data['auth_token'],
    );
    return Future.value(response);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> payment(String txid, XFile file, int pay) async {
  try {
    final Map user_data = await preferences.getUser();
    await api_request.payment(
      txid,
      file,
      pay,
      user_data['token_type'],
      user_data['auth_token'],
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<ProductRecomModel>> retrieveProductRecom(int recipe_id) async {
  try {
    final Map user_data = await preferences.getUser();
    final List<ProductRecomModel> response =
        await api_request.retrieveProductRecom(
      recipe_id,
      user_data['token_type'],
      user_data['auth_token'],
    );
    return Future.value(response);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<ProductBuyersModel>> searchProduct(String keyword) async {
  try {
    final Map user_data = await preferences.getUser();
    final List<ProductBuyersModel> response = await api_request.searchProduct(
      keyword,
      user_data['seller_id'],
      user_data['token_type'],
      user_data['auth_token'],
    );
    return Future.value(response);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List<RecipeBuyersModel>> searchRecipe(String keyword) async {
  try {
    final Map user_data = await preferences.getUser();
    final List<RecipeBuyersModel> response = await api_request.searchRecipe(
      keyword,
      user_data['token_type'],
      user_data['auth_token'],
    );
    return Future.value(response);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> retrieveDetailTransactionSeller(String txid) async {
  try {
    final Map user_data = await preferences.getUser();
    final List response = await api_request.getDetailTransactionSeller(
      txid,
      user_data['token_type'],
      user_data['auth_token'],
    );
    return Future.value(response);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> getTransactionCustomer(BuildContext context) async {
  try {
    final Map user_data = await preferences.getUser();
    final List<TransactionSellerModel> listTransaction = [];
    final List<dynamic> response = await api_request.retrieveTransactionSeller(
      user_data['id_detail'],
      user_data['token_type'],
      user_data['auth_token'],
    );
    for (var element in response) {
      listTransaction.add(TransactionSellerModel(
        txid: element['txid'],
        date_order: DateTime.parse(element['date_order']),
        status: element['status'],
        promo: element['promo'],
        promo_code: element['promo_code'],
        customer_id: element['user_customer']['id'],
        seller_id: element['user_seller']['id'],
        customer_name: element['user_customer']['name'],
        seller_name: element['user_seller']['name'],
        total: element['total'],
        operator_id: element['user_operator_id'],
        information: element['information'],
      ));
    }
    context.read<TransactionSellerBloc>().add(DeleteTransaction());
    context
        .read<TransactionSellerBloc>()
        .add(FillTransaction(transactionSellerModel: listTransaction));
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> cancelTransaction(String txid) async {
  try {
    final Map user_data = await preferences.getUser();
    await api_request.cancelTransactionCustomer(
      txid,
      user_data['token_type'],
      user_data['auth_token'],
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> subscribeNotif() async {
  await database.subscribeTopic();
}

Future<void> pushNotifToCust(int customer_id, String body, String title) async {
  try {
    final String fcm = await database.getFCMToken(customer_id, 3);
    await api_request.pushNotification(fcm, body, title);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> pushNotifToSeller(String body, String title) async {
  try {
    final Map user_data = await preferences.getUser();
    final String fcm = await database.getFCMToken(user_data['seller_id'], 4);
    await api_request.pushNotification(fcm, body, title);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getUnit() async {
  try {
    final Map user_data = await preferences.getUser();
    final List categories = await api_request.retrieveUnit(
      user_data['token_type'],
      user_data['auth_token'],
    );
    return Future.value(categories);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getCategoryProduct() async {
  try {
    final Map user_data = await preferences.getUser();
    final List categories = await api_request.retrieveCategoryProduct(
      user_data['token_type'],
      user_data['auth_token'],
    );
    return Future.value(categories);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getCategoryRecipe() async {
  try {
    final Map user_data = await preferences.getUser();
    final List categories = await api_request.retrieveCategoryRecipe(
      user_data['token_type'],
      user_data['auth_token'],
    );
    return Future.value(categories);
  } catch (error) {
    return Future.error(error);
  }
}