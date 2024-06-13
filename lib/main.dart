import 'package:flutter/material.dart';
import 'package:wataburger/ApiKey/ApiKey.dart';
import 'Pages/ProductsScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'dart:io';
import './ApiKey/ApiKey.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {

    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey:  ApiKey.apiKey,
        appId: ApiKey.appId,
        messagingSenderId: ApiKey.messagingSenderId,
        projectId:ApiKey.projectId,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  // await Firebase.initializeApp();
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