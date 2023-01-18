import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The home page widget.
class HomePage extends StatefulWidget {
  /// Construct a [HomePage] widget using the given [sdk].
  const HomePage({
    required this.sdk,
    super.key,
  });

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<bool> loggedInFuture;

  StreamSubscription<ScreensetEvent>? screenSetSubscription;

  void _refreshLogin() {
    if (!mounted) {
      return;
    }

    loggedInFuture = widget.sdk.isLoggedIn();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loggedInFuture = widget.sdk.isLoggedIn();
  }

  List<Widget> _buildLoggedInOptions(BuildContext context) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/account_information');

            if (mounted) {
              setState(() {});
            }
          },
          child: Text('Account information'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: () async {
            try {
              await widget.sdk.logout();

              _refreshLogin();
            } catch (error) {
              print('Logout error: $error');
            }
          },
          child: Text('Log out'),
        ),
      ),
      ElevatedButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/manage_connections');

          if (mounted) {
            setState(() {});
          }
        },
        child: Text('Manage connections'),
      ),
    ];
  }

  List<Widget> _buildLoggedOutOptions(BuildContext context) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: _showScreenSet,
          child: Text('Show Screenset (Default-RegistrationLogin)'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/login_credentials');

            _refreshLogin();
          },
          child: Text('Login with credentials'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/register_email');

            _refreshLogin();
          },
          child: Text('Register with email address'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: () async {
            try {
              final Map<String, dynamic> result = await widget.sdk.sso();

              print('SSO result: $result');

              _refreshLogin();
            } catch (error) {
              print('SSO error: $error');
            }
          },
          child: Text('SSO'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: () async {
            try {
              final Map<String, dynamic> result =
                  await widget.sdk.webAuthenticationService.login();

              print('FIDO result: $result');

              _refreshLogin();
            } catch (error) {
              print('FIDO error: $error');
            }
          },
          child: Text('Login with PassKey'),
        ),
      ),
      ElevatedButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/otp_phone_login');

          _refreshLogin();
        },
        child: Text('One Time Password phone login'),
      ),
    ];
  }

  void _showScreenSet() async {
    final String screenSet = 'Default-RegistrationLogin';

    try {
      screenSetSubscription = await widget.sdk.showScreenSet(screenSet).listen(
        (ScreensetEvent event) {
          print('event type: ${event.type}');
          print('event data: ${event.data}');

          if (event.type == ScreenSetEventType.cancel) {
            screenSetSubscription?.cancel();
            screenSetSubscription = null;
          } else if (event.type == ScreenSetEventType.login) {
            _refreshLogin();
          }
        },
        onError: (Object error) {
          print('error event from showScreenSet: $error');
        },
      );
    } catch (error) {
      print('showScreenSet error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: FutureBuilder<bool>(
        future: loggedInFuture,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Checking login status...'),
                  ),
                ],
              );
            case ConnectionState.done:
              final Object? error = snapshot.error;

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    if (error != null) ...<Widget>[
                      Flexible(
                        child: Text(
                          'Something went wrong while checking the login status.',
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            error.toString(),
                          ),
                        ),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, '/send_request');

                          _refreshLogin();
                        },
                        child: Text('Check available login id'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.pushNamed(
                            context,
                            '/forgot_password',
                          );

                          _refreshLogin();
                        },
                        child: Text('Forgot password'),
                      ),
                    ),
                    if (snapshot.data ?? false)
                      ..._buildLoggedInOptions(context)
                    else
                      ..._buildLoggedOutOptions(context),
                  ],
                ),
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    screenSetSubscription?.cancel();
    screenSetSubscription = null;
    super.dispose();
  }
}
