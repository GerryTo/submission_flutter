import 'package:flutter/material.dart';
import 'package:submission_1/common/utils/notification_helper.dart';
import 'package:submission_1/ui/platform/platform_widget.dart';
import 'package:submission_1/ui/restaurant_detail.dart';
import 'package:submission_1/ui/restaurant_list.dart';
import 'package:submission_1/ui/search_page.dart';
import 'package:submission_1/ui/setting_page.dart';

import 'Favorite_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  final NotificationHelper _notificationHelper = NotificationHelper();

  List<Widget> _listWidget = [
    RestaurantList(),
    SearchPage(),
    FavoritePage(),
    SettingsPage(),
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        body: _listWidget[_bottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.public, color: Colors.black),
              label: 'Restaurant',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.black),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.black),
              label: 'Setting',
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
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
    );
  }
}
