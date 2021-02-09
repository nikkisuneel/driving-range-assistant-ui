import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'amplifyconfiguration.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:driving_range_assistant_ui/login.dart';
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

  _configureAmplify();

  Widget landingPage = await _landingPage();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => landingPage,
      //'/take-picture': (context) => TakePicture(camera: firstCamera),
      '/select-image': (context) => FixedImage(),
      '/configure': (context) => Configure(),
      '/trends': (context) => Trends(),
    },
  ));
}

void _configureAmplify() async {
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
  AuthSession session = await Amplify.Auth.fetchAuthSession();
  if (session.isSignedIn) {
    return FixedImage();
  } else {
    return Login();
  }
}