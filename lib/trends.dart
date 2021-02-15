import 'package:flutter/material.dart';
import 'package:driving_range_assistant_ui/bottom_navigator.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'application_objects.dart';

class DataChart extends StatelessWidget {
  final List<charts.Series> golfBallData;
  final List<charts.Series> activityData;

  DataChart(this.golfBallData, this.activityData);

  @override
  Widget build(BuildContext context) {
      return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              title: Text('Trends'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Golf Ball Chart", style: Theme.of(context).textTheme.headline5),
                Container(
                  height: 200,
                  child: new charts.BarChart(
                    golfBallData,
                    animate: false,
                  ),
                ),
                Text("Activity Chart", style: Theme.of(context).textTheme.headline5),
                Container(
                  height: 200,
                  child: new charts.BarChart(
                    activityData,
                    animate: false,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigator(),
          )
      );
  }

  /// Create series list with multiple series
  static List<charts.Series<GolfBallTrend, String>> createGolfBallSampleData() {
    final golfBallData = [
      new GolfBallTrend("Sun.", 400),
      new GolfBallTrend("Mon.", 300),
      new GolfBallTrend("Tue.", 200),
      new GolfBallTrend("Wed.", 100),
      new GolfBallTrend("Thu.", 200),
      new GolfBallTrend("Fri.", 300),
      new GolfBallTrend("Sat.", 400),
    ];

    return [
      new charts.Series<GolfBallTrend, String>(
        id: '# of Golf Balls',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (GolfBallTrend data, _) => data.key,
        measureFn: (GolfBallTrend data, _) => data.ballCount,
        data: golfBallData,
      )
    ];
  }

  static List<charts.Series<ActivityTrend, String>> createActivitySampleData() {
    final activityData = [
      new ActivityTrend("Sun.", 60),
      new ActivityTrend("Mon.", 55),
      new ActivityTrend("Tue.", 50),
      new ActivityTrend("Wed.", 45),
      new ActivityTrend("Thu.", 50),
      new ActivityTrend("Fri.", 55),
      new ActivityTrend("Sat.", 60),
    ];

    return [
      new charts.Series<ActivityTrend, String>(
        id: 'Activity Time',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ActivityTrend data, _) => data.key,
        measureFn: (ActivityTrend data, _) => data.activityTime,
        data: activityData,
      )
    ];
  }
}
