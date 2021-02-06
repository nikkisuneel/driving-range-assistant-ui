import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:driving_range_assistant_ui/login.dart';
import 'package:driving_range_assistant_ui/sign_up.dart';
import 'package:driving_range_assistant_ui/take_picture.dart';
import 'package:driving_range_assistant_ui/fixed_image.dart';
import 'package:driving_range_assistant_ui/configure.dart';
import 'package:driving_range_assistant_ui/trends.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  //final firstCamera = cameras.first;
  //final firstCamera = cameras.first;

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/sign-up': (context) => SignUp(),
      //'/take-picture': (context) => TakePicture(camera: firstCamera),
      '/select-image': (context) => FixedImage(),
      '/configure': (context) => Configure(),
      '/trends': (context) => Trends(),
    },
  ));
}

