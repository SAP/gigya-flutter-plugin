import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin_example/provider/session_state_provider.dart';
import 'package:gigya_flutter_plugin_example/routes/account_information.dart';
import 'package:gigya_flutter_plugin_example/routes/home_page.dart';
import 'package:gigya_flutter_plugin_example/routes/login_with_credentials.dart';
import 'package:gigya_flutter_plugin_example/routes/send_request.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionStateProvider>(
      create: (_) => SessionStateProvider(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => HomePageWidget(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/send_request': (context) => SendRequestPageWidget(),
          '/login_credentials': (context) => LoginWidthCredentialsWidget(),
          '/account_information': (context) => AccountInformationWidget(),
        },
      ),
    );
  }
}
