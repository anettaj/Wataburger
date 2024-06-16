import 'package:flutter/material.dart';
import 'package:wataburger/ApiKey/ApiKey.dart';
import 'Pages/ProductsScreen.dart';
import 'Pages/TestScreen.dart';
import 'Pages/menu.dart';
import 'Pages/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'dart:io';
import './ApiKey/ApiKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase based on platform
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: ApiKey.apiKey,
        appId: ApiKey.appId,
        messagingSenderId: ApiKey.messagingSenderId,
        projectId: ApiKey.projectId,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  // Initialize shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Initialize persistent shopping cart
  await PersistentShoppingCart().init();

  // Run the app
  runApp(
    MaterialApp(
      title: 'Wataburger',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: loggedIn ? Menu() : LoginScreen(),
    ),
  );
}
