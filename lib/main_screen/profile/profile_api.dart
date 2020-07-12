import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:khadamaty/main_screen/profile/user.dart';
import 'package:khadamaty/utilities/api_paths.dart';
import 'package:khadamaty/utilities/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  //todo: is finished
  Future<User> fetchUser() async {
    String URL = ApiPaths.userDetails;
    String token = await Preference.getToken();

    http.Response response =
        await http.get(URL, headers: User.userHeader(token));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      User user = User.fromJson(data["data"]);
      SharedPreferences pref =await SharedPreferences.getInstance();
      await pref.setInt("userId", user.id);
      await pref.setString("userName", user.name);
      await pref.setString("userImage", user.imageProfile);
      await pref.setString("userPhone", user.phoneNumber);
      return user;
    }
    return null;
  }
}


