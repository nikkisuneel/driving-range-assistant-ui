import 'dart:typed_data';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:aws_rekognition_api/rekognition-2016-06-27.dart';
import 'package:flutter/services.dart' show rootBundle;

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

    ByteData bytes = await rootBundle.load(_imagePath);
    Image image = Image(bytes: bytes.buffer.asUint8List());
    DetectLabelsResponse response = await service.detectLabels(
              image: image
    );

    return response.labels;
  }

  int getCountOfGolfBalls() {
    int result = 0;

    Future<void> labels = _analyze()
      .then((value) {
        // ignore: missing_return
        for (int i = 0; i < value.length; i++) {
          Label element = value.elementAt(i);
          if (element
              .name.contains(RegExp(r"^.*\sball[s]?.*", caseSensitive: false))) {
            for (int j = 0; j < element.instances.length; j++) {
              result++;
            }
          }
        }
        print("Number of golf balls: " + result.toString());
        return result;
    });
  }
}