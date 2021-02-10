import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

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
            title: Text('$_title'),
          )
      );
    } else {
      return PreferredSize(
          child: AppBar(
            title: Text('$_title'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  Amplify.Auth.signOut()
                      .then((value) {
                        Navigator.popAndPushNamed(context, '/login');
                  });
                },
              )
            ],
          )
      );
    }
  }
}
