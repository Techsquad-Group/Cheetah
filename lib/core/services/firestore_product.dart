//import 'dart:html';

import 'package:cheeta/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/product_model.dart';

class FireStoreProduct {
  final CollectionReference _productCollectionRef =
      FirebaseFirestore.instance.collection('Products');

  Future<List<QueryDocumentSnapshot>> getProductsFromFirestore() async {
    var _products = await _productCollectionRef.get();
    return _products.docs;
  }

  Future<void> addProductToFireStore(ProductModel productModel) async {
    return await _productCollectionRef.doc().set(productModel.toJson());
  }

  // Future<void> readProductsFromFireStore() async {
  //   return await _productCollectionRef.get().then((event) {
  //     for (var doc in event.docs) {
  //       print("${doc.id} => ${doc.data()}");
  //     }
  //   });
  // }

  // Future<void> deleteProductsFromFireStore(ProductModel productModel) async {
  //   return await _productCollectionRef
  //       .doc(productModel.itemId)
  //       .delete();
  // }
}
