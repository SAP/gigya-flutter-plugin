import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin/interruption/interruption_resolver.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';

class LoginWidthCredentialsWidget extends StatefulWidget {
  @override
  _LoginWidthCredentialsWidgetState createState() =>
      _LoginWidthCredentialsWidgetState();
}

class _LoginWidthCredentialsWidgetState
    extends State<LoginWidthCredentialsWidget> {
  final TextEditingController _loginIdEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  String _requestResult = '';
  bool _inProgress = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _linkPasswordController = TextEditingController();

  @override
  void dispose() {
    _loginIdEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Login with credentials'),
      ),
      body: Column(
        children: [
          _inProgress
              ? LinearProgressIndicator(
                  minHeight: 4,
                )
              : SizedBox(
                  height: 4,
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: const Text(
                    'Testing simple login using credentials',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox(width: 120, child: const Text('Enter login id:')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _loginIdEditingController,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 120, child: const Text('Enter password:')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _passwordEditingController,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                ButtonTheme(
                  minWidth: 240,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      final String loginId =
                          _loginIdEditingController.text.trim();
                      final String password =
                          _passwordEditingController.text.trim();
                      _sendLoginRequest(loginId, password);
                    },
                    child: const Text('Send Request'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          color: const Color(0xff3B5998),
                          child: IconButton(
                            icon: Image.asset('assets/facebook_new.png'),
                            iconSize: 50,
                            onPressed: () {
                              _sendSocialLoginRequest(SocialProvider.facebook);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    _requestResult ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Submit login request.
  void _sendLoginRequest(loginId, password) async {
    setState(() {
      _inProgress = true;
    });
    GigyaSdk.instance.login(loginId, password).then((result) {
      debugPrint(json.encode(result));
      final response = Account.fromJson(result);
      setState(() {
        _inProgress = false;
        _requestResult = 'Login success:\n\n ${response.uid}';
      });
    }).catchError((error) {
      if (error.getInterruption() == Interruption.conflictingAccounts) {
        LinkAccountResolver resolver =
            GigyaSdk.instance.resolverFactory.getResolver(error);
        _resolveLinkAccount(resolver);
      } else {
        setState(() {
          _inProgress = false;
          _requestResult = 'Register error\n\n${error.errorDetails}';
        });
      }
    });
  }

  /// Submit social login request.
  void _sendSocialLoginRequest(provider) async {
    setState(() {
      _inProgress = true;
    });
    GigyaSdk.instance.socialLogin(provider).then((result) {
      debugPrint(json.encode(result));
      final response = Account.fromJson(result);
      setState(() {
        _inProgress = false;
        _requestResult = 'Login success:\n\n ${response.uid}';
      });
    }).catchError((error) {
      if (error.getInterruption() == Interruption.conflictingAccounts) {
        LinkAccountResolver resolver =
            GigyaSdk.instance.resolverFactory.getResolver(error);
        _resolveLinkAccount(resolver);
      } else {
        setState(() {
          _inProgress = false;
          _requestResult = 'Register error\n\n${error.errorDetails}';
        });
      }
    });
  }

  /// Resolving link account interruption.
  _resolveLinkAccount(LinkAccountResolver resolver) async {
    final ConflictingAccounts conflictingAccounts =
        await resolver.getConflictingAccounts();
    if (conflictingAccounts.loginProviders.contains('site')) {
      // link to site.
      _showLinkToSiteBottomSheet(conflictingAccounts.loginID, resolver);
    } else {
      // link to social
      _showLinkToSocialBottomSheet(resolver);
    }
  }

  /// Show link account (site) bottom sheet.
  _showLinkToSiteBottomSheet(String loginId, LinkAccountResolver resolver) {
    _scaffoldKey.currentState.showBottomSheet((context) => Material(
          color: Colors.white,
          elevation: 4,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: const Text(
                      'Link to site',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(child: Text('Enter password for loginID: $loginId')),
                  SizedBox(height: 10),
                  TextField(
                    controller: _linkPasswordController,
                    decoration: InputDecoration(hintText: 'password'),
                  ),
                  SizedBox(height: 10),
                  ButtonTheme(
                    minWidth: 240,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        final String password =
                            _linkPasswordController.text.trim();
                        resolver.linkToSite(loginId, password).then((res) {
                          final Account account = Account.fromJson(res);

                          setState(() {
                            _inProgress = false;
                            _requestResult =
                                'Login success:\n\n ${account.uid}';
                          });
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Text('Link to site'),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }

  /// Show link account (social) bottom sheet.
  _showLinkToSocialBottomSheet(LinkAccountResolver resolver) {
    _scaffoldKey.currentState.showBottomSheet((context) => Material(
          color: Colors.white,
          elevation: 4,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: const Text(
                      'Link to social',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      color: const Color(0xff3B5998),
                      child: IconButton(
                        icon: Image.asset('assets/facebook_new.png'),
                        iconSize: 50,
                        onPressed: () async {
                          resolver
                              .linkToSocial(SocialProvider.facebook)
                              .then((res) {
                            final Account account = Account.fromJson(res);

                            setState(() {
                              _inProgress = false;
                              _requestResult =
                                  'Login success:\n\n ${account.uid}';
                            });
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }
}
