// ignore_for_file: must_be_immutable, unused_field

import 'package:cheeta/core/view_model/control_view_model.dart';
import 'package:cheeta/model/category_model.dart';
import 'package:cheeta/view/add_product_view.dart';
import 'package:cheeta/view/auth/login_view.dart';
import 'package:cheeta/view/control_view.dart';
import 'package:cheeta/view/online_profile_view.dart';
import 'package:cheeta/view/widgets/custom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../constance.dart';
import '../core/view_model/home_view_model.dart';
import '../core/view_model/people_view_model.dart';
import 'category_view.dart';
import 'product_view.dart';
import 'widgets/custom_row_item.dart';
import 'widgets/custom_text.dart';
import 'widgets/custome_search_row_item.dart';

class SearchView extends StatelessWidget {
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
                          hintText: 'Search for people',
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
                //bottom navigation bar
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
    return GetBuilder<PeopleViewModel>(
      init: PeopleViewModel(),
      builder: (controller) => SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.userModel.length,
          itemBuilder: (context, index) {
            if (controller.userModel[index].name!
                .toLowerCase()
                .contains(query.toLowerCase())) {
              String name = controller.userModel[index].name ?? '';
              String email = controller.userModel[index].email ?? '';
              String pic = controller.userModel[index].pic ?? '';

              return GestureDetector(
                  onTap: () {
                    Get.to(() => OnlineProfileView(
                          userModel: controller.userModel[index],
                        ));
                  },
                  child: CustomSearchRowItem(
                    topText: name,
                    midText: email,
                    image: pic,
                  ));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
