// ignore_for_file: unnecessary_null_comparison

class ProductModel {
  String? name,
      image,
      price,
      city,
      location,
      description,
      date,
      seller,
      sellerId,
      sellerImg,
      sellerNum,
      category,
      productId;

  ProductModel(
      {this.name,
      this.image,
      this.price,
      this.city,
      this.location,
      this.description,
      this.date,
      this.seller,
      this.sellerId,
      this.sellerImg,
      this.sellerNum,
      this.category,
      this.productId});

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    image = map['image'];
    price = map['price'];
    city = map['city'];
    location = map['location'];
    description = map['description'];
    date = map['date'];
    seller = map['seller'];
    sellerId = map['sellerId'];
    sellerImg = map['sellerImg'];
    sellerNum = map['sellerNum'];
    category = map['category'];
    productId = map['productId'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'city': city,
      'location': location,
      'description': description,
      'date': date,
      'seller': seller,
      'sellerId': sellerId,
      'sellerImg': sellerImg,
      'sellerNum': sellerNum,
      'category': category,
      'productId': productId,
    };
  }
}
