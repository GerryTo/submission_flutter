import 'package:flutter/cupertino.dart';
import 'package:submission_1/common/provider/result_state.dart';
import 'package:submission_1/resources/db/database_helper.dart';
import 'package:submission_1/resources/model/restaurant.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper});

  ResultState _state = ResultState.NoData;

  ResultState get state => _state;

  String _message = 'You don\'t have your favorite restaurant yet';

  String get message => _message;

  List<Restaurant> _restaurant = [];

  List<Restaurant> get restaurant => _restaurant;

  void _getFavorites() async {
    _restaurant = await databaseHelper.getFavorite();
    if (_restaurant.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'You don\'t have your favorite restaurant yet';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final FavoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return FavoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
