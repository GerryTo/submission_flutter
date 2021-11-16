import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  final titleTextStyle = const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      fontFamily: 'LibreBaskerville');

  @override
  Widget build(BuildContext context) {
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
                    'This is your favorite restourant',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Center(
                  child: Text(
                "Coming soon ....",
                style: TextStyle(fontSize: 18),
              )),
            )
          ],
        ),
      )),
    );
  }
}
