// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'amplifyconfiguration.dart';

class SignUpApi {
  String email;
  String userName;
  String password;

  SignUpApi(this.email, this.userName, this.password);

  Future<void> signUp() async {
    try {
      Map<String, dynamic> userAttributes = {
        "email": email,
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: userName,
          password: password,
          options: CognitoSignUpOptions(
              userAttributes: userAttributes
          )
      );
    } on AuthError catch (e) {
      print(e);
    }
  }
}