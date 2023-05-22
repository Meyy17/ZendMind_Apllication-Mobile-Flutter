// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  static const tokenKey = "tokenUsers";
  static const idKey = "idUsers";

  setToken(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(tokenKey, value);
  }

  setId(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(idKey, value);
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(tokenKey) ?? "";
  }

  getId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(idKey) ?? "";
  }
}
