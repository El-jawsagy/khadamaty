import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:khadamaty/main_screen/profile/user.dart';
import 'package:khadamaty/utilities/SimilarWidgets.dart';
import 'package:khadamaty/utilities/api_paths.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  Future<String> logIn(
      BuildContext context, String email, String password) async {
    String url = ApiPaths.login;
    Map<String, dynamic> user = {'email': email, 'password': password};
    var response = await http.post(url, body: user);
    if (response.statusCode == 200) {
      try {
        var json = jsonDecode(response.body);
        var data = json['data'];
        if (data.toString().length > 50) {
          await setToken(data.toString());
          await setPassword(password);
        }
        return data;
      } catch (Exception) {
        return "not found";
      }
    }
    return "not found";
  }

  Future<String> signUpAsClient({String name, String email, String password,
      String phoneNumber, int type}) async {
    String url = ApiPaths.signUp;
    Map<String, dynamic> user = {
      'name': name,
      'email': email,
      'phonenumber': phoneNumber,
      'password': password,
      'type': type.toString(),
    };
    var response = await http.post(url, body: user);
    if (response.statusCode == 200) {
      try {
        var json = jsonDecode(response.body);
        var data = json['data'];
        print(data);
        if (data.toString().length > 50) {
          await setToken(data.toString());
          await setPassword(password);
        }
        return data;
      } catch (Exception) {
        return "not found";
      }
    }
    return "not found";
  }

  Future<User> forgetPassword(BuildContext con, String email) async {
    String url = ApiPaths.updateProfile;
    Map<String, dynamic> user = {
      'email': email,
    };

    try {
      return http.post(url, body: user).then((http.Response response) {
        final String responseBody = response.body;
        Map<String, dynamic> getObject = json.decode(responseBody);

//todo:you need to change value of response below
        if (getObject['status'] == "false") {
          showDialogWidget("Your Email is wrong", con);
          return null;
        } else {
          User userGet = User.fromJson(json.decode(responseBody));

          return userGet;
        }
      });
    } catch (ex) {
      showDialogWidget("Something happened errored", con);
    }
  }

  Future<User> createAndForgetUser(
    BuildContext con,
    String password,
    token,
  ) async {
    String url = ApiPaths.updateProfile;
    Map<String, dynamic> user = {
      'token': token,
      'password': password,
    };
    try {
      return http.post(url, body: user).then((http.Response response) {
        final String responseBody = response.body;
        Map<String, dynamic> getObject = json.decode(responseBody);

        User userGet = User.fromJson(json.decode(responseBody));

        return userGet;

        //User.fromJson(json.decode(response.body));
      });
    } catch (ex) {
      showDialogWidget("Something happened errored", con);
    }
  }
}

setLanguage(bool language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('language', language);
}

setToken(String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("token", token);
}

setPassword(String password) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("userPassword", password);
}
