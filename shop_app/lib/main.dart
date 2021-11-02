import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/auth_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.green,
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.yellowAccent,
          ),
          fontFamily: "Lato",
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            centerTitle: true,
          ),
        ),
        home: const AuthScreen(),
        // initialRoute: '/',
        routes: {
          // '/': (context) => const ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductScreen.routeName: (context) => const UserProductScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}
