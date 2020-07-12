import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("userName");
    return datId;
  }

  static Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("userId");
    return datId;
  }

  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("emailPref");
    return datId;
  }

  static Future<String> getPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("passwordPref");
    return datId;
  }

  static Future<String> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("userPhone");
    print(datId);
    return datId;
  }

  static Future<bool> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isArabic = prefs.getBool('language');
    return isArabic;
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("token");
    return datId;
  }
}
