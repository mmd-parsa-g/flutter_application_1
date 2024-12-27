import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const pref_key = 'pref_key';

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(pref_key, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(pref_key);
  }
}
