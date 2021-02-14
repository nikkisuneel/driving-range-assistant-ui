import 'package:flutter/material.dart';

import 'package:driving_range_assistant_ui/app_bar.dart';
import 'package:intl/intl.dart';

import 'application_objects.dart';
import 'bottom_navigator.dart';

class Activity extends StatefulWidget {
  final int ballCount;

  Activity({Key key, @required this.ballCount}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final _formKey = GlobalKey<FormState>();
  String _startTime = "";
  String _endTime = "";

  List<PickerCount> _pickerCount = [
    new PickerCount(new Picker("Manual", "M", 10), 0),
    new PickerCount(new Picker("Slow Machine", "A", 50), 0),
    new PickerCount(new Picker("Fast Machine", "A", 100), 0),
  ];

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
    final now = new DateTime.now();
    final formattedNow = new DateFormat('yMMMMd').format(now);

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(child: Text("Date:", style: Theme.of(context).textTheme.headline6)),
                          Expanded(child: Text("$formattedNow", style: Theme.of(context).textTheme.headline6)),
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
                      itemCount: _pickerCount.length,
                      // Provide a builder function. This is where the magic happens.
                      // Convert each item into a widget based on the type of item it is.
                      itemBuilder: (context, index) {
                        final picker = _pickerCount[index];

                        return ListTile(
                          title: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(child: Text(picker.picker.name, style: Theme.of(context).textTheme.headline6)),
                                Expanded(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("${picker.count}", style: Theme.of(context).textTheme.headline6),
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
                                                      picker.count++;
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
                                                      picker.count++;
                                                      if (picker.count < 0) {
                                                        picker.count = 0;
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
                                      child: Text("$_startTime", style: Theme.of(context).textTheme.headline6)
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
                                      child: Text("$_endTime", style: Theme.of(context).textTheme.headline6)
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
                            onPressed: () {
                              setState(() {
                                _startTime = _formattedTime();
                              });
                            },
                            child: Icon(Icons.play_circle_outline_sharp, color: Colors.white),
                            backgroundColor: Colors.black38,
                            tooltip: 'Start',
                          ),
                          FloatingActionButton(
                            heroTag: "StopBtn",
                            onPressed: () {
                              setState(() {
                                _endTime = _formattedTime();
                              });
                            },
                            child: Icon(Icons.stop_circle_outlined, color: Colors.white),
                            backgroundColor: Colors.black38,
                            tooltip: 'Stop',
                          ),
                        ]
                      )
                  )
                ),
              ],
            ),
          ),
        bottomNavigationBar: BottomNavigator(),
      ),
    );
  }

  // Method for formatting start time and end time
  String _formattedTime() {
    DateTime startTime = DateTime.now();
    return DateFormat(DateFormat.HOUR_MINUTE_SECOND).format(startTime);
  }
}

class PickerCount {
  Picker picker;
  int count;

  PickerCount(this.picker, this.count);
}