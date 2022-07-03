import 'package:cheeta/model/favorite_model.dart';
import 'package:cheeta/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreFavorites {
  final CollectionReference _favoritesCollectionRef =
      FirebaseFirestore.instance.collection('Favorites');

  Future<DocumentReference<Object?>> addProductToFavorites(
      FavoriteModel favoriteModel) async {
    return await _favoritesCollectionRef.add(favoriteModel.toJson());
  }

  Future<void> deleteProductFromFavorites(String favoriteID) async {
    await _favoritesCollectionRef.doc(favoriteID).delete();
  }

  Future<List<QueryDocumentSnapshot>> isFavorite() async {
    var value = await _favoritesCollectionRef.get();
    return value.docs;
  }
}
