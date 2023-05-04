// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:zenmind/DB/SharedPereference.dart';

//URL
const svgAssetsLocation = "Assets/Picture/Svg/";

//Size
class GetSizeScreen {
  double width(context) {
    return MediaQuery.of(context).size.width;
  }

  double height(context) {
    return MediaQuery.of(context).size.height;
  }

  double paddingScreen = 20;
}

//Theme

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  ThemePreferences preferences = ThemePreferences();
  bool get isDark => _isDark;

  ThemeModel() {
    getPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await preferences.getTheme();
    notifyListeners();
  }
}

class GetTheme {
  Color primaryColor(context) {
    return Theme.of(context).primaryColor;
  }

  Color buttonColor(context) {
    return Theme.of(context).buttonColor;
  }

  Color cardColors(context) {
    return Theme.of(context).cardColor;
  }

  Color accentCardColors(context) {
    return Theme.of(context).colorScheme.background;
  }

  Color backgroundGrey(context) {
    return Theme.of(context).hoverColor;
  }

  Color unselectedWidget(context) {
    return Theme.of(context).unselectedWidgetColor;
  }

  // Color backgroundColorsLight = Color(0xff426E92);
  Color secondColor = const Color(0xff426E92);
  Color thirdColor = const Color(0xff369B92);
  Color secondaryButtonColors = const Color(0xff42CCC9);
  Color buttonColors = const Color(0xff42CCC9);

  MaterialColor themeColor = MaterialColor(
    const Color.fromARGB(255, 62, 218, 216).value,
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
