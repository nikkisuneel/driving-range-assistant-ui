/*
 * Copyright (c) 2021, Nikhila (Nikki) Suneel. All Rights Reserved.
 */

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:driving_range_assistant_ui/app_themes.dart';
import 'package:flutter/services.dart';
import 'amplifyconfiguration.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'app_themes.dart';
import 'login_page.dart';
import 'dummy_fixed_mage_page.dart';
import 'picker_page.dart';
import 'camera_page.dart';
import 'chart_options_page.dart';
import 'globals.dart' as global;
import 'utils.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Get list of available cameras for that phone
  List<CameraDescription> cameras = await availableCameras();
  // Get back camera
  for (var item in cameras) {
    if (item.lensDirection == CameraLensDirection.back) {
      global.camera = item;
      break;
    }
  }

  bool b = await isPhysicalDevice();
  if (b) {
    // Exit if no camera is found and it is a physical device
    if (cameras.isEmpty || global.camera == null) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  // Configure AWS SDK
  _configureAmplify();

  // Initialize a mock Picker database
  // var pickerDB = PickerDatabase();

  Widget landingPage = await _landingPage();

  // Setting up routes for each page with a name
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => landingPage,
      '/login': (context) => LoginPage(),
      '/take-picture': (context) => CameraPage(),
      '/dummy-fixed-image': (context) => DummyFixedImagePage(),
      '/configure-pickers': (context) => PickerPage(),
      '/trends': (context) => ChartOptionsPage(),
    },
    theme: AppTheme.defaultTheme,
  ));
}

Future<void> _configureAmplify() async {
  try {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    Amplify.addPlugin(authPlugin);

    // Once Plugins are added, configure Amplify if it is not already configured
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    print(e);
  }
}

Future<Widget> _landingPage() async {

  // Check if user has signed in
  AuthSession session = await Amplify.Auth.fetchAuthSession();
  if (session.isSignedIn) {
    global.isSignedIn = true;
    bool b = await isPhysicalDevice();

    // If b is true
    if (b) {
      return CameraPage();
    } else {
      return DummyFixedImagePage();
    }
  } else {
      return LoginPage();
  }

}