import 'package:cheeta/core/view_model/favorite_view_model.dart';
import 'package:cheeta/local_storage_data.dart';
import 'package:get/get.dart';

import 'core/view_model/auth_view_model.dart';
import 'core/view_model/control_view_model.dart';
import 'core/view_model/home_view_model.dart';
import 'core/view_model/product_view_model.dart';
import 'core/view_model/profile_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthViewModel>(() => AuthViewModel());
    Get.lazyPut<ControlViewModel>(() => ControlViewModel());
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());
    Get.lazyPut<ProductViewModel>(() => ProductViewModel());
    Get.lazyPut<ProfileViewModel>(() => ProfileViewModel());
    Get.lazyPut<FavoriteViewModel>(() => FavoriteViewModel());
    Get.lazyPut<LocalStorageData>(() => LocalStorageData());
  }
}
