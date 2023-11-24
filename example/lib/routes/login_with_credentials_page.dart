import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The login with credentials page widget.
class LoginWithCredentialsPage extends StatefulWidget {
  /// Construct a [LoginWithCredentialsPage] widget using the given [sdk].
  const LoginWithCredentialsPage({required this.sdk, super.key});

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<LoginWithCredentialsPage> createState() =>
      _LoginWithCredentialsPageState();
}

class _LoginWithCredentialsPageState extends State<LoginWithCredentialsPage> {
  final TextEditingController _linkPasswordController = TextEditingController();
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _requestResult = '';
  bool _inProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _login({required String loginId, required String password}) async {
    setState(() {
      _inProgress = true;
    });

    try {
      final Map<String, dynamic> result = await widget.sdk.login(
        loginId: loginId,
        password: password,
      );
      final Account account = Account.fromJson(result);

      _setLoginSuccess(account);
    } on GigyaError catch (error) {
      final InterruptionResolver? resolver =
          widget.sdk.interruptionResolverFactory.fromErrorCode(error);

      if (resolver is LinkAccountResolver) {
        _resolveLinkAccount(resolver);

        return;
      }

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
        _requestResult = 'Login success: \n\n ${account.toJson()}';
      });
    }
  }

  void _socialLogin(SocialProvider provider) async {
    setState(() {
      _inProgress = true;
    });

    try {
      final Map<String, dynamic> result = await widget.sdk.socialLogin(
        provider,
      );

      final Account account = Account.fromJson(result);

      _setLoginSuccess(account);
    } on GigyaError catch (error) {
      final InterruptionResolver? resolver =
          widget.sdk.interruptionResolverFactory.fromErrorCode(error);

      if (resolver is LinkAccountResolver) {
        _resolveLinkAccount(resolver);

        return;
      }

      if (resolver is PendingRegistrationResolver) {
        _resolvePendingRegistration(resolver);

        return;
      }

      if (mounted) {
        setState(() {
          _inProgress = false;
          _requestResult = 'Login canceled';
        });
      }
    } catch (error) {
      _setGenericError(error);
    }
  }

  void _resolveLinkAccount(LinkAccountResolver resolver) async {
    final ConflictingAccount? conflictingAccount =
        await resolver.conflictingAccount;

    if (!mounted || conflictingAccount == null) {
      return;
    }

    if (conflictingAccount.loginProviders.contains('site')) {
      _showLinkToSiteBottomSheet(conflictingAccount.loginID, resolver);
    } else {
      _showLinkToSocialBottomSheet(resolver);
    }
  }

  void _resolveLinkToSiteConflict(
    BuildContext context, {
    required String loginId,
    required String password,
    required LinkAccountResolver resolver,
  }) async {
    try {
      final Map<String, dynamic> result = await resolver.linkToSite(
        loginId: loginId,
        password: password,
      );

      final Account account = Account.fromJson(result);

      _setLoginSuccess(account);

      // Remove the bottom sheet.
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      _setGenericError(error);

      // Remove the bottom sheet.
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _resolveLinkToSocialConflict(
    BuildContext context,
    LinkAccountResolver resolver,
    SocialProvider provider,
  ) async {
    try {
      final Map<String, dynamic> result = await resolver.linkToSocial(provider);

      final Account account = Account.fromJson(result);

      _setLoginSuccess(account);

      // Remove the bottom sheet.
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      _setGenericError(error);

      // Remove the bottom sheet.
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _resolvePendingRegistration(
    PendingRegistrationResolver resolver,
  ) async {
    try {
      final Map<String, dynamic> result =
          await resolver.setAccount(<String, dynamic>{
        'profile': <String, dynamic>{'birthMonth': '5', 'birthYear': '5'},
      });

      final Account account = Account.fromJson(result);

      _setLoginSuccess(account);

      // Return to the home page after registration.
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      _setGenericError(error);
    }
  }

  void _showLinkToSiteBottomSheet(
    String? loginId,
    LinkAccountResolver resolver,
  ) {
    final ScaffoldState? scaffoldState = _scaffoldKey.currentState;

    if (!mounted || scaffoldState == null || loginId == null) {
      return;
    }

    scaffoldState.showBottomSheet<void>(
      (BuildContext context) => Material(
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Link to site',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('Enter password for loginID: $loginId'),
                ),
                TextField(
                  controller: _linkPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'password'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _linkPasswordController,
                    builder: (
                      BuildContext context,
                      TextEditingValue value,
                      Widget? child,
                    ) {
                      return ElevatedButton(
                        onPressed: value.text.trim().isEmpty
                            ? null
                            : () => _resolveLinkToSiteConflict(
                                  context,
                                  loginId: loginId,
                                  password: value.text.trim(),
                                  resolver: resolver,
                                ),
                        child: const Text('Link to site'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLinkToSocialBottomSheet(
    LinkAccountResolver resolver,
  ) {
    final ScaffoldState? scaffoldState = _scaffoldKey.currentState;

    if (!mounted || scaffoldState == null) {
      return;
    }

    scaffoldState.showBottomSheet<void>(
      (BuildContext context) => Material(
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Link to social', style: TextStyle(fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: const Color(0xff3B5998),
                    child: IconButton(
                      icon: Image.asset('assets/facebook_new.png'),
                      iconSize: 50,
                      onPressed: () => _resolveLinkToSocialConflict(
                        context,
                        resolver,
                        SocialProvider.facebook,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Login with credentials'),
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
                'Testing simple login using credentials',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _loginIdController,
                decoration: const InputDecoration(hintText: 'Enter login id'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Login id is required';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
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

                  _login(
                    loginId: _loginIdController.text,
                    password: _passwordController.text,
                  );
                },
                child: const Text('Send Request'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    color: const Color(0xff3B5998),
                    child: IconButton(
                      onPressed: () => _socialLogin(SocialProvider.facebook),
                      icon: Image.asset('assets/facebook_new.png'),
                      iconSize: 50,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: const Color(0xff3B5998),
                    child: IconButton(
                      onPressed: () => _socialLogin(SocialProvider.google),
                      icon: Image.asset('assets/google_dark.png'),
                      iconSize: 50,
                    ),
                  ),
                ],
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
    _linkPasswordController.dispose();
    _loginIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
