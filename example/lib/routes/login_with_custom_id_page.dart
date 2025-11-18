import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The login with custom ID page widget.
class LoginWithCustomIdPage extends StatefulWidget {
  /// Construct a [LoginWithCustomIdPage] widget using the given [sdk].
  const LoginWithCustomIdPage({required this.sdk, super.key});

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<LoginWithCustomIdPage> createState() => _LoginWithCustomIdPageState();
}

class _LoginWithCustomIdPageState extends State<LoginWithCustomIdPage> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _requestResult = '';
  bool _inProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _loginWithCustomId({
    required String identifier,
    required String identifierType,
    required String password,
  }) async {
    setState(() {
      _inProgress = true;
    });

    try {
      final Map<String, dynamic> result =
          await widget.sdk.loginWithCustomIdentifier(
        identifier: identifier,
        identifierType: identifierType,
        password: password,
      );
      final Account account = Account.fromJson(result);

      _setLoginSuccess(account);
    } on GigyaError catch (error) {
      _setGenericError(error);
    } catch (error) {
      _setGenericError(error);
    }
  }

  void _setGenericError(Object error) {
    if (mounted) {
      setState(() {
        _inProgress = false;
        _requestResult = 'Login error: \n\n $error';
      });
    }
  }

  void _setLoginSuccess(Account account) {
    if (mounted) {
      setState(() {
        _inProgress = false;
        _requestResult = 'Login success: \n\n ${account.uid}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Custom ID'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _inProgress
                ? const LinearProgressIndicator(minHeight: 4)
                : const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Testing simple login using custom id',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _identifierController,
                decoration:
                    const InputDecoration(hintText: 'Enter login identifier'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Login identifier is required';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(hintText: 'Enter password'),
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
                onPressed: () {
                  final FormState? formState = _formKey.currentState;

                  if (formState == null || !formState.validate()) {
                    return;
                  }

                  _loginWithCustomId(
                    identifier: _identifierController.text,
                    identifierType: 'gigya.com/identifiers/customIdentifiers/nationalId',
                    password: _passwordController.text,
                  );
                },
                child: const Text('Send Request'),
              ),
            ),
            Text(
              _requestResult,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
