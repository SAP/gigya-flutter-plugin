import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The account infromation page.
class AccountInformationPage extends StatefulWidget {
  /// Construct an [AccountInformationPage] widget using the given [sdk].
  const AccountInformationPage({required this.sdk, super.key});

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<AccountInformationPage> createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage>
    with WidgetsBindingObserver {
  final TextEditingController _firstNameController = TextEditingController();
  final GlobalKey<FormFieldState<String>> _firstNameKey = GlobalKey();
  bool _inProgress = false;

  late Future<Account> accountInformationFuture;

  Future<Account> _getAccountInformation() async {
    final Map<String, dynamic> result = await widget.sdk.getAccount();

    final Account account = Account.fromJson(result);

    // Set the initial value for the first name controller.
    _firstNameController.text = account.profile?.firstName ?? '';

    return account;
  }

  void _updateAccountInformation(BuildContext context, Account account) async {
    final FormFieldState<String>? firstNameField = _firstNameKey.currentState;

    if (firstNameField == null || !firstNameField.validate()) {
      return;
    }

    setState(() {
      _inProgress = true;
    });

    final String newFirstName = _firstNameController.text.trim();

    try {
      final Map<String, dynamic> result = await widget.sdk.setAccount(
        <String, dynamic>{'firstName': newFirstName},
      );

      print('Update account result: $result');

      if (mounted) {
        FocusScope.of(context).unfocus();
        setState(() {
          _inProgress = false;
        });
      }
    } catch (error) {
      print('Update account error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    accountInformationFuture = _getAccountInformation();
  }
  
  Widget _buildAccountInformationPage(BuildContext context, Account account) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _inProgress
              ? const LinearProgressIndicator(minHeight: 4)
              : const SizedBox(height: 4),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('UID:${account.uid}')),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Email:${account.profile?.email ?? 'No email for this account'}')),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Testing setAccount',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildFirstNameField(context, account),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildRegisterPasskeyButton(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildRevokePasskeyButton(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildGetAuthCodeButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstNameField(BuildContext context, Account account) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TextFormField(
            key: _firstNameKey,
            controller: _firstNameController,
            decoration: const InputDecoration(hintText: 'First Name'),
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'First name is required';
              }

              return null;
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => _updateAccountInformation(context, account),
          child: const Text('Update profile first name'),
        ),
      ],
    );
  }

  Widget _buildRegisterPasskeyButton() {
    return ElevatedButton(
      onPressed: () async {
        try {
          setState(() {
            _inProgress = true;
          });

          final Map<String, dynamic> result =
              await widget.sdk.webAuthenticationService.register();

          print('FIDO success, passkey registered');
          print(result);

          if (mounted) {
            setState(() {
              _inProgress = false;
            });
          }
        } catch (error) {
          print('FIDO error: $error');

          if (mounted) {
            setState(() {
              _inProgress = false;
            });
          }
        }
      },
      child: const Text('Register new Passkey'),
    );
  }

  Widget _buildRevokePasskeyButton() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          _inProgress = true;
        });

        try {
          final Map<String, dynamic> result =
              await widget.sdk.webAuthenticationService.revoke();

          print('FIDO success, passkey revoked');
          print(result);

          if (mounted) {
            setState(() {
              _inProgress = false;
            });
          }
        } catch (error) {
          print('FIDO error: $error');

          if (mounted) {
            setState(() {
              _inProgress = false;
            });
          }
        }
      },
      child: const Text('Revoke Passkey'),
    );
  }

  Widget _buildGetAuthCodeButton() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          _inProgress = true;
        });

        try {
          final String? result =
          await widget.sdk.getAuthCode();

          print('GetAuth code $result');

          if (mounted) {
            setState(() {
              _inProgress = false;
            });
          }
        } catch (error) {
          print('GetAuth error: $error');

          if (mounted) {
            setState(() {
              _inProgress = false;
            });
          }
        }
      },
      child: const Text('Get Auth Code'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account information'),
      ),
      body: FutureBuilder<Account>(
        future: accountInformationFuture,
        builder: (BuildContext context, AsyncSnapshot<Account> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('Fetching account...'),
                ],
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.error, color: Colors.red),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Could not fetch account information'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        accountInformationFuture = _getAccountInformation();

                        setState(() {});
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                );
              }

              final Account account = snapshot.data!;

              return _buildAccountInformationPage(context, account);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    super.dispose();
  }
}
