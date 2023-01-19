import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The register with email page widget.
class RegisterWithEmailPage extends StatefulWidget {
  /// Construct a [RegisterWithEmailPage] widget using the given [sdk].
  const RegisterWithEmailPage({required this.sdk, super.key});

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<RegisterWithEmailPage> createState() => _RegisterWithEmailPageState();
}

class _RegisterWithEmailPageState extends State<RegisterWithEmailPage> {
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _requestResult = '';
  bool _inProgress = false;

  void _register({required String loginId, required String password}) async {
    setState(() {
      _inProgress = true;
    });

    try {
      final Map<String, dynamic> result = await widget.sdk.register(
        loginId: loginId,
        password: password,
      );

      final Account account = Account.fromJson(result);

      setState(() {
        _inProgress = false;
        _requestResult = 'Register success:\n\n ${account.uid}';
      });
    } catch (error) {
      setState(() {
        _inProgress = false;
        _requestResult = 'Register error\n\n$error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register with email address'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _inProgress
                ? LinearProgressIndicator(minHeight: 4)
                : SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Testing simple login using credentials',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _loginIdController,
                decoration: InputDecoration(hintText: 'Email address'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'Password'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ElevatedButton(
                onPressed: () async {
                  final FormState? formState = _formKey.currentState;

                  if (formState == null || !formState.validate()) {
                    return;
                  }

                  _register(
                    loginId: _loginIdController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                },
                child: Text('Register'),
              ),
            ),
            Text(
              _requestResult,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
