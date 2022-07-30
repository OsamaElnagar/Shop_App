class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = UserData.fromJson(json['data']);
    }
  }
}

class UserData {
  dynamic id;
  String? name;
  String? email;
  String? phone;
  String? image;
  dynamic points;
  dynamic credit;
  String? token;

  // this is a named constructor used for a special purpose.
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
