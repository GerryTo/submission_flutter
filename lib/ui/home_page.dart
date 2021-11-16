
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/platform/platform_widget.dart';
import 'package:submission_1/ui/restaurant_list.dart';
import 'package:submission_1/ui/search_page.dart';

import '../api/api_service.dart';
import '../provider/restaurant_provider.dart';
import 'Favorite_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: RestaurantList(),
    ),
    SearchPage(),
    FavoritePage(),
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        body: _listWidget[_bottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Restaurant',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
          ],
          onTap: (selected) {
            setState(() {
              _bottomNavIndex = selected;
            });
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
    );
  }
}
