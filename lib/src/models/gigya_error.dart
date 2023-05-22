import 'package:flutter/services.dart';

/// This class represents the base exception for errors thrown by the Gigya SDK.
class GigyaError implements Exception {
  /// The default constructor.
  const GigyaError({
    this.apiVersion,
    this.callId,
    this.errorCode,
    this.errorDetails,
    this.registrationToken,
    this.statusCode,
    this.statusReason,
  });

  /// Construct a [GigyaError] from the given [exception].
  factory GigyaError.fromPlatformException(PlatformException exception) {
    final Object? details = exception.details;

    if (details is! Map<Object?, Object?>) {
      return const GigyaError();
    }

    return GigyaError(
      apiVersion: details['apiVersion'] as int,
      callId: details['callId'] as String?,
      errorCode: details['errorCode'] as int?,
      errorDetails: details['errorDetails'] as String?,
      registrationToken: details['regToken'] as String?,
      statusCode: details['statusCode'] as int?,
      statusReason: details['statusReason'] as String?,
    );
  }

  /// The version number of the Gigya API.
  final int? apiVersion;

  /// The call id of the response.
  final String? callId;

  /// The Gigya error code of the response.
  final int? errorCode;

  /// The error details of the response.
  final String? errorDetails;

  /// The registration token.
  final String? registrationToken;

  /// The response status code.
  final int? statusCode;

  /// The reason for the given [statusCode].
  final String? statusReason;

  @override
  String toString() {
    return 'GigyaError('
        'errorCode: $errorCode, '
        'errorDetails: $errorDetails, '
        'statusCode: $statusCode, '
        'statusReason: $statusReason'
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
