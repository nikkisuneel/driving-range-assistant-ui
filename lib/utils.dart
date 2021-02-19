import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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

Future<String> getAssetImagePath(String assetName) async {
  Directory directory = await getApplicationDocumentsDirectory();
  var dbPath = join(directory.path, "sample-image.jpg");
  ByteData data = await rootBundle.load(assetName);
  List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  File f = await File(dbPath).writeAsBytes(bytes);
  return f.path;
}