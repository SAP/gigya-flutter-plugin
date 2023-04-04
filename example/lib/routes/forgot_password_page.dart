import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The forgot password page.
class ForgotPasswordPage extends StatefulWidget {
  /// Construct a [ForgotPasswordPage] widget using the given [sdk].
  const ForgotPasswordPage({required this.sdk, super.key});

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _loginIdController = TextEditingController();
  String _requestResult = '';
  bool _inProgress = false;

  void _forgotPassword(String loginId) async {
    setState(() {
      _inProgress = true;
    });

    try {
      final Map<String, dynamic> result =
          await widget.sdk.forgotPassword(loginId);

      print(result);

      if (mounted) {
        setState(() {
          _inProgress = false;
          _requestResult =
              'Success: Instructions to reset your password have been sent to your email.';
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _inProgress = false;
          _requestResult = 'Request error\n\n$error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot password')),
      body: Column(
        children: <Widget>[
          _inProgress
              ? const LinearProgressIndicator(minHeight: 4)
              : const SizedBox(height: 4),
          const Text(
            'Testing forgot password with login ID',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _loginIdController,
              decoration: const InputDecoration(hintText: 'Enter login id'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _loginIdController,
              builder: (
                BuildContext context,
                TextEditingValue value,
                Widget? child,
              ) {
                final String loginId = value.text.trim();

                return ElevatedButton(
                  onPressed:
                      loginId.isEmpty ? null : () => _forgotPassword(loginId),
                  child: const Text('Forgot Password'),
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
    _loginIdController.dispose();
    super.dispose();
  }
}
