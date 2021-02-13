import 'dart:io';
import 'dart:typed_data';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:aws_rekognition_api/rekognition-2016-06-27.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'utils.dart';

class ImageAnalyzer {
  String _imagePath;

  ImageAnalyzer(this._imagePath);

  Future<List<Label>> _analyze() async {

    CognitoAuthSession session = await Amplify.Auth
        .fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));

    AwsClientCredentials awsClientCredentials = new AwsClientCredentials(
        accessKey: session.credentials.awsAccessKey,
        secretKey: session.credentials.awsSecretKey,
        sessionToken: session.credentials.sessionToken
    );

    Rekognition service = Rekognition(
        region: "us-east-1",
        credentials: awsClientCredentials
    );

    bool b =  await isPhysicalDevice();
    Uint8List bytes;

    if (b) {
      bytes = await File(_imagePath).readAsBytes();
    } else {
      String assetPath = await getAssetImagePath("assets/driving-range-golf-balls.jpg");
      bytes = await File(assetPath).readAsBytes();
    }

    Image image = Image(bytes: bytes);
    DetectLabelsResponse response = await service.detectLabels(
              image: image
    );

    return response.labels;
  }

  Future<int> getCountOfGolfBalls() async {
    int result = 0;

    List<Label> labels = await _analyze();

    for (var item in labels) {
      if (item
            .name.contains(RegExp(r"^.*\sball[s]?.*", caseSensitive: false))) {
        result += item.instances.length;
      }
    }
    print("Number of golf balls: " + result.toString());
    return result;
  }
}