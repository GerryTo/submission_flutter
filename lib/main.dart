

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_1/common/utils/navigator.dart';
import 'package:submission_1/common/utils/preferences_helper.dart';
import 'package:submission_1/resources/db/database_helper.dart';
import 'package:submission_1/ui/restaurant_detail.dart';
import 'package:submission_1/ui/search_page.dart';
import 'common/provider/database_provider.dart';
import 'common/provider/preferences_provider.dart';
import 'common/provider/restaurant_provider.dart';
import 'common/provider/scheduling_provider.dart';
import 'common/services/api_service.dart';
import 'common/utils/background_service.dart..dart';
import 'common/utils/notification_helper.dart';
import 'ui/home_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();


    await AndroidAlarmManager.initialize();

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider( create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
      ],
      child: MaterialApp(
        title: 'Restaurant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: navigatorKey,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          SearchPage.routeName: (context) => SearchPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              )
        },
      ),
    );
  }
}
