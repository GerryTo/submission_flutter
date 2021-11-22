import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_1/resources/model/search_restaurant.dart';
import 'package:submission_1/ui/restaurant_detail.dart';

class CardSearch extends StatelessWidget {
  final SearchRestaurant restaurant;
  final subtitleTextStyle =
      const TextStyle(fontSize: 14, fontFamily: 'Quicksand');

  CardSearch({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
              "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
              width: 100,
              fit: BoxFit.fill),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(restaurant.name,
              style: const TextStyle(
                  fontFamily: 'Quicksand', fontWeight: FontWeight.w600)),
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
        onTap: () => Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurant.id,
        ),
      ),
    );
  }
}
