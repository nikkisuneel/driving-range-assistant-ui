import 'dart:io';

import 'package:flutter/material.dart';
import 'bottom_navigator.dart';
import 'image_recognition_api.dart';
import 'activity_page.dart';
import 'custom_app_bar.dart';

class PicturePage extends StatefulWidget {
  final String imagePath;

  const PicturePage ({ Key key, this.imagePath }): super(key: key);

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
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
