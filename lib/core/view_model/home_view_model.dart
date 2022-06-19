// ignore_for_file: unused_field

import 'package:cheeta/core/services/home_services.dart';
import 'package:cheeta/model/category_model.dart';
import 'package:cheeta/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../view/add_product_view.dart';
import '../../view/home_view.dart';
import '../../view/profile_view.dart';

class HomeViewModel extends GetxController {
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<CategoryModel> _categoryModel = [];
  List<CategoryModel> get categoryModel => _categoryModel;

  List<ProductModel> _productModel = [];
  List<ProductModel> get productModel => _productModel;

  HomeViewModel() {
    getCategory();
    getProduct();
  }

  getCategory() async {
    _loading.value = true;
    HomeServices().getCategory().then((value) {
      for (int i = 0; i < value.length; i++) {
        _categoryModel.add(
            CategoryModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
        _loading.value = false;
      }
      update();
    });
  }

  getProduct() async {
    _loading.value = true;
    HomeServices().getProduct().then((value) {
      for (int i = 0; i < value.length; i++) {
        _productModel.add(
            ProductModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
        _loading.value = false;
      }
      update();
    });
  }

  deleteProduct(String productId) async {
    loading.value = true;
    await HomeServices().deleteProductFromFireStore(productId).then((value) {
      _productModel.clear();
      getProduct();
      _loading.value = false;
      update();
    });
  }

  updateProduct(String productId, String date, String name, String price,
      String des) async {
    loading.value = true;
    await HomeServices()
        .updateProductFromFireStore(productId, date, name, price, des)
        .then((value) {
      _productModel.clear();
      getProduct();
      _loading.value = false;
      update();
    });
  }
}
