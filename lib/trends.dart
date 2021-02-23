import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'app_bar.dart';
import 'application_objects.dart';
import 'api_client.dart';
import 'bottom_navigator.dart';

class DataChart extends StatefulWidget {
  @override
  _DataChartState createState() => _DataChartState();
}

class _DataChartState extends State<DataChart> {
  int _selectedIndex = 0;

  void _onItemPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<WidgetOptions> _chartOptions = <WidgetOptions> [
      new WidgetOptions(_options(context), "Chart Options"),
      new WidgetOptions(_monthlyChart(context), "Monthly Charts"),
      new WidgetOptions(_dailyChart(context), "Daily Charts"),
    ];

    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
              _chartOptions.elementAt(_selectedIndex).title,
              true
          ),
          body: _chartOptions.elementAt(_selectedIndex).widget,
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
            _onItemPressed(1);
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
                _onItemPressed(2);
              }
          ),
        ),
      ],
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

  static List<charts.Series<ActivityTrend, String>> createActivitySeriesData(Map<String, int> activityData ) {
    List<ActivityTrend> activitySeriesData = new List();
    activityData.forEach((k,v) {
      activitySeriesData.add(new ActivityTrend(k, v));
    });

    return [
      new charts.Series<ActivityTrend, String>(
        id: '# of Activity minutes',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ActivityTrend data, _) => data.key,
        measureFn: (ActivityTrend data, _) => data.activityTime,
        data: activitySeriesData,
      )
    ];
  }
}