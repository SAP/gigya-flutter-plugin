import 'package:flutter/services.dart';

/// This mixin defines a method to decode the details of a [PlatformException].
///
/// It also defines a
mixin ErrorMixin {
  /// Get the error details from the given [PlatformException].
  Map<String, dynamic> getErrorDetails(PlatformException error) {
    // Upcast to Object? because with dynamic there are no type checks,
    // which also prevents type promotion.
    final Object? details = error.details as Object?;

    if (details is Map<String, dynamic>) {
      return details;
    }

    return const <String, dynamic>{};
  }

  /// Construct a timeout error.
  Map<String, dynamic> get timeoutError {
    return const <String, dynamic>{
      'statusCode': 500,
      'errorCode': 504002,
      'errorDetails': 'A timeout that was defined in the request is reached',
    };
  }
}
