// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:driving_range_assistant_ui/utils.dart';
import 'globals.dart' as global;

class SignInApi {
  String _userName;
  String _password;

  SignInApi(this._userName, this._password);

  Future<bool> signIn() async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: this._userName.trim(),
        password: this._password.trim(),
      );

      global.isSignedIn = true;

      return true;
    } on AuthError catch (e) {
        printAmplifyStackTrace(e);
        return false;
    }
  }
}