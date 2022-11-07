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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: _exampleRoutes(),
    );
  }

  /// Each route demonstrates a different flow.
  ///
  /// Specific implementation available in every route widget.
  Map<String, WidgetBuilder> _exampleRoutes() {
    return {
      '/': (context) => HomePageWidget(),
      '/send_request': (context) => SendRequestPageWidget(),
      '/login_credentials': (context) => LoginWidthCredentialsWidget(),
      '/register_email': (context) => RegisterWithEmailWidget(),
      '/account_information': (context) => AccountInformationWidget(),
      '/manage_connections': (context) => ManageConnectionWidget(),
      '/forgot_password': (context) => ForgotPasswordPageWidget(),
      '/otp_phone_login': (context) => OTPLoginWidget(),
    };
  }
}
