import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The home page widget.
class HomePage extends StatefulWidget {
  /// Construct a [HomePage] widget using the given [sdk].
  const HomePage({required this.sdk, super.key});

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
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
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    loggedInFuture = widget.sdk.isLoggedIn();
    _checkBiometricState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _checkBiometricState();
        print('resumed');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.paused:
        print('paused');
        break;
      case AppLifecycleState.detached:
        print('detached');
        break;
      case AppLifecycleState.hidden:
        print('hidden');
        break;
    }
  }

  Future<void> _checkBiometricState() async {
    bool isLocked = await widget.sdk.biometricService.isLocked();
    if (isLocked) {
      try {
        await widget.sdk.biometricService.unlockSession(
          parameters: <String, String>{
            'title': 'SampleTitle',
            'subtitle': 'SampleSubtitle',
            'description': 'SampleDescription',
          },
        );

        isLocked = await widget.sdk.biometricService.isLocked();
        if (mounted) {
          setState(_refreshLogin);
        }
      } catch (error) {
        if (mounted) {
          setState(() {
            _showBiometricErrorDialog(error.toString());
          });
        }
      }
    }
  }

  Future<void> _showBiometricErrorDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          child: const Text('Account information'),
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
          child: const Text('Log out'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/biometrics');

            if (mounted) {
              setState(() {});
            }
          },
          child: const Text('Biometrics'),
        ),
      ),
      ElevatedButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/manage_connections');

          if (mounted) {
            setState(() {});
          }
        },
        child: const Text('Manage connections'),
      ),
    ];
  }

  List<Widget> _buildLoggedOutOptions(BuildContext context) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: _showScreenSet,
          child: const Text('Show Screenset (Default-RegistrationLogin)'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/login_credentials');

            _refreshLogin();
          },
          child: const Text('Login with credentials'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/register_email');

            _refreshLogin();
          },
          child: const Text('Register with email address'),
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
          child: const Text('SSO'),
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
          child: const Text('Login with PassKey'),
        ),
      ),
      ElevatedButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/otp_phone_login');

          _refreshLogin();
        },
        child: const Text('One Time Password phone login'),
      ),
    ];
  }

  void _showScreenSet() async {
    const String screenSet = 'Default-RegistrationLogin1';

    try {
      screenSetSubscription =
          widget.sdk.showScreenSet(screenSet, isDebug: kDebugMode).listen(
        (ScreensetEvent event) {
          print('event type: ${event.type}');
          print('event data: ${event.data}');

          if (event.type == ScreenSetEventType.onCancel) {
            screenSetSubscription?.cancel();
            screenSetSubscription = null;
          } else if (event.type == ScreenSetEventType.onLogin) {
            _refreshLogin();
          } else if (event.type == ScreenSetEventType.onError) {
            widget.sdk.dismissScreenSet();
            print('event error: ${event.data}');
            screenSetSubscription?.cancel();
            screenSetSubscription = null;
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
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder<bool>(
        future: loggedInFuture,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Checking login status...'),
                  ),
                ],
              );
            case ConnectionState.done:
              final Object? error = snapshot.error;

              return Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      if (error != null) ...<Widget>[
                        const Flexible(
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
                          child: const Text('Check available login id'),
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
                          child: const Text('Forgot password'),
                        ),
                      ),
                      if (snapshot.data ?? false)
                        ..._buildLoggedInOptions(context)
                      else
                        ..._buildLoggedOutOptions(context),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    screenSetSubscription?.cancel();
    screenSetSubscription = null;
    super.dispose();
  }
}
