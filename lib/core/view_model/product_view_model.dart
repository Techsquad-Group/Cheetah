import 'package:cheeta/local_storage_data.dart';
import 'package:cheeta/view/profile_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../../model/product_model.dart';
import '../services/firestore_product.dart';

class ProductViewModel extends GetxController {
  String currentDate = new DateFormat('yyyy-MM-dd').format(new DateTime.now());

  ProductModel _productModel = new ProductModel();
  ProductModel get productModel => _productModel;

  late String name = "",
      image = "",
      price = "",
      city = "",
      location = "",
      description = "",
      date = currentDate,
      seller = "",
      sellerId = "",
      sellerImg = "",
      sellerNum = "",
      category = "",
      productId = "";

  void onInit() {
    super.onInit();
  }

  void saveProduct() async {
    _productModel = ProductModel(
      name: name,
      image: image,
      price: price,
      city: city,
      location: location,
      description: description,
      date: date,
      seller: seller,
      sellerId: sellerId,
      sellerImg: sellerImg,
      sellerNum: sellerNum,
      category: category,
      productId: productId,
    );
    await FireStoreProduct().addProductToFireStore(productModel).then((value) {
      value.update({
        'productId': value.id,
      });
    });
    update();
  }
}
