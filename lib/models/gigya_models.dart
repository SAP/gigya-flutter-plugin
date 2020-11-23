class GigyaResponse {
  String _callId;
  int _statusCode = 200;
  int _errorCode = 0;
  String _errorDetails;
  String _statusReason;

  String get callId => _callId;

  int get statusCode => _statusCode;

  int get errorCode => _errorCode;

  String get errorDetails => _errorDetails;

  String get statusReason => _statusReason;

  GigyaResponse.fromJson(dynamic json) {
    _callId = json['callId'];
    _statusCode = json['statusCode'];
    _errorCode = json['errorCode'];
    _errorDetails = json['errorDetails'];
    _statusReason = json['statusReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['callID'] = _callId;
    data['statusCode'] = _statusCode;
    data['errorCode'] = _errorCode;
    data['errorDetails'] = _errorDetails;
    data['statusReason'] = _statusReason;
    return data;
  }
}
