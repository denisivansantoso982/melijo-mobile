import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melijo/bloc/buyers/cart/cart_buyers_bloc.dart';
import 'package:melijo/bloc/buyers/cart_action/cart_action_bloc.dart';
import 'package:melijo/bloc/buyers/melijo/melijo_buyer_bloc.dart';
import 'package:melijo/bloc/buyers/product/product_buyers_bloc.dart';
import 'package:melijo/bloc/buyers/recipe/recipe_buyers_bloc.dart';
import 'package:melijo/bloc/buyers/recipe_favourite/recipe_favourite_bloc.dart';
import 'package:melijo/bloc/sellers/products/product_seller_bloc.dart';
import 'package:melijo/bloc/sellers/transactions/transaction_seller_bloc.dart';
import 'package:melijo/screens/buyers/communications/chat_buyers_screen.dart';
import 'package:melijo/screens/buyers/communications/detail_chat_buyers_screen.dart';
import 'package:melijo/screens/buyers/communications/notification_buyers_screen.dart';
import 'package:melijo/screens/buyers/dashboard/dashboard_buyers_screen.dart';
import 'package:melijo/screens/buyers/login/login_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/cart_product_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/detail_product_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/products_buyers_screen.dart';
import 'package:melijo/screens/buyers/recipes/detail_recipe_buyers_screen.dart';
import 'package:melijo/screens/buyers/recipes/favourite_recipes_buyers_screen.dart';
import 'package:melijo/screens/buyers/products/search_product_screen.dart';
import 'package:melijo/screens/buyers/recipes/search_recipe_screen.dart';
import 'package:melijo/screens/buyers/register/register_buyers_screen.dart';
import 'package:melijo/screens/buyers/transactions/detail_transactions_screen.dart';
import 'package:melijo/screens/buyers/transactions/distribution_address_screen.dart';
import 'package:melijo/screens/buyers/transactions/distribution_date_screen.dart';
import 'package:melijo/screens/buyers/transactions/payment_method_screen.dart';
import 'package:melijo/screens/buyers/transactions/payment_proof_screen.dart';
import 'package:melijo/screens/buyers/transactions/payment_screen.dart';
import 'package:melijo/screens/buyers/transactions/promo_screen.dart';
import 'package:melijo/screens/sellers/dashboard/dashboard_sellers_screen.dart';
import 'package:melijo/screens/sellers/login/login_sellers_screen.dart';
import 'package:melijo/screens/sellers/products/add_product_sellers_screen.dart';
import 'package:melijo/screens/sellers/products/edit_product_sellers_screen.dart';
import 'package:melijo/screens/sellers/register/register_sellers_screen.dart';
import 'package:melijo/screens/sellers/transaction/detail_transaction_seller_screen.dart';
import 'package:melijo/screens/starts/first_screen.dart';
import 'package:melijo/screens/starts/login/login_screen.dart';
import 'package:melijo/screens/starts/register/register_screen.dart';
import 'package:melijo/screens/starts/splash_screen.dart';
import 'package:melijo/utils/colours.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductSellerBloc>(create: (context) => ProductSellerBloc()),
        BlocProvider<TransactionSellerBloc>(create: (context) => TransactionSellerBloc()),
        BlocProvider<MelijoBuyerBloc>(create: (context) => MelijoBuyerBloc()),
        BlocProvider<ProductBuyersBloc>(create: (context) => ProductBuyersBloc()),
        BlocProvider<RecipeBuyersBloc>(create: (context) => RecipeBuyersBloc()),
        BlocProvider<CartBuyersBloc>(create: (context) => CartBuyersBloc()),
        BlocProvider<CartActionBloc>(create: (context) => CartActionBloc()),
        BlocProvider<RecipeFavouriteBloc>(create: (context) => RecipeFavouriteBloc()),
      ],
      child: MaterialApp(
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
          DashboardSellersScreen.route: (context) =>
              const DashboardSellersScreen(),
          AddProductSellerScreen.route: (context) =>
              const AddProductSellerScreen(),
          EditProductSellerScreen.route: (context) =>
              const EditProductSellerScreen(),
          DashboardBuyersScreen.route: (context) => const DashboardBuyersScreen(),
          DetailTransactionScreen.route: (context) =>
              const DetailTransactionScreen(),
          DetailProductBuyersScreen.route: (context) =>
              const DetailProductBuyersScreen(),
          CartProductBuyersScreen.route: (context) =>
              const CartProductBuyersScreen(),
          DetailRecipeBuyersScreen.route: (context) =>
              const DetailRecipeBuyersScreen(),
          FavouriteRecipesBuyersScreen.route: (context) =>
              const FavouriteRecipesBuyersScreen(),
          NotificationBuyersScreen.route: (context) =>
              const NotificationBuyersScreen(),
          ChatBuyersScreen.route: (context) => const ChatBuyersScreen(),
          DetailChatBuyersScreen.route: (context) =>
              const DetailChatBuyersScreen(),
          DistributionDateScreen.route: (context) =>
              const DistributionDateScreen(),
          DistributionAddressScreen.route: (context) =>
              const DistributionAddressScreen(),
          PaymentScreen.route: (context) => const PaymentScreen(),
          PaymentMethodScreen.route: (context) => const PaymentMethodScreen(),
          PromoScreen.route: (context) => const PromoScreen(),
          ProductsBuyersScreen.route: (context) => const ProductsBuyersScreen(),
          PaymentProofScreen.route: (context) => const PaymentProofScreen(),
          SearchProductScreen.route: (context) => const SearchProductScreen(),
          SearchRecipeScreen.route: (context) => const SearchRecipeScreen(),
          DetailTransactionSellerScreen.route: (context) => const DetailTransactionSellerScreen(),
        },
      ),
    );
  }
}
