import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';

class RegisterWithEmailWidget extends StatefulWidget {
  @override
  _RegisterWidthEmailWidgetState createState() =>
      _RegisterWidthEmailWidgetState();
}

class _RegisterWidthEmailWidgetState extends State<RegisterWithEmailWidget> {
  final TextEditingController _loginIdEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  String _requestResult = '';
  bool _inProgress = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _loginIdEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Register with email address'),
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
                    SizedBox(
                        width: 120, child: const Text('Enter email address:')),
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      final String loginId =
                          _loginIdEditingController.text.trim();
                      final String password =
                          _passwordEditingController.text.trim();
                      sendRequest(loginId, password);
                    },
                    child: const Text('Send Request'),
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

  /// Submit request.
  void sendRequest(email, password) async {
    setState(() {
      _inProgress = true;
    });
    GigyaSdk.instance.register(email, password).then((result) {
      debugPrint(json.encode(result));
      final response = Account.fromJson(result);
      setState(() {
        _inProgress = false;
        _requestResult = 'Register success:\n\n ${response.uid}';
      });
    }).catchError((error) {
      setState(() {
        _inProgress = false;
        _requestResult = 'Register error\n\n${error.errorDetails}';
      });
    });
  }
}
