// ignore_for_file: file_names, camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:zenmind/Main/DB/SharedPereference.dart';

//URL
const svgAssetsLocation = "Assets/Picture/Svg/";

//Size
class getSizeScreen {
  double width(context) {
    return MediaQuery.of(context).size.width;
  }

  double height(context) {
    return MediaQuery.of(context).size.height;
  }
}

//Theme

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  ThemePreferences _preferences = ThemePreferences();
  bool get isDark => _isDark;

  ThemeModel() {
    getPreferences();
  }
//Switching themes in the flutter apps - Flutterant
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}

class getTheme {
  Color primaryColor(context) {
    return Theme.of(context).primaryColor;
  }

  Color cardColors(context) {
    return Theme.of(context).cardColor;
  }

  Color textColors(context) {
    return Theme.of(context).unselectedWidgetColor;
  }

  // Color backgroundColorsLight = Color(0xff426E92);
  Color secondaryColor = Color(0xff426E92);

  MaterialColor themeColor = MaterialColor(
    Color.fromARGB(255, 62, 218, 216).value,
    const <int, Color>{
      50: Color.fromRGBO(62, 218, 216, 0.1),
      100: Color.fromRGBO(62, 218, 216, 0.2),
      200: Color.fromRGBO(62, 218, 216, 0.3),
      300: Color.fromRGBO(62, 218, 216, 0.4),
      400: Color.fromRGBO(62, 218, 216, 0.5),
      500: Color.fromRGBO(62, 218, 216, 0.6),
      600: Color.fromRGBO(62, 218, 216, 0.7),
      700: Color.fromRGBO(62, 218, 216, 0.8),
      800: Color.fromRGBO(62, 218, 216, 0.9),
      900: Color.fromRGBO(62, 218, 216, 1),
    },
  );
}
