import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:submission_1/api/api_service.dart';
import 'package:submission_1/model/restaurant_detail.dart';
import 'package:submission_1/provider/detail_provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final String id;

  RestaurantDetailPage({required this.id});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  var titleTextStyle = const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Quicksand');

  var descriptionTextStyle = const TextStyle(fontSize: 14, fontFamily: 'Quicksand');

  Widget _buildDetail() {
    return Scaffold(
      body: ChangeNotifierProvider<DetailProvider>(
        create: (_) => DetailProvider(apiService: ApiService(), id: widget.id),
        child: Consumer<DetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              var restaurant = state.result.restaurant;
              return _buildViewDetail(restaurant);
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Column(children: [
                SizedBox(height: 60),
                const Icon(
                  Icons.signal_cellular_nodata_rounded,
                  size: 200,
                  color: Colors.grey,
                ),
                Center(
                  child: Text(state.message,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      )),
                )
              ]);
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }

  Widget _buildViewDetail(RestaurantDetail restaurant) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 220,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.2),
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
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
                          onPressed: () {
                            Share.share(
                                '${restaurant.name}\n${restaurant.city}\n\n${restaurant.description}',
                                subject: "Want share?");
                          }),
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
                        '${restaurant.address}, ${restaurant.city}',
                        style: descriptionTextStyle,
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.tag_rounded,
                        size: 18,
                      ),
                      _CatergoryData(context, restaurant.categories),
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
                            restaurant.description,
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
                                fontSize: 20, fontFamily: 'LibreBaskerville'),
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
                                  _foodsData(context, restaurant.menus.foods)
                                ]),
                                Column(children: [
                                  _drinksData(context, restaurant.menus.drinks)
                                ]),
                              ]),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _foodsData(BuildContext context, List<Category> foods) {
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

  Widget _drinksData(BuildContext context, List<Category> drinks) {
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

  Widget _CatergoryData(BuildContext context, List<Category> category) {
    List<Widget> text = [];

    for (var category in category) {
      text.add(const SizedBox(
        height: 5,
      ));
      text.add(
        Card(
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text('${category.name}',
                style: TextStyle(
                    fontFamily: 'LibreBaskerville',
                    fontStyle: FontStyle.italic)),
          ),
        ),
      );
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildDetail(),
    );
  }
}
