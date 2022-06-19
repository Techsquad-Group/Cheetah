class UserModel {
  String? userId, pic, number, email, name, registeredWith;

  UserModel(
      {this.userId,
      this.email,
      this.name,
      this.pic,
      this.number,
      this.registeredWith});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
    pic = map['pic'];
    number = map['number'];
    registeredWith = map['registeredWith'];
  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'pic': pic,
      'number': number,
      'registeredWith': registeredWith,
    };
  }
}
