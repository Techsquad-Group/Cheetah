//import 'dart:html';

import 'package:cheeta/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .doc(userModel.userId)
        .set(userModel.toJson());
  }
}

class FireStoreProduct {
  final CollectionReference _productCollectionRef =
      FirebaseFirestore.instance.collection('Products');

  Future<void> addProductToFireStore(ProductModel productModel) async {
    return await _productCollectionRef
        .doc(productModel.itemId)
        .set(productModel.toJson());
  }
}
