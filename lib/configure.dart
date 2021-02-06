import 'package:flutter/material.dart';
import 'package:driving_range_assistant_ui/bottom_navigator.dart';

class Configure extends StatefulWidget {
  @override
  _ConfigureState createState() => _ConfigureState();
}

class _ConfigureState extends State<Configure> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
              title: Text('Configure Items'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                    color: Colors.indigoAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                    child: Text(
                        'Configure Golf Pickers',
                        style: TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.bold)
                    ),
                    onPressed: () {
                      // Mark Add code to configure pickers
                    }),
                RaisedButton(
                    color: Colors.indigoAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                    child: Text(
                        'Configure Golf Buckets',
                        style: TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.bold)
                    ),
                    onPressed: () {
                      // MARK: add code to configure buckets
                    })
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigator(),
        )
    );
  }
}
