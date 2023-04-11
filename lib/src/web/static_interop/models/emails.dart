import 'dart:js_interop';

/// The extension type for the emails object.
@JS()
@anonymous
@staticInterop
extension type Emails._(JSObject _) {
  /// Create a new [Emails] instance.
  external factory Emails({
    JSArray unverified,
    JSArray verified,
  });

  @JS('unverified')
  external JSArray? get _unverified;

  @JS('verified')
  external JSArray? get _verified;

  /// The list of unverified email addresses.
  List<String> get unverified {
    return _unverified?.toDart.cast<String>() ?? const <String>[];
  }

  /// The list of verified email addresses.
  List<String> get verified {
    return _verified?.toDart.cast<String>() ?? const <String>[];
  }

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unverified': unverified,
      'verified': verified,
    };
  }
}
