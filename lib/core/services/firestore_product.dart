import 'package:cheeta/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreProduct {
  final CollectionReference _productCollectionRef =
      FirebaseFirestore.instance.collection('Products');

  Future<DocumentReference<Object?>> addProductToFireStore(
      ProductModel productModel) async {
    return await _productCollectionRef.add(productModel.toJson());
  }
}
