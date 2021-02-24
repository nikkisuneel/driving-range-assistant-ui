import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'data_trends.dart';
import 'app_bar.dart';
import 'application_objects.dart';
import 'api_client.dart';
import 'bottom_navigator.dart';

class ChartOptions extends StatelessWidget {
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
                  Text("Monthly Chart", style: Theme.of(context).textTheme.headline4),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataTrends(0)
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
                  Text("Daily Chart", style: Theme.of(context).textTheme.headline4),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataTrends(1)
                    )
                );
              }
          ),
        ),
      ],
    );
  }
}