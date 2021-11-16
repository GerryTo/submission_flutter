import 'package:flutter/cupertino.dart';
import 'package:submission_1/model/search_restaurant.dart';

import '../api/api_service.dart';

enum ResultState { Loading, NoData, HasData, Error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  late SearchResult _searchResult;
  late ResultState _state;
  String _message = '';
  String name;

  SearchProvider({required this.apiService, required this.name}) {
    _fetchAllSearch(name);
  }

  String get message => _message;

  SearchResult get result => _searchResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllSearch(String name) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(name);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Upssss...No connection here!';
    }
  }

  void searchRestaurants(String name) {
    notifyListeners();
    _fetchAllSearch(name);
  }
}
