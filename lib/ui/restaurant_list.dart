import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/common/provider/restaurant_provider.dart';
import 'package:submission_1/common/provider/result_state.dart';
import 'package:submission_1/ui/platform/platform_widget.dart';

import '../widget/card_restaurant.dart';

class RestaurantList extends StatelessWidget {
  final titleTextStyle = const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      fontFamily: 'LibreBaskerville');

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Column(children: [
            const SizedBox(height: 60),
            const Icon(
              Icons.signal_cellular_nodata_rounded,
              size: 200,
              color: Colors.grey,
            ),
            Center(
              child: Text(state.message,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  )),
            )
          ]);
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 25),
                  child: Text(
                    'Restaurant',
                    style: titleTextStyle,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 18, top: 10, bottom: 20),
                  child: Text(
                    'Recommendation restaurant for you!',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            _buildList(),
          ],
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
    );
  }
}
