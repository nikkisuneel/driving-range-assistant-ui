import 'dart:convert';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:http/http.dart' as http;

import 'application_objects.dart';

Future<List<Picker>> getPickers() async {
   var url =
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
         throw new Exception("Error while fetching data");
      }
      return null;
   });
}