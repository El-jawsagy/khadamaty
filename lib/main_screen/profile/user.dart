import 'package:khadamaty/main_screen/service.dart';

class User {
  String token,
      name,
      username,
      email,
      about,
      phoneNumber,
      imageProfile,
      address;
  bool isAdmin;
  int id, type, service_id;
  List<String> images;
  Service service;

  User(
      this.token,
      this.name,
      this.id,
      this.username,
      this.email,
      this.about,
      this.phoneNumber,
      this.imageProfile,
      this.address,
      this.isAdmin,
      this.type,
      this.service_id,
      this.images,
      this.service);

  User.fromJson(Map<String, dynamic> jsonObject) {
    this.name = jsonObject['name'];
    this.id = jsonObject['id'];
    this.email = jsonObject['email'];
    this.username = jsonObject['username'];
    this.about = jsonObject['about'];
    this.address = jsonObject['address'];
    this.isAdmin = jsonObject['isAdmin'];
    this.service_id = jsonObject['service_id'];
    this.phoneNumber = jsonObject['phonenumber'];
    this.type = jsonObject['type'];
    this.imageProfile = jsonObject['image'];
  }

  List<String> getImages(List<Map<String, dynamic>> jsonObject) {
    List<String> imageFromJson = [];
    for (var i in jsonObject) {
      imageFromJson.add(i["image"]);
    }
    return imageFromJson;
  }

  static Map<String, String> userHeader(String token) {
    return {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
  }
}
