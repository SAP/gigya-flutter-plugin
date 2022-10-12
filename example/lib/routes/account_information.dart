import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';

class AccountInformationWidget extends StatefulWidget {
  @override
  _AccountInformationWidgetState createState() =>
      _AccountInformationWidgetState();
}

class _AccountInformationWidgetState extends State<AccountInformationWidget> {
  final TextEditingController _firstNameTextController =
      TextEditingController();
  bool _inProgress = false;

  @override
  void dispose() {
    _firstNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account information'),
      ),
      body: FutureBuilder<Account>(
        future: _getAccountInformation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Account account = snapshot.data;
            _firstNameTextController.text =
                _firstNameTextController.text.isEmpty
                    ? account.profile.firstName
                    : _firstNameTextController.text.trim() ?? '';
            return Container(
              child: Column(
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
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Account UID: ',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text(account.uid)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Email address: ',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text(account.profile.email)
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'Testing setAccount',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text('firstName:'),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _firstNameTextController,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        ButtonTheme(
                          minWidth: 240,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              _updateAccountInformation(account);
                            },
                            child: const Text('Update profile first name'),
                          ),
                        ),
                        SizedBox(height: 100),
                        ButtonTheme(
                          minWidth: 240,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              _registerPasskey();
                            },
                            child: const Text('Register new Passkey'),
                          ),
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
                              _revokePasskey();
                            },
                            child: const Text('Revoke Passkey'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Column(
                children: [
                  LinearProgressIndicator(
                    minHeight: 4,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  /// Fetch account information.
  Future<Account> _getAccountInformation() async {
    var result = await GigyaSdk.instance.getAccount();
    debugPrint(jsonEncode(result));
    Account response = Account.fromJson(result);
    return response;
  }

  /// Update account information given new updated [account] object.
  _updateAccountInformation(Account account) async {
    setState(() {
      _inProgress = true;
    });
    String newFirstName = _firstNameTextController.text.trim();
    var result = await GigyaSdk.instance.setAccount({
      'profile': jsonEncode({'firstName': newFirstName})
    });
    debugPrint(jsonEncode(result));
    FocusScope.of(context).unfocus();
    setState(() {
      _inProgress = false;
    });
  }

  _registerPasskey() async {
    setState(() {
      _inProgress = true;
    });
    var result = await GigyaSdk.instance.webAuthn.webAuthnRegister().catchError((error) {
      showError("FIDO error", (error as GigyaResponse).errorDetails);
    });
    debugPrint(jsonEncode(result));
    setState(() {
      _inProgress = false;
    });
  }

  _revokePasskey() async {
    setState(() {
      _inProgress = true;
    });
    var result = await GigyaSdk.instance.webAuthn.webAuthnRevoke().catchError((error) {
      showError("FIDO error", (error as GigyaResponse).errorDetails);
    });
    debugPrint(jsonEncode(result));
    setState(() {
      _inProgress = false;
    });
  }

  showError(String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
