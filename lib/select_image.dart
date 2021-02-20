import 'dart:io';

import 'package:flutter/material.dart';
import 'bottom_navigator.dart';
import 'image_recognition_api.dart';
import 'activity_page.dart';
import 'app_bar.dart';

class SelectImage extends StatefulWidget {
  final String imagePath;

  const SelectImage ({ Key key, this.imagePath }): super(key: key);

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
                  child: Image.file(File(widget.imagePath)),
                  flex: 10
              ),
              Expanded(
                  child: FloatingActionButton.extended(
                    icon: Icon(Icons.send),
                    label: Text('Get Count'),
                    onPressed: () {
                      ImageAnalyzer analyzer = new ImageAnalyzer(widget.imagePath);
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
