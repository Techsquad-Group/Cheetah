// ignore_for_file: unused_field, unused_import

import 'package:cheeta/core/services/firestore_favorites.dart';
import 'package:cheeta/core/services/home_services.dart';
import 'package:cheeta/model/category_model.dart';
import 'package:cheeta/model/favorite_model.dart';
import 'package:cheeta/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../local_storage_data.dart';
import '../../model/user_model.dart';
import '../../view/add_product_view.dart';
import '../../view/home_view.dart';
import '../../view/profile_view.dart';

class FavoriteViewModel extends GetxController {
  Icon _icon = Icon(Icons.favorite_border);
  Icon get icon => _icon;

  final LocalStorageData localStorageData = Get.find();

  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<FavoriteModel> _allFavoriteModel = [];
  List<FavoriteModel> get allFavoriteModel => _allFavoriteModel;

  FavoriteModel _favoriteModel = new FavoriteModel();
  FavoriteModel get favoriteModel => _favoriteModel;

  UserModel _userModel = new UserModel();
  UserModel get userModel => _userModel;

  void getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    _loading.value = false;
    update();
  }

  FavoriteViewModel() {
    getAllFavorite();
    getCurrentUser();
  }

  clickFavorite(product) async {
    _favoriteModel = FavoriteModel(
      user: userModel.userId,
      product: product,
    );
    bool isExict = false;
    String favoriteID = '';

    for (int i = 0; i < _allFavoriteModel.length; i++) {
      if (_allFavoriteModel[i].user == userModel.userId) {
        for (int j = 0; j < _allFavoriteModel.length; j++) {
          if (_allFavoriteModel[j].product == product) {
            isExict = true;
            favoriteID = _allFavoriteModel[j].favoriteID ?? '';
            break;
          }
        }
        break;
      }
    }

    if (isExict) {
      await FireStoreFavorites().deleteProductFromFavorites(favoriteID);
      _icon = Icon(Icons.favorite_border);
    }
    if (!isExict) {
      await FireStoreFavorites()
          .addProductToFavorites(favoriteModel)
          .then((value) {
        value.update({
          'favoriteID': value.id,
        });
      });
      _icon = Icon(Icons.favorite);
    }
    _allFavoriteModel.clear();
    getAllFavorite();

    update();
  }

  getAllFavorite() async {
    _loading.value = true;
    FireStoreFavorites().isFavorite().then((value) {
      for (int i = 0; i < value.length; i++) {
        _allFavoriteModel.add(
            FavoriteModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      }
      _loading.value = false;
      update();
    });
  }

  isFavorite(product) {
    for (int i = 0; i < _allFavoriteModel.length; i++) {
      if (_allFavoriteModel[i].user == userModel.userId) {
        for (int j = 0; j < _allFavoriteModel.length; j++) {
          if (_allFavoriteModel[j].product == product) {
            _icon = Icon(Icons.favorite);
            break;
          } else {
            _icon = Icon(Icons.favorite_border);
          }
        }
      } else {
        _icon = Icon(Icons.favorite_border);
      }
    }
    update();

    return icon;
  }
}
