import 'package:flutter/material.dart';

class OTPLoginWidget extends StatefulWidget {
  @override
  State<OTPLoginWidget> createState() => _OTPLoginWidgetState();
}

class _OTPLoginWidgetState extends State<OTPLoginWidget> {
  final TextEditingController _otpPhoneEditingController =
      TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _otpPhoneEditingController.dispose();
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
            Center(
              child: const Text(
                'Testing otp phone login',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
