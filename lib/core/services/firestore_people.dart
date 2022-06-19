import 'package:cheeta/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorePeople {
  final CollectionReference _peopleCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<List<QueryDocumentSnapshot>> getPeople() async {
    var value = await _peopleCollectionRef.get();
    return value.docs;
  }

  Future<DocumentSnapshot> getSpecificUser(String uid) async {
    DocumentSnapshot documentSnapshot =
        await _peopleCollectionRef.doc(uid).get();
    return documentSnapshot;
  }
}
