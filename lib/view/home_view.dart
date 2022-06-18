// ignore_for_file: must_be_immutable, unused_field

import 'package:cheeta/core/view_model/control_view_model.dart';
import 'package:cheeta/model/category_model.dart';
import 'package:cheeta/view/add_product_view.dart';
import 'package:cheeta/view/auth/login_view.dart';
import 'package:cheeta/view/control_view.dart';
import 'package:cheeta/view/widgets/custom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../constance.dart';
import '../core/view_model/home_view_model.dart';
import 'category_view.dart';
import 'product_view.dart';
import 'widgets/custom_row_item.dart';
import 'widgets/custom_text.dart';
import 'widgets/custome_search_row_item.dart';

class HomeView extends StatelessWidget {
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
                            delegate: MySearch(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                //Categories
                body: _listViewCategories()
                //bottom navigation bar
                ));
  }

  Widget _listViewCategories() {
    return GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (controller) => SingleChildScrollView(
              child: StaggeredGridView.countBuilder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.categoryModel.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    CategoryModel model = controller.categoryModel[index];

                    String name = controller.categoryModel[index].name ?? '';
                    String image = controller.categoryModel[index].image ?? '';

                    return GetBuilder<ControlViewModel>(
                        init: ControlViewModel(),
                        builder: (controller) => InkWell(
                            onTap: () {
                              controller.goToCategoryPage(CategoryView(
                                model: model,
                              ));
                            },
                            child: CustomCard(
                              text: name,
                              image: image,
                            )));
                  },
                  staggeredTileBuilder: (context) =>
                      const StaggeredTile.fit(1)),
            ));
  }
}

class MySearch extends SearchDelegate {
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
      builder: (controller) => SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.productModel.length,
          itemBuilder: (context, index) {
            if (controller.productModel[index].name!
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
                    category: category,
                    text: name,
                    image: image,
                  ));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
