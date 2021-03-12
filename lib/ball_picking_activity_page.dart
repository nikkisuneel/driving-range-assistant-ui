/*
 * Copyright (c) 2021, Nikhila (Nikki) Suneel. All Rights Reserved.
 */

import 'package:driving_range_assistant_ui/client_apis.dart';
import 'package:driving_range_assistant_ui/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:driving_range_assistant_ui/custom_app_bar.dart';
import 'package:intl/intl.dart';

import 'application_objects.dart';
import 'bottom_navigator.dart';

class BallPickingActivityPage extends StatefulWidget {
  final int ballCount;

  BallPickingActivityPage({Key key, @required this.ballCount}) : super(key: key);

  @override
  _BallPickingActivityPageState createState() => _BallPickingActivityPageState();
}

class _BallPickingActivityPageState extends State<BallPickingActivityPage> {
  final _formKey = GlobalKey<FormState>();
  int _activityId;
  DateTime _activityDate;
  Map<String, int> _pickerCounts;
  DateTime _startTime;
  String _startTimeTxt ="";
  DateTime _endTime;
  String _endTimeTxt = "";
  bool _startBtnPressed = false;

  // List<PickerCount> _pickerCount = PickerCount.buildList();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_formKey != null && _formKey.currentState != null) {
      _formKey.currentState.reset();
    }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            "Start/Stop Activity",
            true
        ),
        body: Form(
          key: _formKey,
          child: _buildForm(),
        ),
        bottomNavigationBar: BottomNavigator(),
      ),
    );
  }

  Widget _buildForm() {
    if (_pickerCounts != null) {
      return _layout();
    }
    return FutureBuilder<List<Picker>>(
      future: getPickers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the form for activity.
          _pickerCounts = _initializePickerCounts(snapshot.data);
          return _layout();
        } else {
          // Otherwise, display a loading indicator.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _layout() {
    if (_activityDate == null) {
      _activityDate = new DateTime.now();
    }
    final formattedActivityDate = new DateFormat('yMMMd').format(
        _activityDate);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text("Date:", style: Theme.of(context).textTheme.headline6)),
                  Expanded(child: Text("$formattedActivityDate", style: Theme.of(context).textTheme.headline6)),
                ],
              ),
            )
        ),
        ListTile(
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text("Ball Count:", style: Theme.of(context).textTheme.headline6)),
                  Expanded(child: Text("${widget.ballCount}", style: Theme.of(context).textTheme.headline6))
                ],
              ),
            )
        ),
        Column(
          // Generate Picker Count widgets that display their index in the List.
            children: [
              ListView.builder(
                shrinkWrap: true,
                // Let the ListView know how many items it needs to build.
                itemCount: _pickerCounts.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final pickerName = _pickerCounts.keys.elementAt(index);

                  return ListTile(
                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(child: Text(pickerName, style: Theme.of(context).textTheme.headline6)),
                          Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("${_pickerCounts[pickerName]}", style: Theme.of(context).textTheme.headline6),
                                    SizedBox(width: 20),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          child: FloatingActionButton(
                                            heroTag: "btn-A$index",
                                            onPressed: () {
                                              setState(() {
                                                _pickerCounts[pickerName]++;
                                                if (_pickerCounts[pickerName] > 9) {
                                                  _pickerCounts[pickerName] = 9;
                                                }
                                              });
                                            },
                                            child: Icon(Icons.add),
                                            tooltip: 'Increment',
                                          ),
                                        )
                                    ),
                                    SizedBox(width: 20),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          child: FloatingActionButton(
                                            heroTag: "btn-B$index",
                                            onPressed: () {
                                              setState(() {
                                                _pickerCounts[pickerName]--;
                                                if (_pickerCounts[pickerName] < 0) {
                                                  _pickerCounts[pickerName] = 0;
                                                }
                                              });
                                            },
                                            child: Icon(Icons.remove),
                                            tooltip: 'Decrement',
                                          ),
                                        )
                                    )
                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ]
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text("Start Time:", style: Theme.of(context).textTheme.headline6)),
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  boxShadow: [BoxShadow(color: Colors.grey)],
                                ),
                                child: Text("$_startTimeTxt", style: Theme.of(context).textTheme.headline6)
                            )
                        )
                      ],
                    ),
                  )
              ),
              ListTile(
                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text("End Time:", style: Theme.of(context).textTheme.headline6)),
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  boxShadow: [BoxShadow(color: Colors.grey)],
                                ),
                                child: Text("$_endTimeTxt", style: Theme.of(context).textTheme.headline6)
                            )
                        )
                      ],
                    ),
                  )
              ),
            ]
        ),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        heroTag: "StartBtn",
                        onPressed: () async {
                          if (_startBtnPressed) {
                            return;
                          }
                          setState(() {
                            _startBtnPressed = true;
                            _startTime = DateTime.now();
                            _startTimeTxt = _formattedTime(_startTime);
                          });

                          BallPickingActivity a = new BallPickingActivity(_activityDate,
                            widget.ballCount,
                            _pickerCounts
                          );

                          a.startTime = _startTime;

                          BallPickingActivity addedActivity = await createBallPickingActivity(a);

                          setState(() {
                            _activityId = addedActivity.id;
                          });
                        },
                        child: Icon(Icons.play_circle_outline),
                        backgroundColor: _startBtnPressed
                            ? Colors.grey[400]
                            : Theme.of(context).floatingActionButtonTheme.backgroundColor,
                        tooltip: 'Start',
                      ),
                      FloatingActionButton(
                        heroTag: "StopBtn",
                        onPressed: () async {
                          setState(() {
                            _endTime = DateTime.now();
                            _endTimeTxt = _formattedTime(_endTime);
                          });

                          BallPickingActivity a = new BallPickingActivity(_activityDate,
                              widget.ballCount,
                              _pickerCounts
                          );

                          a.startTime = _startTime;
                          a.endTime = _endTime;
                          a.id = _activityId;
                          await updateBallPickingActivity(a);
                        },
                        child: Icon(Icons.stop_circle_outlined),
                        tooltip: 'Stop',
                      ),
                    ]
                )
            )
        ),
      ],
    );
  }

  // Method for formatting start time and end time
  String _formattedTime(DateTime now) {
    return DateFormat(DateFormat.HOUR_MINUTE_SECOND).format(now);
  }

  // Build map for holding picker counts
  static Map<String, int> _initializePickerCounts(List<Picker> pickers) {
    Map<String, int> result = new Map();

    for (var item in pickers) {
      result[item.name] = 0;
    }

    return result;
  }
}
