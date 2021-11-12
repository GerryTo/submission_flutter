import 'package:flutter/material.dart';
import 'package:submission_1/restaurant.dart';
import 'package:share/share.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  var titleTextStyle = TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Quicksand');
  var descriptionTextStyle = TextStyle(fontSize: 14, fontFamily: 'Quicksand');
  final Restaurant restaurant;

  RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 220,
                      backgroundColor: Color.fromRGBO(0, 0, 0, 0.2),
                      flexibleSpace: FlexibleSpaceBar(
                        background:Hero(
                          tag: restaurant.pictureId,
                          child: Image.network(
                            restaurant.pictureId,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              restaurant.name,
                              style: titleTextStyle,
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.blue,
                                ),
                                onPressed: (){
                                  Share.share('${restaurant.name}\n${restaurant.city}\n\n${restaurant.desc}',
                                      subject:"Want share?"
                                  );
                                }
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              restaurant.city,
                              style: descriptionTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  'Deskripsi',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  restaurant.desc,
                                  style: descriptionTextStyle,
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  'Menu :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'LibreBaskerville'),
                                ),
                                SizedBox(height: 15),
                                Table(
                                  columnWidths: {1: FractionColumnWidth(0.5)},
                                  children: [
                                    TableRow(children: [
                                      Column(children: [
                                        Text('Foods',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'LibreBaskerville'))
                                      ]),
                                      Column(children: [
                                        Text('Drinks',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'LibreBaskerville'))
                                      ]),
                                    ]),
                                    TableRow(children: [
                                      Column(children: [
                                        _foodsData(
                                            context, restaurant.menu.foods)
                                      ]),
                                      Column(children: [
                                        _drinksData(
                                            context, restaurant.menu.drinks)
                                      ]),
                                    ]),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }

  Widget _foodsData(BuildContext context, List<Foods> foods) {
    List<Widget> text = [];
    int num = 1;

    for (var foods in foods) {
      text.add(const SizedBox(
        height: 5,
      ));
      text.add(Text('$num. ${foods.name}',
          style: TextStyle(fontFamily: 'LibreBaskerville')));
      num++;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: text,
    );
  }

  Widget _drinksData(BuildContext context, List<Drinks> drinks) {
    List<Widget> text = [];
    int num = 1;

    for (var drinks in drinks) {
      text.add(const SizedBox(
        height: 5,
      ));
      text.add(Text('$num. ${drinks.name}',
          style: TextStyle(fontFamily: 'LibreBaskerville')));
      num++;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: text,
    );
  }
}
