import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khadamaty/main_screen/profile/user.dart';
import 'package:khadamaty/utilities/api_paths.dart';
import 'package:khadamaty/utilities/preferences.dart';

Future<String> makeOrder(int serviceId, userId) async {
  String token = await Preference.getToken();
  int id = await Preference.getUserId();

  String url = ApiPaths.makeOrder;

  Map<String, dynamic> bodyData = {
    "user_id": id.toString(),
    "client_id": userId.toString(),
  };
  http.Response response =
      await http.post(url, body: bodyData, headers: User.userHeader(token));
  print(response.body);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    return data['data'];
  }
  return 'not complete';
}
