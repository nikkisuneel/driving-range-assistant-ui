# driving_range_assistant_ui

This repository contains a Flutter app for iOS that assists the Outdoor Services Staff
with getting a count of the number of balls scattered on the driving range. 
It also configures data for pickers as well as displays trend charts for the user. The demo of how the app functions can be found [here](https://youtu.be/hxghdbrBY9s).

## Dependencies
The following dependencies are needed.
- camera
- path_provider:
- path:
- amplify_core: '<1.0.0'
- amplify_flutter: '<1.0.0'
- amplify_auth_cognito: '<1.0.0'
- aws_rekognition_api: ^0.2.0
- http:
- intl: ^0.16.1
- device_info: ^1.0.0
- charts_flutter: ^0.9.0

## Setting up authentication
AWS Cognito is used as the identity database. In order to use it, as a pre-requisite, the steps documented at https://docs.amplify.aws/lib/auth/getting-started/q/platform/flutter need to be followed to set up a User Pool.

Grant permission to access the Rekognition service to the User Pool by navigating to IAM in the AWS Console. To do this, perform the following steps.
- Navigate to IAM in the AWS Console
- Click on Roles in the left navigation
- Using the Search field, find the roles created for the User Pool
- Attach the AmazonRekognitionReadOnlyAccess policy 

## Deploying to a physical iOS device
Follow steps at https://medium.com/@mpapag1995/how-to-deploy-a-flutter-app-to-an-ios-device-48b286d921d3.

