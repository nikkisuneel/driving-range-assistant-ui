import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'bottom_navigator.dart';
import 'application_objects.dart';

class ConfigurePickers extends StatefulWidget {

  ConfigurePickers({Key key}) : super(key: key);

  @override
  _ConfigurePickersState createState() => _ConfigurePickersState();
}

class _ConfigurePickersState extends State<ConfigurePickers> {
  final _formKey = GlobalKey<FormState>();

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

    final List<Picker> pickers = <Picker> [
      new Picker("Manual", "Manual", 10),
      new Picker("Slow Machine", "Automatic", 50),
      new Picker("Fast Machine", "Automatic", 100),
    ];

    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            "Start/Stop Activity",
            true
          ),
          body: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                // Let the ListView know how many items it needs to build.
                itemCount: pickers.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final picker = pickers[index];

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.lightBlueAccent,
                          ),
                          child: ListTile(
                            title: Container(
                              child: Row(
                                children: [
                                  Expanded(child: Text(picker.name, style: Theme.of(context).textTheme.headline5)),
                                ],
                              ),
                            ),
                            subtitle: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(child: Text(picker.type, style: Theme.of(context).textTheme.subtitle1)),
                                  Expanded(child: Text(picker.throughPut.toString() + " balls/min", style: Theme.of(context).textTheme.subtitle1)),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {

                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
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
                              child: Icon(Icons.add),
                              tooltip: 'Add',
                            ),
                          ]
                      )
                  )
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigator(),
        )
    );
  }
}