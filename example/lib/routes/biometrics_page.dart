import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The One-Time-Password login page.
class BiometricsPage extends StatefulWidget {
  /// Construct an [BiometricsPage] with the given [sdk].
  const BiometricsPage({required this.sdk, super.key});

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<BiometricsPage> createState() => _BiometricsPageState();
}

class _BiometricsPageState extends State<BiometricsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isOptIn = false;
  bool isLocked = false;
  String errorMessage = '';

  void _isOptIn() async {
    final bool isOptIn = await widget.sdk.isOptIn();
    setState(() {
      this.isOptIn = isOptIn;
    });
  }

  void _isLocked() async {
    final bool isLocked = await widget.sdk.isLocked();
    setState(() {
      this.isLocked = isLocked;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isOptIn();
    _isLocked();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Biometrics'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            enabled: false,
            title: const Text(
              'Biometrics',
            ),
            subtitle: const Text(
              'Opt-in/Opt-out the existing session to use biometric authentication.',
            ),
            trailing: SizedBox(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Switch(
                    value: isOptIn,
                    onChanged: (bool isOn) async {
                      if (isOn) {
                        await widget.sdk.optIn(parameters: <String, String>{
                          'title': 'SampleTitle',
                          'subtitle': 'SampleSubtitle',
                          'description': 'SampleDescription',
                        }).onError((error, stackTrace) {
                          setState(() {
                            errorMessage = error.toString();
                          });
                          return false;
                        });
                      } else {
                        await widget.sdk.optOut(parameters: <String, String>{
                          'title': 'SampleTitle',
                          'subtitle': 'SampleSubtitle',
                          'description': 'SampleDescription',
                        }).onError((error, stackTrace) {
                          setState(() {
                            errorMessage = error.toString();
                          });
                          return false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            enabled: false,
            title: const Text(
              'Toggle Session Lock',
            ),
            subtitle: const Text(
              'Locks the existing session until unlocking it. No authentication based actions can be done while the session is locked.',
            ),
            trailing: SizedBox(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Switch(
                    value: isLocked,
                    onChanged: (bool isOn) async {
                      if (isOn) {
                        await widget.sdk
                            .lockSession()
                            .onError((error, stackTrace) {
                          setState(() {
                            errorMessage = error.toString();
                          });
                          return false;
                        });
                      } else {
                        await widget.sdk
                            .unlockSession(parameters: <String, String>{
                          'title': 'SampleTitle',
                          'subtitle': 'SampleSubtitle',
                          'description': 'SampleDescription',
                        }).onError((error, stackTrace) {
                          setState(() {
                            errorMessage = error.toString();
                          });
                          return false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Text(errorMessage == '' ? '' : 'Error: - $errorMessage')
        ],
      ),
    );
  }
}
