import 'package:flutter/material.dart';
import 'package:submission_1/restaurant.dart';
import 'package:submission_1/restaurant_detail.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.routeName,
      routes: {
          HomePage.routeName:(context)=> HomePage(),
          RestaurantDetailPage.routeName:(context) => RestaurantDetailPage(
              restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
          )
      },
    );
  }
}


