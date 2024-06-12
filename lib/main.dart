import 'package:flutter/material.dart';
import 'Pages/ProductsScreen.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
void main() async {
  await PersistentShoppingCart().init();
  runApp(
    MaterialApp(
      title: 'Wataburger',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home:  ProductsScreen(),
    ),
  );
}