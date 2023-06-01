import 'package:flutter/services.dart';

/// This class represents the base exception for errors thrown by the Gigya SDK.
class GigyaError implements Exception {
  /// The default constructor.
  const GigyaError({
    this.apiVersion,
    this.callId,
    this.details = const <String, Object?>{},
    this.errorCode,
    this.errorMessage,
  });

  /// Construct a [GigyaError] from the given [exception].
  factory GigyaError.fromPlatformException(PlatformException exception) {
    final Object? details = exception.details;

    if (details is! Map<Object?, Object?>) {
      return const GigyaError();
    }

    // Remove the specific error details, to avoid including them twice.
    final int apiVersion = details.remove('apiVersion') as int;
    final String? callId = details.remove('callId') as String?;
    final int? errorCode = details.remove('errorCode') as int?;
    final String? errorMessage = details.remove('errorMessage') as String? ??
        details.remove('errorDetails') as String?;

    return GigyaError(
      apiVersion: apiVersion,
      callId: callId,
      details: details.cast<String, Object?>(),
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  /// The version number of the Gigya API.
  final int? apiVersion;

  /// The call id of the response.
  final String? callId;

  /// The additional error details.
  final Map<String, Object?> details;

  /// The Gigya error code of the response.
  final int? errorCode;

  /// The error message for the given [errorCode].
  ///
  /// This is typically only an error message.
  ///
  /// This will contain the `errorMessage` from the underlying error,
  /// or the `errorDetails` if the error message is not available.
  final String? errorMessage;

  /// Get the registration token from the error.
  ///
  /// This is null if the registration token is not available.
  String? get registrationToken => details['regToken'] as String?;

  @override
  String toString() {
    return 'GigyaError('
        'apiVersion: $apiVersion, '
        'callId: $callId, '
        'details: $details, '
        'errorCode: $errorCode, '
        'errorMessage: $errorMessage, '
        ')';
  }
}

/// This class defines a timeout error for Gigya SDK API responses.
class GigyaTimeoutError implements Exception {
  /// The default constructor.
  const GigyaTimeoutError();

  /// The Gigya error code for the request that timed out.
  final int errorCode = 504002;

  /// The error message for the timeout.
  final String message = 'The request timed out.';

  /// The HTTP status code of the API request that timed out.
  final int statusCode = 500;

  @override
  String toString() {
    return 'GigyaTimeoutError('
        'errorCode: $errorCode, '
        'message: $message, '
        'statusCode: $statusCode'
        ')';
  }
}
