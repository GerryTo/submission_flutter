import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/common/provider/database_provider.dart';
import 'package:submission_1/common/provider/result_state.dart';
import 'package:submission_1/ui/platform/platform_widget.dart';
import 'package:submission_1/widget/card_restaurant.dart';

class FavoritePage extends StatelessWidget {
  final titleTextStyle = const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      fontFamily: 'LibreBaskerville');

  Widget _buildAndroid(BuildContext context) {
    return Consumer(
      builder: (context, state, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 25),
                        child: Text(
                          'Favorite',
                          style: titleTextStyle,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 18, top: 10, bottom: 20),
                        child: Text(
                          'This is your favorite restourant.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  _buildList()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, state, child) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: state.restaurant.length,
            itemBuilder: (context, index) {
              return CardRestaurant(restaurant: state.restaurant[index]);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(
              child: Column(
            children: [
              SizedBox(height: 60),
              Icon(Icons.quiz_outlined, color: Colors.grey, size: 200),
              Text(
                state.message,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),
            ],
          ));
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

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
    );
  }
}
