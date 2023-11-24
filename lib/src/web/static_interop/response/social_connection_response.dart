import 'dart:js_interop';

import '../models/profile.dart';
import 'response.dart';

/// The extension type for the Gigya add/remove social connection API response.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/417376f070b21014bbc5a10ce4041860.html#response-object-data-members
@JS()
@anonymous
@staticInterop
extension type SocialConnectionResponse(Response baseResponse) {
  /// The user object with updated information about the current user.
  ///
  /// In the web SDK, the `User` and `Profile` objects share the same shape.
  external Profile get user;

  /// Convert this response to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
    };
  }
}
