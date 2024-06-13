// fetch_products.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ItemModel.dart';


Future<List<ItemModel>> fetchBurger() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Burger').get();
  return querySnapshot.docs.map((doc) {
    return ItemModel(
      productId: doc['Id'],
      productName: doc['Name'],
      productDescription: doc['Description'],
      productThumbnail: doc['Thumbnail'],
      unitPrice: doc['Price'].toDouble(),
    );
  }).toList();
}

Future<List<ItemModel>> fetchMojitos() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('MOJITOS').get();
  return querySnapshot.docs.map((doc) {
    return ItemModel(
      productId: doc['Id'],
      productName: doc['Name'],
      productDescription: doc['Description'],
      productThumbnail: doc['Thumbnail'],
      unitPrice: doc['Price'].toDouble(),
    );
  }).toList();
}

Future<List<ItemModel>> fetchCHICKEN_WINGS() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('CHICKEN_WINGS').get();
  return querySnapshot.docs.map((doc) {
    return ItemModel(
      productId: doc['Id'],
      productName: doc['Name'],
      productDescription: doc['Description'],
      productThumbnail: doc['Thumbnail'],
      unitPrice: doc['Price'].toDouble(),
    );
  }).toList();
}

Future<List<ItemModel>> fetchCOOKIE_SHAKES() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('COOKIE_SHAKES').get();
  return querySnapshot.docs.map((doc) {
    return ItemModel(
      productId: doc['Id'],
      productName: doc['Name'],
      productDescription: doc['Description'],
      productThumbnail: doc['Thumbnail'],
      unitPrice: doc['Price'].toDouble(),
    );
  }).toList();
}

Future<List<ItemModel>> fetchFRIES() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('FRIES').get();
  return querySnapshot.docs.map((doc) {
    return ItemModel(
      productId: doc['Id'],
      productName: doc['Name'],
      productDescription: doc['Description'],
      productThumbnail: doc['Thumbnail'],
      unitPrice: doc['Price'].toDouble(),
    );
  }).toList();
}