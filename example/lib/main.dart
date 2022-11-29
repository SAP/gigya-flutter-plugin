import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin_example/routes/account_information.dart';
import 'package:gigya_flutter_plugin_example/routes/forgot_password.dart';
import 'package:gigya_flutter_plugin_example/routes/home_page.dart';
import 'package:gigya_flutter_plugin_example/routes/login_with_credentials.dart';
import 'package:gigya_flutter_plugin_example/routes/login_with_phone_otp.dart';
import 'package:gigya_flutter_plugin_example/routes/manage_connection.dart';
import 'package:gigya_flutter_plugin_example/routes/register_with_credentials.dart';
import 'package:gigya_flutter_plugin_example/routes/send_request.dart';

void main() {
  runApp(MyApp());
}

/// The example app.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => HomePageWidget(),
        '/send_request': (_) => SendRequestPageWidget(),
        '/login_credentials': (_) => LoginWidthCredentialsWidget(),
        '/register_email': (_) => RegisterWithEmailWidget(),
        '/account_information': (_) => AccountInformationWidget(),
        '/manage_connections': (_) => ManageConnectionWidget(),
        '/forgot_password': (_) => ForgotPasswordPageWidget(),
        '/otp_phone_login': (_) => OTPLoginWidget(),
      },
    );
  }
}
