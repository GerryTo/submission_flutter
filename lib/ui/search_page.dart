import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/api/api_service.dart';
import 'package:submission_1/provider/search_restaurant.dart';
import 'package:submission_1/widget/card_search.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final titleTextStyle = TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      fontFamily: 'LibreBaskerville');

  String dataSearch = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (_) => SearchProvider(apiService: ApiService(), name: dataSearch),
      child: Consumer<SearchProvider>(
        builder: (context, state, _) {
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
                            'Search',
                            style: titleTextStyle,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 18, top: 10, bottom: 20),
                          child: Text(
                            'what restaurant are you looking for ?',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      2, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 0),
                              child: TextField(
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.black),
                                ),
                                onSubmitted: (value) {
                                  setState(() {
                                    dataSearch = value;
                                    state.searchRestaurants(value);
                                    ViewList(state);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    if (dataSearch.isEmpty)
                      Center(
                          child: Column(
                        children: const [
                          SizedBox(height: 60),
                          Icon(Icons.search, color: Colors.grey, size: 200),
                          Text(
                            "Find your Restaurant",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ))
                    else
                      ViewList(state)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget ViewList(SearchProvider state) {
  if (state.state == ResultState.Loading) {
    return Center(child: CircularProgressIndicator());
  } else if (state.state == ResultState.HasData) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: state.result.restaurants.length,
      itemBuilder: (context, index) {
        return CardSearch(restaurant: state.result.restaurants[index]);
      },
    );
  } else if (state.state == ResultState.NoData) {
    return Center(
        child: Column(
      children: [
        SizedBox(height: 60),
        Icon(Icons.search_off_outlined, color: Colors.grey, size: 200),
        Text(
          "We cannot find any restaurant for you",
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
        ),
      ],
    ));
  } else if (state.state == ResultState.Error) {
    return Column(children: [
      SizedBox(height: 60),
      Icon(
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
}
