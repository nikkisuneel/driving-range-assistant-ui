import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

void printAmplifyStackTrace(AuthError e) {
  for (int i = 0; i < e.exceptionList.length; i++) {
    print(e.exceptionList[i].detail);
  }
}