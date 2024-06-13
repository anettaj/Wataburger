// fetch_products.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ItemModel.dart';


Future<List<ItemModel>> fetchProducts() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('products').get();
  return querySnapshot.docs.map((doc) {
    return ItemModel(
      productId: doc['productId'],
      productName: doc['productName'],
      productDescription: doc['productDescription'],
      productThumbnail: doc['productThumbnail'],
      unitPrice: doc['unitPrice'].toDouble(),
    );
  }).toList();
}
