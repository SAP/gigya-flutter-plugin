import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The Biometrics page.
class BiometricsPage extends StatefulWidget {
  /// Construct a [BiometricsPage] with the given [sdk].
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

  void initializeBiometricState() async {
    isLocked = await widget.sdk.biometricService.isLocked();
    isOptIn = await widget.sdk.biometricService.isOptIn();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    initializeBiometricState();
  }

  void _handleOptIn() async {
    try {
      await widget.sdk.biometricService.optIn(
        parameters: <String, String>{
          'title': 'SampleTitle',
          'subtitle': 'SampleSubtitle',
          'description': 'SampleDescription',
        },
      );
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
        });
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _handleOptOut() async {
    try {
      await widget.sdk.biometricService.optOut(
        parameters: <String, String>{
          'title': 'SampleTitle',
          'subtitle': 'SampleSubtitle',
          'description': 'SampleDescription',
        },
      );
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
        });
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _handleLockSession() async {
    try {
      await widget.sdk.biometricService.lockSession();
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
        });
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _handleUnlockSession() async {
    try {
      await widget.sdk.biometricService.unlockSession(
        parameters: <String, String>{
          'title': 'SampleTitle',
          'subtitle': 'SampleSubtitle',
          'description': 'SampleDescription',
        },
      );
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
        });
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
            trailing: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Switch(
                    value: isOptIn,
                    onChanged: (bool isOn) async {
                      isOn ? _handleOptIn() : _handleOptOut();
                    },
                  ),
                ),
              ],
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
            trailing: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Switch(
                    value: isLocked,
                    onChanged: (bool isOn) async {
                      isOn ? _handleLockSession() : _handleUnlockSession();
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(errorMessage == '' ? '' : 'Error: - $errorMessage')
        ],
      ),
    );
  }
}
