import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cheeta/view/product/add_product_view.dart';
import 'package:cheeta/core/view_model/product_view_model.dart';
import 'package:cheeta/model/product_model.dart';

class MenProductsView extends StatelessWidget {
  final List<ProductModel> product;

  MenProductsView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Products",
          ),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(product[index].itemId),
            );
          },
          itemCount: product.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
            );
          },
        ));
  }
}
