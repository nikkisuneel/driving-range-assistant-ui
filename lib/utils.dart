import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:camera/camera.dart';
import 'package:device_info/device_info.dart';

void printAmplifyStackTrace(AuthError e) {
  for (int i = 0; i < e.exceptionList.length; i++) {
    print(e.exceptionList[i].detail);
  }
}

Future<bool> isPhysicalDevice() async {
  // Load the device_info plugin to detect if running on simulator or real device
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  IosDeviceInfo deviceInfo = await deviceInfoPlugin.iosInfo;

  return deviceInfo.isPhysicalDevice;
}

Future<CameraDescription> getCamera() async {
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  return cameras.first;
}

