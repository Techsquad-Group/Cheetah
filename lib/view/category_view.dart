// ignore_for_file: must_be_immutable, unused_field

import 'package:cheeta/core/view_model/control_view_model.dart';
import 'package:cheeta/view/add_product_view.dart';
import 'package:cheeta/view/auth/login_view.dart';
import 'package:cheeta/view/product_view.dart';
import 'package:cheeta/view/widgets/custom_buttom.dart';
import 'package:cheeta/view/widgets/custom_card.dart';
import 'package:cheeta/view/widgets/custom_row_item.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:cheeta/view/widgets/custome_search_row_item.dart';
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

class CategoryView extends StatefulWidget {
  CategoryModel model;

  CategoryView({required this.model});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  bool isLatest = false;

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
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
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                          },
                        ),
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        showSearch(
                          query: value,
                          context: context,
                          delegate: MySearch(widget.model.name),
                        );
                      },
                    ),
                  ),
                ),
              ),
              //Categories
              body: Column(
                children: [
                  Row(
                    children: [
                      TextButton.icon(
                        icon: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.compare_arrows,
                              size: 28, color: Colors.black),
                        ),
                        label: Text(
                          isLatest ? 'By Low Price' : 'By Latest',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        onPressed: () => setState(() => isLatest = !isLatest),
                      ),
                    ],
                  ),
                  Expanded(child: _listViewProducts()),
                  //Expanded(child: _listViewProductsByPrice()),
                ],
              ),
              //bottom navigation bar
            ),
    );
  }

  Widget _listViewProducts() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.productModel.length,
          itemBuilder: (context, index) {
            isLatest
                ? controller.productModel.sort(
                    (a, b) => a.price.toString().compareTo(b.price.toString()))
                : controller.productModel.sort(
                    (a, b) => b.date.toString().compareTo(a.date.toString()));
            String name = controller.productModel[index].name!;
            String image = controller.productModel[index].image!;
            String price = controller.productModel[index].price!;
            String date = controller.productModel[index].date!;
            bool isExict = false;

            for (var i = 0; i < controller.categoryModel.length; i++) {
              if (controller.productModel[index].category!.toLowerCase() ==
                  controller.categoryModel[i].name!.toLowerCase()) {
                isExict = true;
                break;
              }
            }

            if (controller.productModel[index].category!.toLowerCase() ==
                    widget.model.name!.toLowerCase() ||
                !isExict && widget.model.name == "Others") {
              return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductView(
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
        ),
      ),
    );
  }
}

class MySearch extends SearchDelegate {
  String? modelName;

  MySearch(String? modelName) {
    this.modelName = modelName;
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back),
      );

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: Icon(Icons.clear),
        )
      ];

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.productModel.length,
          itemBuilder: (context, index) {
            if (controller.productModel[index].category!.toLowerCase() ==
                modelName!.toLowerCase()) {
              if (controller.productModel[index].name!
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  controller.productModel[index].city!
                      .toLowerCase()
                      .contains(query.toLowerCase())) {
                String category = controller.productModel[index].category!;
                String name = controller.productModel[index].name!;
                String image = controller.productModel[index].image!;

                return GestureDetector(
                    onTap: () {
                      Get.to(() => ProductView(
                            model: controller.productModel[index],
                          ));
                    },
                    child: CustomSearchRowItem(
                      topText: category,
                      midText: name,
                      image: image,
                    ));
              }
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
