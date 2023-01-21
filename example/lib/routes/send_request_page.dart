import 'package:flutter/material.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

/// The send request page widget.
class SendRequestPage extends StatefulWidget {
  /// Construct a [SendRequestPage] widget using the given [sdk].
  const SendRequestPage({required this.sdk, super.key});

  /// The [GigyaSdk] instance that is used by this widget.
  final GigyaSdk sdk;

  @override
  State<SendRequestPage> createState() => _SendRequestPageState();
}

class _SendRequestPageState extends State<SendRequestPage> {
  final TextEditingController _controller = TextEditingController();

  String _requestResult = '';
  bool _inProgress = false;

  void _sendRequest(String loginId) async {
    setState(() {
      _inProgress = true;
    });

    try {
      final Map<String, dynamic> result = await widget.sdk.send(
        'accounts.isAvailableLoginID',
        parameters: <String, dynamic>{'loginID': loginId},
      );

      final bool isAvailable = result['isAvailable'] as bool? ?? false;

      if (mounted) {
        setState(() {
          _requestResult =
              'Requested login id is ${isAvailable ? '' : 'not'} available.';
          _inProgress = false;
        });
      }
    } catch (error) {
      print('send request error: \n\n $error');

      if (mounted) {
        setState(() {
          _inProgress = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send request'),
      ),
      body: Column(
        children: <Widget>[
          _inProgress
              ? const LinearProgressIndicator(minHeight: 4)
              : const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Testing endpoint: accounts.isAvailableLoginID',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter login id'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (
                BuildContext context,
                TextEditingValue value,
                Widget? child,
              ) {
                return ElevatedButton(
                  onPressed: _inProgress || value.text.trim().isEmpty
                      ? null
                      : () => _sendRequest(value.text.trim()),
                  child: const Text('Send Request'),
                );
              },
            ),
          ),
          Text(
            _requestResult,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
