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

  Future<DocumentSnapshot> getCurrentUser(String uid) async {
    DocumentSnapshot documentSnapshot = await _userCollectionRef.doc(uid).get();
    return documentSnapshot;
  }
}
