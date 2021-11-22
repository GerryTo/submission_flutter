import 'package:flutter/cupertino.dart';
import 'package:submission_1/common/utils/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantPreferences();
  }

  bool _isDailyRestaurantActive = false;

  bool get isDailyRestaurantActive => _isDailyRestaurantActive;

  void _getDailyRestaurantPreferences() async {
    _isDailyRestaurantActive = await preferencesHelper.isDailyNewsActive;
    notifyListeners();
  }

  void enableRestaurantNews(bool value) {
    preferencesHelper.setDailyNews(value);
    _getDailyRestaurantPreferences();
  }
}
