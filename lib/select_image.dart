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
              Image.file(File(widget.imagePath)),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.send),
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
            },
            tooltip: 'Get Count',
          ),
          bottomNavigationBar: BottomNavigator(),
        )
    );
  }
}
