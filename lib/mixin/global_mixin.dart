
import 'package:flutter/services.dart';

import '../gigya_flutter_plugin.dart';

mixin DataMixin {
  /// Mapping communication error structure.
  Map<String, dynamic> decodeError(PlatformException error) {
    if (error.details != null && error.details is Map<dynamic, dynamic>) {
      final mapped = error.details.cast<String, dynamic>();
      return mapped;
    }
    return {};
  }
}

mixin GigyaResponseMixin {
  /// Specific timeout logic for specific methods.
  Duration getTimeout(Methods method) {
    switch (method) {
      case Methods.socialLogin:
      case Methods.addConnection:
        return Duration(minutes: 5);
      default:
        return Duration(minutes: 1);
    }
  }

  /// Genetic timeout error.
  Map<String, dynamic> timeoutError() => {
    'statusCode': 500,
    'errorCode': 504002,
    'errorDetails': 'A timeout that was defined in the request is reached',
  };
}