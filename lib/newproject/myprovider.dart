import 'package:flutter/material.dart';

enum Themedata { dark, light }

class Myprovider extends ChangeNotifier {
  var theme = Themedata.light;
  setTheme(Themedata thm) {
    theme = thm;
    notifyListeners();
  }
}
