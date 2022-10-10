import 'package:flutter/material.dart';
import 'package:melijo/screens/buyers/communications/chat_buyers_screen.dart';
import 'package:melijo/screens/buyers/communications/notification_buyers_screen.dart';
import 'package:melijo/screens/buyers/dashboard/dashboard_buyers_screen.dart';
import 'package:melijo/screens/buyers/login/login_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/cart_product_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/detail_product_buyers_screen.dart';
import 'package:melijo/screens/buyers/recipes/detail_recipe_buyers_screen.dart';
import 'package:melijo/screens/buyers/recipes/favourite_recipes_buyers_screen.dart';
import 'package:melijo/screens/buyers/register/register_buyers_screen.dart';
import 'package:melijo/screens/buyers/transactions/detail_transactions_screen.dart';
import 'package:melijo/screens/sellers/dashboard/dashboard_sellers_screen.dart';
import 'package:melijo/screens/sellers/login/login_sellers_screen.dart';
import 'package:melijo/screens/sellers/products/add_product_sellers_screen.dart';
import 'package:melijo/screens/sellers/products/edit_product_sellers_screen.dart';
import 'package:melijo/screens/sellers/register/register_sellers_screen.dart';
import 'package:melijo/screens/starts/first_screen.dart';
import 'package:melijo/screens/starts/login/login_screen.dart';
import 'package:melijo/screens/starts/register/register_screen.dart';
import 'package:melijo/screens/starts/splash_screen.dart';
import 'package:melijo/utils/colours.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melijo.id',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colours.deepGreen,
          secondary: Colours.deepGreen,
          background: Colours.white,
        ),
        scaffoldBackgroundColor: Colours.white,
        backgroundColor: Colours.white,
        appBarTheme: const AppBarTheme().copyWith(elevation: 2),
      ),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        FirstScreen.route: (context) => const FirstScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        RegisterScreen.route: (context) => const RegisterScreen(),
        LoginSellersScreen.route: (context) => const LoginSellersScreen(),
        LoginBuyersScreen.route: (context) => const LoginBuyersScreen(),
        RegisterSellersScreen.route: (context) => const RegisterSellersScreen(),
        RegisterBuyersScreen.route: (context) => const RegisterBuyersScreen(),
        DashboardSellersScreen.route: (context) => const DashboardSellersScreen(),
        AddProductSellerScreen.route: (context) => const AddProductSellerScreen(),
        EditProductSellerScreen.route: (context) => const EditProductSellerScreen(),
        DashboardBuyersScreen.route: (context) => const DashboardBuyersScreen(),
        DetailTransactionScreen.route: (context) => const DetailTransactionScreen(),
        DetailProductBuyersScreen.route: (context) => const DetailProductBuyersScreen(),
        CartProductBuyersScreen.route: (context) => const CartProductBuyersScreen(),
        DetailRecipeBuyersScreen.route: (context) => const DetailRecipeBuyersScreen(),
        FavouriteRecipesBuyersScreen.route: (context) => const FavouriteRecipesBuyersScreen(),
        NotificationBuyersScreen.route: (context) => const NotificationBuyersScreen(),
        ChatBuyersScreen.route: (context) => const ChatBuyersScreen(),
      },
    );
  }
}