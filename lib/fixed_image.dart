import 'package:flutter/material.dart';
import 'package:driving_range_assistant_ui/bottom_navigator.dart';

class FixedImage extends StatefulWidget {
  @override
  _FixedImageState createState() => _FixedImageState();
}

class _FixedImageState extends State<FixedImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            title: Text('Send Image'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: Image.asset(
                    'assets/driving-range-golf-balls.jpg',
                  ),
                flex: 10
              ),
              Expanded(
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.indigoAccent,
                      child: Text(
                        'Count Golf balls',
                        style: TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.bold)
                      ),
                      onPressed: () {
                      // MARK: add code to send to AWS
                      })
              )
            ],
          ),
          bottomNavigationBar: BottomNavigator(),
        )
    );
  }
}
