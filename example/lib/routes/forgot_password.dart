import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';

class ForgotPasswordPageWidget extends StatefulWidget {
  @override
  _ForgotPasswordPageWidgetState createState() =>
      _ForgotPasswordPageWidgetState();
}

class _ForgotPasswordPageWidgetState extends State<ForgotPasswordPageWidget> {
  final TextEditingController _loginIdEditingController =
      TextEditingController();
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
        title: const Text('Forgot password'),
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
                    'Testing forgot password with login ID',
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      final String loginID =
                          _loginIdEditingController.text.trim();
                      sendRequest(loginID);
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
  void sendRequest(loginId) async {
    setState(() {
      _inProgress = true;
    });
    GigyaSdk.instance.forgotPassword(loginId).then((result) {
      debugPrint('Success');
      setState(() {
        _inProgress = false;
        _requestResult = 'Requested: '
            'instructions have been sent to your email';
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
