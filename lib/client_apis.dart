/*
 * Copyright (c) 2021, Nikhila (Nikki) Suneel. All Rights Reserved.
 */

import 'dart:convert';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:http/http.dart' as http;

import 'application_objects.dart';
import 'globals.dart' as global;
import 'utils.dart';

Future<bool> signUp(String email, String userName, String password) async {
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
      return true;
   } on AuthError catch (e) {
      printAmplifyStackTrace(e);
      return false;
   }
}

Future<bool> verify(String userName, String verificationCode) async {
   try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: userName,
          confirmationCode: verificationCode
      );
      return true;
   } on AuthError catch (e) {
      printAmplifyStackTrace(e);
      return false;
   }
}

Future<bool> signIn(String userName, String password) async {
   try {
      SignInResult res = await Amplify.Auth.signIn(
         username: userName.trim(),
         password: password.trim(),
      );

      global.isSignedIn = true;

      return true;
   } on AuthError catch (e) {
      printAmplifyStackTrace(e);
      return false;
   }
}

Future<List<Picker>> getPickers() async {
   final url =
       "https://n2c72fi2k0.execute-api.us-east-1.amazonaws.com/beta/pickers";

   CognitoAuthSession session = await Amplify.Auth
       .fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));

   var headers = {
      "x-driving-range-auth" : session.userPoolTokens.idToken
   };

   return http.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
         final body = json.decode(response.body);
         List<Picker> pickers = [];
         for (var item in body) {
            Picker picker = Picker.fromJson(item);
            pickers.add(picker);
         }
         return pickers;
      }
      if (statusCode < 200 || statusCode > 400 || json == null) {
         throw new Exception("Error while fetching Picker data");
      }
      return null;
   });
}

Future<void> createPicker(Picker p) async {
   final url =
       "https://n2c72fi2k0.execute-api.us-east-1.amazonaws.com/beta/pickers";

   CognitoAuthSession session = await Amplify.Auth
       .fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));

   var headers = {
      "x-driving-range-auth" : session.userPoolTokens.idToken
   };

   return http.post(url, headers: headers, body: json.encode(p.toJson())).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
         throw new Exception("Error creating picker");
      }
      return;
   });
}

Future<void> updatePicker(Picker p) async {
   final url =
       "https://n2c72fi2k0.execute-api.us-east-1.amazonaws.com/beta/pickers/" + p.id.toString();

   CognitoAuthSession session = await Amplify.Auth
       .fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));

   var headers = {
      "x-driving-range-auth" : session.userPoolTokens.idToken
   };

   return http.put(url, headers: headers, body: json.encode(p.toJson())).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 400 || json == null) {
         String rb = response.body;
         throw new Exception("Error updating Picker");
      }
      return null;
   });
}

Future<BallPickingActivity> createBallPickingActivity(BallPickingActivity a) async {
   final url =
       "https://n2c72fi2k0.execute-api.us-east-1.amazonaws.com/beta/ball-picking-activities";

   CognitoAuthSession session = await Amplify.Auth
       .fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));

   var headers = {
      "x-driving-range-auth" : session.userPoolTokens.idToken
   };

   return http.post(url, headers: headers, body: json.encode(a.toJson())).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
         throw new Exception("Error creating ball picking activity");
      }

      var decodedBody = json.decode(response.body);

      BallPickingActivity addedActivity = BallPickingActivity.fromJson(decodedBody);

      return addedActivity;
   });
}

Future<void> updateBallPickingActivity(BallPickingActivity a) async {
   final url =
       "https://n2c72fi2k0.execute-api.us-east-1.amazonaws.com/beta/ball-picking-activities/" + a.id.toString();

   CognitoAuthSession session = await Amplify.Auth
       .fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));

   var headers = {
      "x-driving-range-auth" : session.userPoolTokens.idToken
   };

   return http.put(url, headers: headers, body: json.encode(a.toJson())).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 400 || json == null) {
         throw new Exception("Error updating ball picking activity");
      }
      return null;
   });
}

Future<DataTrendObject> getTrends() async {
   final url =
       "https://n2c72fi2k0.execute-api.us-east-1.amazonaws.com/beta/trends";

   CognitoAuthSession session = await Amplify.Auth
       .fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));

   var headers = {
      "x-driving-range-auth" : session.userPoolTokens.idToken
   };

   return http.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
         final body = json.decode(response.body);
         DataTrendObject dto = DataTrendObject.fromJson(body);
         return dto;
      }
      if (statusCode < 200 || statusCode > 400 || json == null) {
         throw new Exception("Error while fetching trend data");
      }
      return null;
   });
}