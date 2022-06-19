import 'package:cheeta/local_storage_data.dart';
import 'package:cheeta/view/profile_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'dart:io';

import '../../model/product_model.dart';
import '../services/firestore_product.dart';

class ProductViewModel extends GetxController {
  String currentDate = new DateFormat('yyyy-MM-dd').format(new DateTime.now());

  ProductModel _productModel = new ProductModel();
  ProductModel get productModel => _productModel;

  PlatformFile? _pickedFile;
  PlatformFile get pickedFile => _pickedFile!;

  UploadTask? _uploadTask;
  UploadTask get uploadTask => _uploadTask!;

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
    uploadFile();
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

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    _pickedFile = result!.files.first;
    update();
  }

  Future uploadFile() async {
    final path = 'productImages/${pickedFile.name}';
    final file = File(pickedFile.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    _uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    image = await snapshot.ref.getDownloadURL();
    print(image);
  }
}
