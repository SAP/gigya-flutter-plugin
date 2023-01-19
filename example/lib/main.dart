import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

import 'routes/home_page.dart';
import 'routes/login_with_credentials_page.dart';
import 'routes/register_with_email_page.dart';
import 'routes/send_request_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const GigyaSdk sdk = GigyaSdk();

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
        '/': (_) => HomePage(sdk: widget.sdk),
        '/send_request': (_) => SendRequestPage(sdk: widget.sdk),
        '/login_credentials': (_) => LoginWithCredentialsPage(sdk: widget.sdk),
        '/register_email': (_) => RegisterWithEmailPage(sdk: widget.sdk),
      },
    );
  }
}
