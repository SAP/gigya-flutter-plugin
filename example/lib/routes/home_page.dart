import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin_example/provider/session_state_provider.dart';
import 'package:provider/provider.dart';

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
    return Consumer<SessionStateProvider>(
      builder: (context, provider, child) {
        var loggedIn = provider.loggedIn;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Option selection'),
            actions: [
              loggedIn
                  ? IconButton(
                      icon: new Image.asset('assets/286027_SAP_for_Me_R_neg_orange.png'),
                      tooltip: 'User logged in. Click to request account information',
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
                HomeButtonWidget(route: '/send_request', text: 'Send request'),
                loggedIn ? Container() : HomeButtonWidget(route: '/login_credentials', text: 'Login with credentials'),
                loggedIn ? HomeButtonWidget(route: '/account_information', text: 'getAccount') : Container(),
                loggedIn
                    ? ButtonTheme(
                        minWidth: 240,
                        child: RaisedButton(
                          textColor: Colors.white,
                          onPressed: () {
                            GigyaSdk.instance.logout().then((val) {
                              provider.updateLoginState(false);
                            });
                          },
                          child: const Text('Log out'),
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

class HomeButtonWidget extends StatelessWidget {
  final String route;
  final String text;

  const HomeButtonWidget({Key key, this.route, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: ButtonTheme(
        minWidth: 240,
        child: RaisedButton(
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Text(text),
        ),
      ),
    );
  }
}
