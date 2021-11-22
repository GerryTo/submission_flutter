import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/common/provider/database_provider.dart';
import 'package:submission_1/common/utils/navigator.dart';
import 'package:submission_1/resources/model/restaurant.dart';
import 'package:submission_1/ui/restaurant_detail.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final subtitleTextStyle =
      const TextStyle(fontSize: 14, fontFamily: 'Quicksand');

  CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, child) {
        return FutureBuilder<bool>(
          future: state.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Material(
              color: Colors.white,
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(
                      isFavorited
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: Colors.red),
                  onPressed: () {
                    isFavorited
                        ? state.removeFavorite(restaurant.id)
                        : state.addFavorite(restaurant);
                  },
                ),
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
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600)),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              restaurant.rating.toString(),
                              style: subtitleTextStyle,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                onTap: () => Navigation.intentWithData(
                    RestaurantDetailPage.routeName, restaurant.id),
              ),
            );
          },
        );
      },
    );
  }
}
