/*
 * Copyright (c) 2021, Nikhila (Nikki) Suneel. All Rights Reserved.
 */

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'custom_app_bar.dart';
import 'application_objects.dart';
import 'client_apis.dart';
import 'bottom_navigator.dart';

class DataTrendsPage extends StatefulWidget {
  final int selectedChartOption;

  DataTrendsPage(this.selectedChartOption);

  @override
  _DataTrendsPageState createState() => _DataTrendsPageState();
}

class _DataTrendsPageState extends State<DataTrendsPage> {

  @override
  Widget build(BuildContext context) {
    List<WidgetOptions> _chartOptions = <WidgetOptions> [
      new WidgetOptions(_monthlyChart(context), "Monthly Charts"),
      new WidgetOptions(_dailyChart(context), "Daily Charts"),
    ];

    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
              _chartOptions.elementAt(widget.selectedChartOption).title,
              true
          ),
          body: _chartOptions.elementAt(widget.selectedChartOption).widget,
          bottomNavigationBar: BottomNavigator(),
        )
    );
  }

  Widget _monthlyChart(BuildContext context) {
    return FutureBuilder<DataTrendObject>(
      future: getTrends(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the form for activity.
          return _drawCharts(context, snapshot.data.monthly);
        } else {
          // Otherwise, display a loading indicator.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _dailyChart(BuildContext context) {
    return FutureBuilder<DataTrendObject>(
      future: getTrends(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the form for activity.
          return _drawCharts(context, snapshot.data.daily);
        } else {
          // Otherwise, display a loading indicator.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _drawCharts(BuildContext context, TrendData data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("# of Golf Balls Picked", style: Theme.of(context).textTheme.headline5),
          Expanded(
            child: Container(
              child: new charts.BarChart(
                createBallSeriesData(data.ballCountData),
                animate: false,
              ),
            ),
          ),
          Text("Activity minutes", style: Theme.of(context).textTheme.headline5),
          Expanded(
            child: Container(
              child: new charts.BarChart(
                createActivitySeriesData(data.activityTimeData),
                animate: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<GolfBallTrend, String>> createBallSeriesData(Map<String, int> golfBallData ) {
    List<GolfBallTrend> golfBallSeriesData = new List();
    golfBallData.forEach((k,v) {
      golfBallSeriesData.add(new GolfBallTrend(k, v));
    });

    return [
      new charts.Series<GolfBallTrend, String>(
        id: '# of Golf Balls',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (GolfBallTrend data, _) => data.key,
        measureFn: (GolfBallTrend data, _) => data.ballCount,
        data: golfBallSeriesData,
      )
    ];
  }

  static List<charts.Series<BallPickingActivityTrend, String>> createActivitySeriesData(Map<String, int> activityData ) {
    List<BallPickingActivityTrend> activitySeriesData = new List();
    activityData.forEach((k,v) {
      activitySeriesData.add(new BallPickingActivityTrend(k, v));
    });

    return [
      new charts.Series<BallPickingActivityTrend, String>(
        id: '# of Activity minutes',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (BallPickingActivityTrend data, _) => data.key,
        measureFn: (BallPickingActivityTrend data, _) => data.activityTime,
        data: activitySeriesData,
      )
    ];
  }
}