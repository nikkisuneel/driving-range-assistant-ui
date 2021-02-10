import 'package:flutter/material.dart';

import 'package:driving_range_assistant_ui/app_bar.dart';
import 'package:intl/intl.dart';

import 'bottom_navigator.dart';

class Activity extends StatefulWidget {
  final int ballCount;

  Activity({Key key, @required this.ballCount}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final _formKey = GlobalKey<FormState>();

  List<int> _pickerCount = [
    0,
    0,
    0,
    0
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
              false
          ),
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: Text("Date:", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text("$formattedNow", style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: Text("Ball Count:", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text("${widget.ballCount}", style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                Column(
                  // Generate 4 widgets that display their index in the List.
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text("Picker Size #$index:", style: TextStyle(fontWeight: FontWeight.bold))
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("${_pickerCount.elementAt(index)}", style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 20),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            _pickerCount[index]++;
                                          });
                                        },
                                        child: Icon(Icons.add),
                                        backgroundColor: Colors.black,
                                        tooltip: 'Increment',
                                      ),
                                    )
                                ),
                                SizedBox(width: 20),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            _pickerCount[index]--;
                                            if (_pickerCount[index] < 0) {
                                              _pickerCount[index] = 0;
                                            }
                                          });
                                        },
                                        child: Icon(Icons.remove),
                                        backgroundColor: Colors.black,
                                        tooltip: 'Decrement',
                                      ),
                                    )
                                )
                              ]
                            )
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            onPressed: () {

                            },
                            child: Icon(Icons.play_circle_fill, color: Colors.white),
                            backgroundColor: Colors.black,
                            tooltip: 'Start',
                          ),
                          FloatingActionButton(
                            onPressed: () {

                            },
                            child: Icon(Icons.stop, color: Colors.white),
                            backgroundColor: Colors.black,
                            tooltip: 'Stop',
                          ),
                        ]
                      )
                  )
                )
              ],
            ),
          ),
        bottomNavigationBar: BottomNavigator(),
      ),
    );
  }
}