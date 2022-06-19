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

  Future<void> deleteProfileFromFireStore(String userId) async {
    await _userCollectionRef.doc(userId).delete();
  }

  Future<void> updateProfileFromFireStore(
      String userId, String name, String number) async {
    await _userCollectionRef.doc(userId).update({
      'name': name,
      'number': number,
    });
  }
}
