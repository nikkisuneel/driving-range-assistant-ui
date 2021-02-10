import 'package:flutter/material.dart';
import 'bottom_navigator.dart';
import 'image_recognition_api.dart';
import 'activity.dart';
import 'app_bar.dart';

class SelectImage extends StatefulWidget {
  @override
  _SelectImageState createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
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
                  child: Image.asset(
                    'assets/driving-range-golf-balls.jpg',
                  ),
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
                                  builder: (context) => Activity(ballCount: value)
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
