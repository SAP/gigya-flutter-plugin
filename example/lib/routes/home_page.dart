import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

/// Home page widget (initial route).
class _HomePageWidgetState extends State<HomePageWidget> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GigyaSdk.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: GigyaSdk.instance.isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Theme.of(context).primaryColor,
          );
        }
        var loggedIn = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Option selection'),
            actions: [
              loggedIn
                  ? IconButton(
                      icon: new Image.asset(
                          'assets/286027_SAP_for_Me_R_neg_orange.png'),
                      tooltip:
                          'User logged in. Click to request account information',
                      onPressed: () {
                        Navigator.pushNamed(context, '/account_information');
                      },
                    )
                  : Container()
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text('Running on: $_platformVersion\n')),
                ButtonTheme(
                  minWidth: 240,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/send_request').then((val) {
                        setState(() {
                          debugPrint('Refresh on back');
                        });
                      });
                    },
                    child: Text('Check available login id'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: ButtonTheme(
                    minWidth: 240,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot_password')
                            .then((val) {
                          setState(() {
                            debugPrint('Refresh on back');
                          });
                        });
                      },
                      child: Text("Forgot password"),
                    ),
                  ),
                ),
                loggedIn
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: ButtonTheme(
                          minWidth: 240,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              GigyaSdk.instance.showScreenSet(
                                  "Default-RegistrationLogin", (event, map) {
                                debugPrint('Screen set event received: $event');
                                debugPrint(
                                    'Screen set event data received: $map');
                                if (event == 'onHide' || event == 'onLogin') {
                                  setState(() {});
                                }
                              });
                            },
                            child: Text("Show ScreenSet"),
                          ),
                        ),
                      ),
                loggedIn
                    ? Container()
                    : ButtonTheme(
                        minWidth: 240,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login_credentials')
                                .then((val) {
                              setState(() {
                                debugPrint('Refresh on back');
                              });
                            });
                          },
                          child: Text('Login with credentials'),
                        ),
                      ),
                loggedIn
                    ? Container()
                    : ButtonTheme(
                        minWidth: 240,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/register_email')
                                .then((val) {
                              setState(() {
                                debugPrint('Refresh on back');
                              });
                            });
                          },
                          child: Text('Register with email address'),
                        ),
                      ),
                loggedIn
                    ? ButtonTheme(
                        minWidth: 240,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/account_information')
                                .then((val) {
                              setState(() {
                                debugPrint('Refresh on back');
                              });
                            });
                          },
                          child: Text('Account information'),
                        ),
                      )
                    : Container(),
                loggedIn
                    ? ButtonTheme(
                        minWidth: 240,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            GigyaSdk.instance.logout().then((val) {
                              setState(() {});
                            });
                          },
                          child: const Text('Log out'),
                        ),
                      )
                    : Container(),
                loggedIn
                    ? ButtonTheme(
                        minWidth: 240,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/manage_connections')
                                .then((val) {
                              setState(() {
                                debugPrint('Refresh on back');
                              });
                            });
                          },
                          child: Text('Manage connections'),
                        ),
                      )
                    : Container(),
                loggedIn == false
                    ? ButtonTheme(
                        minWidth: 240,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            GigyaSdk.instance.sso().then((result) {
                              setState(() {});
                            }).catchError((error) {});
                          },
                          child: Text('SSO'),
                        ),
                      )
                    : Container(),
                loggedIn == false
                    ? ButtonTheme(
                        minWidth: 240,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            GigyaSdk.instance.webAuthn
                                .webAuthnLogin()
                                .then((result) {
                              setState(() {});
                            }).catchError((error) {});
                          },
                          child: Text('Login with PassKey'),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
