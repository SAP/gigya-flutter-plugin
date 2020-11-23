import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin_example/models/account.dart';

class AccountInformationWidget extends StatefulWidget {
  @override
  _AccountInformationWidgetState createState() => _AccountInformationWidgetState();
}

class _AccountInformationWidgetState extends State<AccountInformationWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account information'),
      ),
      body: FutureBuilder<AccountResponse>(
          future: _getAccountInformation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<AccountResponse> _getAccountInformation() async {
    return null;
  }
}
