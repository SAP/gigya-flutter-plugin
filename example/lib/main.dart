import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

import 'routes/account_information_page.dart';
import 'routes/forgot_password_page.dart';
import 'routes/home_page.dart';
import 'routes/login_with_credentials_page.dart';
import 'routes/manage_connections_page.dart';
import 'routes/one_time_password_login_page.dart';
import 'routes/register_with_email_page.dart';
import 'routes/send_request_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const GigyaSdk sdk = GigyaSdk();

  // Demonstrate explicit initialization before calling `runApp()`,
  // using the configuration for the example app.
  const String exampleAppApiKey = 'YOUR-API-KEY-HERE';
  const String exampleAppApiDomain = 'us1.gigya.com';

  try {
    await sdk.initSdk(
      apiDomain: exampleAppApiDomain,
      apiKey: exampleAppApiKey,
    );

    print('Gigya SDK initialized.');
  } catch (error, stackTrace) {
    print('Failed to initialize the Gigya SDK.');
    print(error);
    print(stackTrace);
  }

  runApp(const MyApp(sdk));
}

/// The example app.
class MyApp extends StatefulWidget {
  /// The default constructor.
  const MyApp(this.sdk, {super.key});

  /// The initialized Gigya SDK.
  final GigyaSdk sdk;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => HomePage(sdk: widget.sdk),
        '/send_request': (_) => SendRequestPage(sdk: widget.sdk),
        '/login_credentials': (_) => LoginWithCredentialsPage(sdk: widget.sdk),
        '/register_email': (_) => RegisterWithEmailPage(sdk: widget.sdk),
        '/account_information': (_) => AccountInformationPage(sdk: widget.sdk),
        '/manage_connections': (_) => ManageConnectionsPage(sdk: widget.sdk),
        '/forgot_password': (_) => ForgotPasswordPage(sdk: widget.sdk),
        '/otp_phone_login': (_) => OneTimePasswordLoginPage(sdk: widget.sdk),
      },
    );
  }
}
