import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';
import 'package:gigya_flutter_plugin/services/otp_service.dart';

class OTPLoginWidget extends StatefulWidget {
  @override
  State<OTPLoginWidget> createState() => _OTPLoginWidgetState();
}

class _OTPLoginWidgetState extends State<OTPLoginWidget> {
  final TextEditingController _otpPhoneEditingController =
      TextEditingController();

  final TextEditingController _otpVerifyEditingController =
  TextEditingController();

  bool _inProgress = false;
  String _requestResult = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _otpPhoneEditingController.dispose();
    _otpVerifyEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Login with credentials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _inProgress
                ? LinearProgressIndicator(
              minHeight: 4,
            )
                : SizedBox(
              height: 4,
            ),
            Center(
              child: const Text(
                'Testing otp phone login',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                SizedBox(
                    width: 120, child: const Text('Phone:')),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: _otpPhoneEditingController,
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
                  final String phone =
                  _otpPhoneEditingController.text.trim();
                  _sendOtpLoginRequest(phone);
                },
                child: const Text('Send Request'),
              ),
            ),
            SizedBox(
              height: 26,
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
    );
  }


  /// Submit login request.
  void _sendOtpLoginRequest(phone) async {
    setState(() {
      _inProgress = true;
    });

    GigyaSdk.instance.otp.login(phone).then((resolver) {
      debugPrint('Otp login success');
      setState(() {
        _inProgress = false;
        _requestResult =
        'Code sent.';
      });
      _showVerifyCodeBottomSheet(phone, resolver);
    }).catchError((error) {
      setState(() {
        _inProgress = false;
      });
      _requestResult = 'Phone form error\n\n${error.errorDetails}';
    });
  }

  /// Show link account (site) bottom sheet.
  _showVerifyCodeBottomSheet(String phone, PendingOtpVerification resolver) {
    _scaffoldKey.currentState.showBottomSheet((context) => Material(
      color: Colors.white,
      elevation: 4,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: const Text(
                  'Verification',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              Center(child: Text('Enter code for phone: $phone')),
              SizedBox(height: 10),
              TextField(
                controller: _otpVerifyEditingController,
                decoration: InputDecoration(hintText: 'code'),
              ),
              SizedBox(height: 10),
              ButtonTheme(
                minWidth: 240,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    final String code =
                    _otpVerifyEditingController.text.trim();
                    resolver.verify(code).then((res) {
                      final Account account = Account.fromJson(res);

                      setState(() {
                        _inProgress = false;
                        _requestResult =
                        'Login success:\n\n ${account.uid}';
                      });
                      Navigator.of(context).pushReplacementNamed('/');
                    }).catchError((error) {
                      setState(() {
                        _inProgress = false;
                        _requestResult = 'Code Verify error\n\n${error.errorDetails}';
                      });
                    });
                  },
                  child: const Text('Verify'),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }
}
