/// This class defines the base response from a Gigya SDK result.
class GigyaResponse {
  /// The default constructor.
  const GigyaResponse({
    this.apiVersion,
    this.callId,
    this.errorCode,
    this.errorDetails,
    this.registrationToken,
    this.statusCode,
    this.statusReason,
  });

  /// Convert the given [json] into a Gigya response.
  factory GigyaResponse.fromJson(Map<String, dynamic> json) {
    final String? errorDetails = json['errorDetails'] as String?;
    final String? localizedMessage = json['localizedMessage'] as String?;

    return GigyaResponse(
      apiVersion: json['apiVersion'] as int?,
      callId: json['callId']?.toString(),
      errorCode: json['errorCode'] as int?,
      errorDetails: errorDetails ?? localizedMessage,
      registrationToken: json['regToken'] as String?,
      statusCode: json['statusCode'] as int?,
      statusReason: json['statusReason'] as String?,
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

  /// Convert this response into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'callID': callId,
      'statusCode': statusCode,
      'errorCode': errorCode,
      'errorDetails': errorDetails,
      'statusReason': statusReason,
      'apiVersion': apiVersion,
      'regToken': registrationToken,
    };
  }
}
