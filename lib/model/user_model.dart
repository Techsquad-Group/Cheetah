class UserModel {
  late String? userId, email, name, pic, number;

  UserModel({this.userId, this.email, this.name, this.pic, this.number});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
    pic = map['pic'];
    number = map['number'];
  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'pic': pic,
      'number': number,
    };
  }
}
