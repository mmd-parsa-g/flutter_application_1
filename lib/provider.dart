import 'package:flutter/material.dart';

enum Themedata { dark, light }

class Myprovider extends ChangeNotifier {
  var theme = Themedata.light;
  setTheme(Themedata thm) {
    theme = thm;
    notifyListeners();
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = ThemeData.dark();

  ThemeData get theme => _theme;

  void toggleTheme() {
    final isdark = _theme == ThemeData.light();
    if (isdark) {
      _theme = ThemeData.light();
    } else {
      _theme = ThemeData.dark();
    }
    notifyListeners();
  }
}
