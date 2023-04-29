import 'package:js/js.dart';

// TODO: remove when `futureToPromise` is implemented in the SDK.

/// This class represents the static interop definition for the `Promise` class.
/// Once the Dart SDK adds its own static interop definition to fill this gap,
/// then this class can be removed.
///
/// See https://github.com/dart-lang/sdk/issues/49048#issuecomment-1528742873 for context.
@JS()
@staticInterop
class Promise {
  /// Create a new [Promise].
  external factory Promise(
    void Function(Promise? Function(Object?) resolve, Promise? Function(Object?) reject) executor,
  );
}
