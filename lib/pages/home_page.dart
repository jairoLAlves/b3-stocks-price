import 'package:b3_price_stocks/routes/routes_pages.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topRight,
          child: Card(
            child: Hero(
              tag: 'searchButton',
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RoutesPages.STOCKSSEARCH);
                  },
                  icon: Icon(Icons.search)),
            ),
          ),
        ),
      ),
    );
  }
}
