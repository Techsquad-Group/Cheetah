// ignore_for_file: must_be_immutable, unused_field

import 'package:cheeta/core/view_model/control_view_model.dart';
import 'package:cheeta/view/add_product_view.dart';
import 'package:cheeta/view/auth/login_view.dart';
import 'package:cheeta/view/product_view.dart';
import 'package:cheeta/view/widgets/custom_card.dart';
import 'package:cheeta/view/widgets/custom_row_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../constance.dart';
import '../../core/view_model/home_view_model.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';

class CategoryView extends StatelessWidget {
  CategoryModel model;

  CategoryView({required this.model});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        builder: (controller) => controller.loading.value
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: AppBar(
                  //title: const Text('Welcome', style: TextStyle(color: Colors.black)),
                  backgroundColor: Colors.transparent,
                  bottomOpacity: 0.0,
                  elevation: 0.0,
                  toolbarHeight: 80,
                  //SearchBar
                  title: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                /* Clear the search field */
                              },
                            ),
                            hintText: 'Search',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                //Categories
                body: _listViewProducts()
                //bottom navigation bar
                ));
  }

  Widget _listViewProducts() {
    return GetBuilder<HomeViewModel>(
        builder: (controller) => SingleChildScrollView(
                child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.productModel.length,
              itemBuilder: (context, index) {
                if (controller.productModel[index].category == model.name) {
                  String name = controller.productModel[index].name!;
                  String image = controller.productModel[index].image!;
                  String price = controller.productModel[index].price!;
                  String date = controller.productModel[index].date!;

                  return GestureDetector(
                      onTap: () {
                        Get.to(ProductView(
                          model: controller.productModel[index],
                        ));
                      },
                      child: CustomRowItem(
                        text: name,
                        image: image,
                        price: price,
                        date: date,
                      ));
                }
                return SizedBox.shrink();
              },
            )));
  }
}
