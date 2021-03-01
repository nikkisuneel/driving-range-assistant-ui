/*
 * Copyright (c) 2021, Nikhila (Nikki) Suneel. All Rights Reserved.
 */

import 'package:flutter/material.dart';
import 'bottom_navigator.dart';
import 'image_recognition_api.dart';
import 'activity_page.dart';
import 'custom_app_bar.dart';


// This class is a dummy widget because simulator doesn't have camera
// This is a stateless widget because there is no user input
class DummyFixedImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
              "Analyze image",
              true
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: Image.asset("assets/driving-range-golf-balls.jpg"),
                  flex: 10
              ),
              Expanded(
                  child: FloatingActionButton.extended(
                      icon: Icon(Icons.send),
                      label: Text('Get Count'),
                      onPressed: () {
                        ImageAnalyzer analyzer = new ImageAnalyzer("assets/driving-range-golf-balls.jpg");
                        analyzer.getCountOfGolfBalls()
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActivityPage(ballCount: value)
                              )
                          );
                        });
                      })
              )
            ],
          ),
          bottomNavigationBar: BottomNavigator(),
        )
    );
  }
}