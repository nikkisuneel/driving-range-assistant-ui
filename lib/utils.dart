/*
 * Copyright (c) 2021, Nikhila (Nikki) Suneel. All Rights Reserved.
 */

import 'dart:io';

import 'package:amplify_core/types/exception/AmplifyException.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void printAmplifyStackTrace(AmplifyException e) {
    print("Message=" + e.message + " Underlying exception:" + e.underlyingException);
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