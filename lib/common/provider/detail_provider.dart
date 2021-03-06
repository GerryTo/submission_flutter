import 'package:flutter/cupertino.dart';
import 'package:submission_1/common/provider/result_state.dart';
import 'package:submission_1/common/services/api_service.dart';
import 'package:submission_1/resources/model/restaurant_detail.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailProvider({required this.id, required this.apiService}) {
    _fetchAllRestaurantDetail(id);
  }

  late RestaurantDetailResult _restaurantResultDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResult get result => _restaurantResultDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurantDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantDetail = await apiService.restaurantDetail(id);
      if (restaurantDetail.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResultDetail = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Upssss...No connection here!';
    }
  }
}
