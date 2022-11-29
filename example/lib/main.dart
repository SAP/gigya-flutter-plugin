import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin_example/routes/account_information.dart';
import 'package:gigya_flutter_plugin_example/routes/forgot_password.dart';
import 'package:gigya_flutter_plugin_example/routes/home_page.dart';
import 'package:gigya_flutter_plugin_example/routes/login_with_credentials.dart';
import 'package:gigya_flutter_plugin_example/routes/login_with_phone_otp.dart';
import 'package:gigya_flutter_plugin_example/routes/manage_connection.dart';
import 'package:gigya_flutter_plugin_example/routes/register_with_credentials.dart';
import 'package:gigya_flutter_plugin_example/routes/send_request.dart';

void main() async {
  final GigyaSdk sdk = const GigyaSdk();

  try {
    await sdk.initSdk(
      apiDomain: 'your_domain',
      apiKey: 'your_api_key',
    );
  } catch (error) {
    print(error);
  }

  runApp(MyApp(sdk));
}

/// The example app.
class MyApp extends StatefulWidget {
  /// The default constructor.
  const MyApp(this.sdk);

  /// The initialized Gigya SDK.
  final GigyaSdk sdk;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => HomePageWidget(widget.sdk),
        '/send_request': (_) => SendRequestPageWidget(widget.sdk),
        '/login_credentials': (_) => LoginWidthCredentialsWidget(widget.sdk),
        '/register_email': (_) => RegisterWithEmailWidget(widget.sdk),
        '/account_information': (_) => AccountInformationWidget(widget.sdk),
        '/manage_connections': (_) => ManageConnectionWidget(widget.sdk),
        '/forgot_password': (_) => ForgotPasswordPageWidget(widget.sdk),
        '/otp_phone_login': (_) => OTPLoginWidget(widget.sdk),
      },
    );
  }
}
