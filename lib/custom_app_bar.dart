import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

import 'globals.dart' as global;

// Customized appbar for the application
class CustomAppBar extends PreferredSize {
  final String _title;
  final bool _needSettings;
  final Size preferredSize = Size.fromHeight(60.0);

  CustomAppBar(this._title, this._needSettings);

  @override
  Widget build(BuildContext context) {
    if (!_needSettings) {
      return PreferredSize(
          child: AppBar(
            title: Text(
                '$_title',
                style: TextStyle(
                  color: Colors.white,
            )),
            backgroundColor: Colors.grey[800],
          )
      );
    } else {
      return PreferredSize(
          child: AppBar(
            title: Text(
                '$_title',
                style: TextStyle(
                  color: Colors.white,
                )),
            backgroundColor: Colors.grey[800],
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                tooltip: "Logout",
                onPressed: () {
                  Amplify.Auth.signOut()
                      .then((value) {
                        global.isSignedIn = false;

                        // Remove all pages and push the login page
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                                (Route<dynamic> route) => false
                        );
                  });
                },
              )
            ],
          )
      );
    }
  }
}
