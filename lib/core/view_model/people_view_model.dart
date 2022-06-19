import 'package:cheeta/local_storage_data.dart';
import 'package:cheeta/view/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

import '../../model/product_model.dart';
import '../../model/user_model.dart';
import '../services/firestore_people.dart';
import '../services/firestore_product.dart';

class PeopleViewModel extends GetxController {
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<UserModel> _userModel = [];
  List<UserModel> get userModel => _userModel;

  UserModel _singleUserModel = new UserModel();
  UserModel get singleUserModel => _singleUserModel;

  PeopleViewModel() {
    getPeople();
  }

  getPeople() async {
    _loading.value = true;
    FireStorePeople().getPeople().then((value) {
      for (int i = 0; i < value.length; i++) {
        _userModel
            .add(UserModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
        _loading.value = false;
      }
      update();
    });
  }

  getSpecificUser(String sellerId) async {
    _loading.value = true;
    FireStorePeople().getSpecificUser(sellerId).then((value) {
      _singleUserModel =
          UserModel.fromJson(value.data() as Map<dynamic, dynamic>);
      _loading.value = false;
      update();
    });
  }
}
