/*
 * Copyright (c) 2021, Nikhila (Nikki) Suneel. All Rights Reserved.
 */

import 'package:flutter/material.dart';

import 'data_trends_page.dart';
import 'custom_app_bar.dart';
import 'bottom_navigator.dart';

class ChartOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
              "Chart Options",
              true
          ),
          body: _options(context),
          bottomNavigationBar: BottomNavigator(),
        )
    );
  }

  Widget _options(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: FlatButton(
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Icon(Icons.bar_chart_sharp, size: 100)
                  ),
                  Text("Monthly", style: Theme.of(context).textTheme.headline4),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataTrendsPage(0)
                    )
                );
              }
          ),
        ),
        Center(
          child: FlatButton(
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Icon(Icons.bar_chart_sharp, size: 100)
                  ),
                  Text("Daily", style: Theme.of(context).textTheme.headline4),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataTrendsPage(1)
                    )
                );
              }
          ),
        ),
      ],
    );
  }
}