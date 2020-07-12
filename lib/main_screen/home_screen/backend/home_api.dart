import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khadamaty/main_screen/profile/user.dart';
import 'package:khadamaty/main_screen/service.dart';
import 'package:khadamaty/utilities/api_paths.dart';
import 'package:khadamaty/utilities/preferences.dart';

class HomeScreenApi {
  //todo: is finished
  Future<List<User>> fetchUsers() async {
    String URL = ApiPaths.randomUsers;
    String token = await Preference.getToken();

    http.Response response =
        await http.get(URL, headers: User.userHeader(token));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<User> users = [];
      for (var i in data["data"]) {
        users.add(User.fromJson(i));
      }
      return users;
    }
    return null;
  }

  Future<List<Service>> fetchServices() async {
    String URL = ApiPaths.randomServices;
    String token = await Preference.getToken();

    http.Response response =
        await http.get(URL, headers: User.userHeader(token));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Service> services = [];
      for (var i in data["data"]) {
        services.add(Service.fromJson(i));
      }
      return services;
    }
    return null;
  }
}
