import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:submission_1/restaurant.dart';
import 'package:submission_1/restaurant_detail.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/restaurant_list';
  final subtitleTextStyle = TextStyle(fontSize: 14,fontFamily: 'Quicksand');
  final titleTextStyle = TextStyle(fontSize: 40, fontWeight: FontWeight.bold, fontFamily:'LibreBaskerville' );

   HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding: EdgeInsets.only(left: 18, top: 10, bottom: 20),
                    child: Text(
                      'Recommendation restaurant for you !',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/local_restaurant.json'),
                builder: (context, snapshot) {
                  final List<Restaurant> restaurant =
                  parseRestaurant(snapshot.data);
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: restaurant.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding:
                            const EdgeInsets.only(left: 10, top: 5, right: 10),
                            child: Card(
                                child: _buildRestaurantItem(
                                    context, restaurant[index])));
                      });
                },
              )
            ],
          ),
        )
    ));
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      leading: Hero(
        tag: restaurant.pictureId,
        child:Image.network(
          restaurant.pictureId,
          width: 100,
            fit: BoxFit.fill
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(restaurant.name,
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600
          )),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                restaurant.city,
                style: subtitleTextStyle,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.star, size: 14),
              const SizedBox(width: 6),
              Text(
                restaurant.rating.toString(),
                style: subtitleTextStyle,
              ),
            ],
          )
        ],
      ),
      onTap: (){
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant);
      },
    );
  }
}
