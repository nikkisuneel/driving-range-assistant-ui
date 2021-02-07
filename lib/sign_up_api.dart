// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'amplifyconfiguration.dart';

import 'package:driving_range_assistant_ui/utils.dart';

class SignUpApi {
  String _email;
  String _userName;
  String _password;

  SignUpApi(this._email, this._userName, this._password);

  Future<bool> signUp() async {
    try {
      Map<String, dynamic> userAttributes = {
        "email": _email,
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: this._userName,
          password: this._password,
          options: CognitoSignUpOptions(
              userAttributes: userAttributes
          )
      );
      return true;
    } on AuthError catch (e) {
        printAmplifyStackTrace(e);
        return false;
    }
  }
}