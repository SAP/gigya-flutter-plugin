import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The One-Time-Password login page.
class OneTimePasswordLoginPage extends StatefulWidget {
  /// Construct a [OneTimePasswordLoginPage] with the given [sdk].
  const OneTimePasswordLoginPage({required this.sdk, super.key});

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<OneTimePasswordLoginPage> createState() =>
      _OneTimePasswordLoginPageState();
}

class _OneTimePasswordLoginPageState extends State<OneTimePasswordLoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _verifyPasswordController =
      TextEditingController();

  bool _inProgress = false;
  String _requestResult = '';

  void _sendOtpCode(String phone) async {
    setState(() {
      _inProgress = true;
    });

    try {
      final PendingOtpVerification verification =
          await widget.sdk.otpService.login(phone);

      print('One-Time-Password code sent to $phone');

      if (mounted) {
        setState(() {
          _inProgress = false;
          _requestResult = 'Code sent.';
        });

        _showVerifyOtpCodeBottomSheet(verification, phone);
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _inProgress = false;
          _requestResult = 'OTP error: $error';
        });
      }
    }
  }

  void _showVerifyOtpCodeBottomSheet(
    PendingOtpVerification verification,
    String phone,
  ) {
    _scaffoldKey.currentState?.showBottomSheet<void>((BuildContext context) {
      return Material(
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Verification',
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Enter code for phone: $phone'),
              ),
              TextField(
                controller: _verifyPasswordController,
                decoration: const InputDecoration(hintText: 'code'),
              ),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _verifyPasswordController,
                builder: (
                  BuildContext context,
                  TextEditingValue value,
                  Widget? child,
                ) {
                  final String code = value.text.trim();

                  return ElevatedButton(
                    onPressed: code.isEmpty
                        ? null
                        : () => _verifyCode(verification, code),
                    child: const Text('Verify code'),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  void _verifyCode(
    PendingOtpVerification verification,
    String code,
  ) async {
    try {
      final Map<String, dynamic> result = await verification.verify(code);

      final Account account = Account.fromJson(result);

      if (mounted) {
        print('Login success:\n\n ${account.uid}');

        // Navigate back to the home page.
        unawaited(Navigator.of(context).pushReplacementNamed('/'));
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _inProgress = false;
          _requestResult = 'Code Verify error\n\n$error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Login with One-Time-Password'),
      ),
      body: Column(
        children: <Widget>[
          _inProgress
              ? const LinearProgressIndicator(minHeight: 4)
              : const SizedBox(height: 4),
          const Text(
            'Testing One-Time-Password phone login',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(hintText: 'Phone number'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _phoneNumberController,
              builder: (
                BuildContext context,
                TextEditingValue value,
                Widget? child,
              ) {
                final String phone = value.text.trim();

                return ElevatedButton(
                  onPressed: phone.isEmpty ? null : () => _sendOtpCode(phone),
                  child: const Text('Send code to phone'),
                );
              },
            ),
          ),
          Text(
            _requestResult,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _verifyPasswordController.dispose();
    super.dispose();
  }
}
