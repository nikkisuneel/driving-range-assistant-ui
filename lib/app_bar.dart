import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String _title;
  final bool _needSettings;

  CustomAppBar(this._title, this._needSettings);

  @override
  Widget build(BuildContext context) {
    if (!_needSettings) {
      return AppBar(
            title: Text('$_title'),
          );
    } else {
      return AppBar(
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
                        Navigator.popAndPushNamed(context, '/');
                  });
                },
              )
            ],
          );
    }
  }
}
