import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';

class SendRequestPageWidget extends StatefulWidget {
  @override
  _SendRequestPageWidgetState createState() => _SendRequestPageWidgetState();
}

class _SendRequestPageWidgetState extends State<SendRequestPageWidget> {
  final TextEditingController _loginIdEditingController = TextEditingController();
  String _requestResult = '';
  bool _inProgress = false;

  @override
  void dispose() {
    _loginIdEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send request'),
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
                    'Testing endpoint: accounts.isAvailableLoginID',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Text('Enter login id:'),
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
                SizedBox(
                  height: 26,
                ),
                ButtonTheme(
                  minWidth: 240,
                  child: RaisedButton(
                    onPressed: () {
                      final String loginID = _loginIdEditingController.text.trim();
                      sendRequest(loginID);
                    },
                    textColor: Colors.white,
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
  void sendRequest(loginId) async {
    setState(() {
      _inProgress = true;
    });
    GigyaSdk.instance.send('accounts.isAvailableLoginID', {'loginID': loginId}).then((result) {
      debugPrint(json.encode(result));
      final response = AvailableLoginIdResponse.fromJson(result);
      setState(() {
        _inProgress = false;
        _requestResult = 'Requested '
            'login id is ${response.isAvailable ? 'available' : 'not available'}';
      });
    }).catchError((error) {
      setState(() {
        _inProgress = false;
        _requestResult = 'Request error\n\n${error.errorDetails}';
      });
    });
  }
}

/// Specific response object used for the "accounts.isAvailableLoginID" endpoint.
/// Extending the [GigyaResponse] object is optional if you require using its provided structure.
class AvailableLoginIdResponse extends GigyaResponse {
  bool _isAvailable;

  bool get isAvailable => _isAvailable;

  AvailableLoginIdResponse.fromJson(dynamic json) : super.fromJson(json) {
    _isAvailable = json["isAvailable"];
  }
}
