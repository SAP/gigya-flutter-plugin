import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';

class ManageConnectionWidget extends StatefulWidget {
  @override
  _ManageConnectionWidgetState createState() => _ManageConnectionWidgetState();
}

class _ManageConnectionWidgetState extends State<ManageConnectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage connections'),
      ),
      body: FutureBuilder<Account>(
        future: _getAccountInformation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
          Account account = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Center(child: const Text('Current account connections:\n')),
                account.socialProviders.isNotEmpty ? Text(account.socialProviders) : Container(),
                SizedBox(height: 20),
                ButtonTheme(
                  minWidth: 200,
                  child: RaisedButton(
                    onPressed: () {
                      _addConnection();
                    },
                    textColor: Colors.white,
                    child: const Text('Add connection'),
                  ),
                ),
                SizedBox(height: 16),
                ButtonTheme(
                  minWidth: 200,
                  child: RaisedButton(
                    onPressed: () {
                      _removeConnection();
                    },
                    textColor: Colors.white,
                    child: const Text('Remove connection'),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  /// Fetch account information.
  Future<Account> _getAccountInformation() async {
    var result = await GigyaSdk.instance.getAccount(invalidate: true);
    debugPrint(jsonEncode(result));
    Account response = Account.fromJson(result);
    return response;
  }

  /// Add a social connection.
  ///
  /// In this case adding Facebook social connection.
  void _addConnection() async {
    var result = await GigyaSdk.instance.addConnection(SocialProvider.facebook);
    debugPrint(jsonEncode(result));
    setState(() {});
  }

  /// Remove a social connection.
  ///
  /// In this case removing Facebook connection.
  void _removeConnection() async {
    await GigyaSdk.instance.removeConnection(SocialProvider.facebook);
    setState(() {});
  }
}
