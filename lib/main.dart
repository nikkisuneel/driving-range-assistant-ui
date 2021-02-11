import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:device_info/device_info.dart';
import 'amplifyconfiguration.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'select_image.dart';
import 'configure.dart';
import 'take_picture.dart';
import 'trends.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  _configureAmplify();

  Widget landingPage = await _landingPage();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => landingPage,
      '/login': (context) => Login(),
      '/select-image': (context) => SelectImage(),
      '/configure-pickers': (context) => Configure(),
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
    return TakePicture();
  } else {
    return Login();
  }

}