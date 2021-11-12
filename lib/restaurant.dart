import 'dart:convert';

class Restaurant{
  late String id;
  late String name;
  late String desc;
  late String pictureId;
  late String city;
  late num rating;
  late Menu menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.desc,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menu
  });

  Restaurant.fromJson(Map<String, dynamic>json){
    id = json['id'];
    name = json['name'];
    desc = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'];
    menu = Menu.fromJson(json['menus']);
  }
}

class Menu {
  List<Foods> foods;
  List<Drinks> drinks;

  Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> menus) => Menu(
    foods: List<Foods>.from(menus['foods'].map((x) => Foods.fromJson(x))),
    drinks:
    List<Drinks>.from(menus['drinks'].map((x) => Drinks.fromJson(x))),
  );
}

class Drinks {
  late String name;
  Drinks({required this.name});

  Drinks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class Foods {
  late String name;
  Foods({required this.name});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed =jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}


