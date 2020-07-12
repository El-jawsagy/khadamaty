import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khadamaty/main_screen/profile/user.dart';
import 'package:khadamaty/main_screen/service.dart';
import 'package:khadamaty/utilities/api_paths.dart';
import 'package:khadamaty/utilities/preferences.dart';

class TrendingScreenApi {
  Future<List<Service>> fetchAllServices() async {
    String token = await Preference.getToken();
    String url = ApiPaths.allServices;

    http.Response response =
        await http.get(url, headers: User.userHeader(token));

    List<Service> services = [];

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data["data"];
      for (var i in items) {
        services.add(Service.fromJson(i));
      }
      return services;
    }
    return null;
  }

  Future<List<User>> fetchAllServiceProviders(int id) async {
    String token = await Preference.getToken();
    String url = ApiPaths.singleService(id);
    http.Response response =
        await http.get(url, headers: User.userHeader(token));

    List<User> users = [];
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data["data"];

      for (var i in items) {
        users.add(User.fromJson(i));
      }
      if (users.isEmpty) {
        return null;
      }
      return users;
    }
    return null;
  }
}
