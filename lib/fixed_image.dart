import 'package:flutter/material.dart';
import 'package:driving_range_assistant_ui/bottom_navigator.dart';

import 'package:driving_range_assistant_ui/image_recognition_api.dart';

import 'app_bar.dart';

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
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: CustomAppBar(
                  "Get a Count",
                  true
              )
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
                        ImageAnalyzer analyzer = new ImageAnalyzer("assets/driving-range-golf-balls.jpg");
                        int numberOfGolfBalls = analyzer.getCountOfGolfBalls();
                      })
              )
            ],
          ),
          bottomNavigationBar: BottomNavigator(),
        )
    );
  }
}
