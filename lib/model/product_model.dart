class ProductModel {
  late String itemId,
      userId,
      category,
      subCategory,
      city,
      location,
      productPic,
      itemName,
      description;
  late double? price;

  ProductModel(
      {required this.itemId,
      required this.userId,
      required this.category,
      required this.subCategory,
      required this.city,
      required this.location,
      required this.productPic,
      required this.price,
      required this.itemName,
      required this.description});

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    itemId = map['itemId'];
    userId = map['userId'];
    category = map['category'];
    subCategory = map['subCategory'];
    city = map['city'];
    location = map['location'];
    productPic = map['productPic'];
    price = map['price'];
    itemName = map['itemName'];
    description = map['description'];
  }

  toJson() {
    return {
      'itemId': itemId,
      'userId': userId,
      'category': category,
      'subCategory': subCategory,
      'city': city,
      'location': location,
      'productPic': productPic,
      'price': price,
      'itemName': itemName,
      'description': description
    };
  }
}
