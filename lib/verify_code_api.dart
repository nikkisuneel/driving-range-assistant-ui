// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'amplifyconfiguration.dart';

class VerifyCodeApi {
  String verificationCode;

  VerifyCodeApi(this.verificationCode);

  Future<void> verify() async {
    try {
      SignInResult res = await Amplify.Auth.confirmSignIn(
          confirmationValue: verificationCode
      );
    } on AuthError catch (e) {
      print(e);
    }
  }
}