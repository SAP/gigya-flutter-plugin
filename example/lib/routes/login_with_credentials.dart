import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';

class LoginWidthCredentialsWidget extends StatefulWidget {
  @override
  _LoginWidthCredentialsWidgetState createState() => _LoginWidthCredentialsWidgetState();
}

class _LoginWidthCredentialsWidgetState extends State<LoginWidthCredentialsWidget> {
  final TextEditingController _loginIdEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  String _requestResult = '';
  bool _inProgress = false;

  @override
  void dispose() {
    _loginIdEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with credentials'),
      ),
      body: Column(
        children: [
          _inProgress
              ? LinearProgressIndicator(
                  minHeight: 4,
                )
              : SizedBox(
                  height: 4,
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: const Text(
                    'Testing simple login using credentials',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox(width: 120, child: const Text('Enter login id:')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _loginIdEditingController,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 120, child: const Text('Enter password:')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _passwordEditingController,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                ButtonTheme(
                  minWidth: 240,
                  child: RaisedButton(
                    onPressed: () {
                      final String loginId = _loginIdEditingController.text.trim();
                      final String password = _passwordEditingController.text.trim();
                      _sendLoginRequest(loginId, password);
                    },
                    textColor: Colors.white,
                    child: const Text('Send Request'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                    child: IconButton(
                      icon: Image.asset('assets/google_dark.png'),
                      iconSize: 50,
                      onPressed: () {
                        _sendSocialLoginRequest(SocialProvider.google);
                        },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    _requestResult ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Submit login request.
  void _sendLoginRequest(loginId, password) async {
    setState(() {
      _inProgress = true;
    });
    GigyaSdk.instance.login(loginId, password).then((result) {
      debugPrint(json.encode(result));
      final response = Account.fromJson(result);
      setState(() {
        _inProgress = false;
        _requestResult = 'Login success:\n\n ${response.uid}';
      });
    }).catchError((error) {
      setState(() {
        _inProgress = false;
        _requestResult = 'Request error\n\n${error.errorDetails}';
      });
    });
  }

  /// Submit social login request.
  void _sendSocialLoginRequest(provider) async {
    setState(() {
      _inProgress = true;
    });
    GigyaSdk.instance.socialLogin(provider).then((result) {
      debugPrint(json.encode(result));
      final response = Account.fromJson(result);
      setState(() {
        _inProgress = false;
        _requestResult = 'Login success:\n\n ${response.uid}';
      });
    }).catchError((error) {
      setState(() {
        _inProgress = false;
        _requestResult = 'Request error\n\n${error.errorDetails}';
      });
    });
  }
}
