import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const DAILY_FAVORITE = 'DAILY_FAVORITE';
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isDailyNewsActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_FAVORITE) ?? false;
  }

  void setDailyNews(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_FAVORITE, value);
  }
}
