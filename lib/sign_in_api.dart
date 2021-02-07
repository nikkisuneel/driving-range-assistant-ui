// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'amplifyconfiguration.dart';

import 'package:driving_range_assistant_ui/utils.dart';

class SignInApi {
  String userName;
  String password;

  SignInApi(this.userName, this.password);

  Future<bool> signIn() async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: this.userName.trim(),
        password: this.password.trim(),
      );
      return true;
    } on AuthError catch (e) {
        printAmplifyStackTrace(e);
        return false;
    }
  }
}