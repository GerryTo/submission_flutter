import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/common/provider/preferences_provider.dart';
import 'package:submission_1/common/provider/scheduling_provider.dart';
import 'package:submission_1/ui/platform/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  final titleTextStyle = const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      fontFamily: 'LibreBaskerville');
  static const String settingsTitle = 'Settings';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, top: 25),
                child: Text(
                  'Settings',
                  style: titleTextStyle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18, top: 10, bottom: 20),
                child: Text(
                  'Setting your apps like you want',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          _buildList(context),
        ],
      )),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Material(
          child: ListTile(
            title: Text('Scheduling News'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: provider.isDailyRestaurantActive,
                  onChanged: (value) async {
                    scheduled.scheduledNews(value);
                    provider.enableRestaurantNews(value);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
    );
  }
}
