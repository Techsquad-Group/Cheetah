// ignore_for_file: unnecessary_null_comparison

class FavoriteModel {
  String? user, product, favoriteID;

  FavoriteModel({this.user, this.product, this.favoriteID});

  FavoriteModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    user = map['user'];
    product = map['product'];
    favoriteID = map['favoriteID'];
  }

  toJson() {
    return {
      'user': user,
      'product': product,
      'favoriteID': favoriteID,
    };
  }
}
