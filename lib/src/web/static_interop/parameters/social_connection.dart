import 'dart:js_interop';

import '../response/social_connection_response.dart';

/// This extension type represents the parameters for the `Socialize.addConnection` method.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/417376f070b21014bbc5a10ce4041860.html#parameters
@JS()
@anonymous
@staticInterop
extension type AddSocialConnectionParameters._(JSObject _) implements JSObject {
  /// Create a new [AddSocialConnectionParameters] instance.
  /// 
  /// The [callback] function receives a [SocialConnectionResponse] as argument
  /// and has [JSVoid] as return type.
  external factory AddSocialConnectionParameters({
    String? authFlow,
    JSFunction callback,
    String? extraFields,
    String? facebookExtraPermissions,
    bool? forceAuthentication,
    String? googleExtraPermissions,
    String provider,
    String? redirectMethod,
    String? redirectURL,
    int? sessionExpiration,
  });
}

/// This extension type represents the parameters for the `Socialize.removeConnection` method.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4177c60370b21014bbc5a10ce4041860.html#parameters
@JS()
@anonymous
@staticInterop
extension type RemoveSocialConnectionParameters._(JSObject _) implements JSObject {
  /// Create a new [RemoveSocialConnectionParameters] instance.
  /// 
  /// The [callback] function receives a [SocialConnectionResponse] as argument
  /// and has [JSVoid] as return type.
  external factory RemoveSocialConnectionParameters({
    JSFunction callback,
    String provider,
    bool? forceProvidersLogout,
    String? lastIdentityHandling,
    bool? removeLoginID,
  });
}
