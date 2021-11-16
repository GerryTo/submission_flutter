import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:submission_1/model/restaurant.dart';
import 'package:submission_1/model/restaurant_detail.dart';
import 'package:submission_1/model/search_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResult> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + '/list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant list');
    }
  }

  Future<RestaurantDetailResult> restaurantDetail(id) async {
    final response = await http.get(Uri.parse(_baseUrl + '/detail/' + id));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant list');
    }
  }

  Future<SearchResult> searchRestaurant(name) async {
    final response = await http.get(Uri.parse(_baseUrl + '/search?q=' + name));
    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant list');
    }
  }
}
