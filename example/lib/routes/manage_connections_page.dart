import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The manage connections page.
class ManageConnectionsPage extends StatefulWidget {
  /// Construct a [ManageConnectionsPage] with the given [sdk].
  const ManageConnectionsPage({required this.sdk, super.key});

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<ManageConnectionsPage> createState() => _ManageConnectionsPageState();
}

class _ManageConnectionsPageState extends State<ManageConnectionsPage> {
  late Future<Account> accountInformationFuture;

  void _addConnection() async {
    try {
      final Map<String, dynamic> result = await widget.sdk.addConnection(
        SocialProvider.facebook,
      );

      print('Social connection added: $result');

      if (mounted) {
        accountInformationFuture = _getAccountInformation();

        setState(() {});
      }
    } catch (error) {
      print('Failed to add social connection: $error');
    }
  }

  void _removeConnection() async {
    try {
      final Map<String, dynamic> result = await widget.sdk.removeConnection(
        SocialProvider.facebook,
      );

      print('Social connection removed: $result');

      if (mounted) {
        accountInformationFuture = _getAccountInformation();

        setState(() {});
      }
    } catch (error) {
      print('Failed to remove social connection: $error');
    }
  }

  Future<Account> _getAccountInformation() async {
    final Map<String, dynamic> result = await widget.sdk.getAccount(
      invalidate: true,
    );

    return Account.fromJson(result);
  }

  @override
  void initState() {
    super.initState();
    accountInformationFuture = _getAccountInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage connections'),
      ),
      body: FutureBuilder<Account>(
        future: accountInformationFuture,
        builder: (BuildContext context, AsyncSnapshot<Account> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
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

              return Column(
                children: <Widget>[
                  const Text('Social connections for this account'),
                  Expanded(
                    child: account.socialProviders.isEmpty
                        ? const Center(
                            child: Text(
                              'No social connections for this account',
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (_, int index) => Text(account.socialProviders[index]),
                            itemCount: account.socialProviders.length,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: _addConnection,
                      child: const Text('Add connection (Facebook)'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      onPressed: _removeConnection,
                      child: const Text('Remove connection (Facebook)'),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
