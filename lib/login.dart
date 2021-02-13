import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/services.dart';

import 'sign_up_api.dart';
import 'verify_code_api.dart';
import 'sign_in_api.dart';
import 'app_bar.dart';
import 'utils.dart';


// This is the login page, containing signing up, code verification and login
// Since all 3 are interrelated, this is being done in one page
class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // These are controllers for handling user input
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _verifyCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int _selectedIndex = 0;
  bool _isSignedUp = false;
  String _userName = "";
  String _errorText = "";


  // Implementing initState
  @override
  initState() {
    super.initState();
  }

  void _onItemPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setErrorText(String text) {
    setState(() {
      _errorText = text;
    });
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _verifyCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Clearing field values in the form on loading the page
    if (_formKey != null && _formKey.currentState != null) {
      _formKey.currentState.reset();
    }

    // A list of widgets to hold login, signUp and verify pages
    List<WidgetOptions> _formOptions = <WidgetOptions> [
      new WidgetOptions(_loginWidget(), "Enter Credentials"),
      new WidgetOptions(_signUpWidget(), "Register"),
      new WidgetOptions(_verifyWidget(), "Verify Code"),
    ];
    
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            _formOptions.elementAt(_selectedIndex).getTitle(),
            false
          ),
          body: Form(
              key: _formKey,
              child: _formOptions.elementAt(_selectedIndex).getWidget(),
          )
      ),
    );
  }

  Widget _loginWidget() {
    return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter your username'
              ),
              controller: _userNameController,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Enter your password'
                ),
                obscureText: true,
                controller: _passwordController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_isSignedUp == false)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _onItemPressed(1);
                  },
                  child: Text('Sign-up'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      SignInApi signin = new SignInApi(
                          _userNameController.text,
                          _passwordController.text
                      );

                      Future<void> signInResult = signin.signIn()
                          .then((value) {
                          if (value) {
                            _setErrorText("");
                            isPhysicalDevice()
                                .then((value) {
                                  if (value) {
                                    Navigator.pushNamed(context, '/take-picture');
                                  } else {
                                    Navigator.pushNamed(context, '/dummy-fixed-image');
                                  }
                                });
                          } else {
                            _setErrorText("Login failed! Enter correct credentials");
                          }
                        }
                      );
                    }
                  },
                  child: Text('Sign-in'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  '$_errorText',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ]
    );
  }

  Widget _signUpWidget() {
    return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
                decoration: InputDecoration(
                    labelText: 'Enter a valid email address. Verification code will be sent to it.'
                ),
                controller: _emailController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
                decoration: InputDecoration(
                    labelText: 'Enter your username'
                ),
                controller: _userNameController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny("\s")
                ],
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Enter your password'
                ),
                controller: _passwordController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      SignUpApi signUpApi = new SignUpApi(
                          _emailController.text,
                          _userNameController.text,
                          _passwordController.text
                      );

                      Future<bool> signUpResult = signUpApi.signUp()
                        .then((value) {
                            setState(() {
                              _userName = _userNameController.text;
                              _isSignedUp = true;
                            });
                            _onItemPressed(2);
                            return value;
                          }
                      );
                    }
                  },
                  child: Text('Sign-up'),
                ),
              ),
            ],
          ),
        ]
    );
  }

  Widget _verifyWidget() {
    return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                decoration: InputDecoration(
                    labelText: 'Enter verification code'
                ),
                controller: _verifyCodeController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      VerifyCodeApi verifyCodeApi = new VerifyCodeApi(
                          _userName,
                          _verifyCodeController.text
                      );

                      Future<void> verifyCodeResult = verifyCodeApi.verify()
                        .then((value) {
                            if (value) {
                              // Sign out before you force a sign in
                              Amplify.Auth.signOut()
                              .then((value) {
                                _onItemPressed(0);
                              });
                            }
                          }
                      );
                    }
                  },
                  child: Text('Verify'),
                ),
              ),
            ],
          ),
        ]
    );
  }
}

// Class WidgetOptions consists of a widget and a title
class WidgetOptions {
  Widget _widget;
  String _title;

  WidgetOptions(Widget widget, String title) {
    setWidget(widget);
    setTitle(title);
  }

  Widget getWidget() {
    return this._widget;
  }
  void setWidget(Widget widget) {
    this._widget = widget;
  }

  String getTitle() {
    return this._title;
  }
  void setTitle(String title) {
    this._title = title;
  }

}