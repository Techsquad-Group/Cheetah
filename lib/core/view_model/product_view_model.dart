// ignore_for_file: unnecessary_overrides, override_on_non_overriding_member, unused_field, prefer_final_fields, unused_local_variable, avoid_print

import 'package:cheeta/model/product_model.dart';
import 'package:cheeta/view/product/add_product_view.dart';
import 'package:cheeta/view/category/men_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../services/firestore_product.dart';

class ProductViewModel extends GetxController {
  late String itemId,
      userId,
      category,
      subCategory,
      city,
      location,
      productPic,
      itemName,
      description;
  late double price;

  List<ProductModel> _productList = [];

  List<ProductModel> get products => _productList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInt() {
    super.onInit();
    _getProductsFromFirestore();
  }

  void _getProductsFromFirestore() async {
    _isLoading = true;
    _productList = [];
    List<QueryDocumentSnapshot> _productsSnapshot =
        await FireStoreProduct().getProductsFromFirestore();
    _productsSnapshot.forEach((product) {
      _productList
          .add(ProductModel.fromJson(product.data() as Map<String, dynamic>));
    });
    _isLoading = false;
    update();
  }

  void addProduct() async {
    await FireStoreProduct().addProductToFireStore(ProductModel(
      itemId: itemId,
      userId: userId,
      category: category,
      subCategory: subCategory,
      city: city,
      location: location,
      productPic: productPic,
      itemName: itemName,
      description: description,
      price: price,
    ));
    Get.back();
    _getProductsFromFirestore();
  }
}
