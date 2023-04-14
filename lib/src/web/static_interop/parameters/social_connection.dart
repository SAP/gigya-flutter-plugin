import 'package:js/js.dart';

import '../response/social_connection_response.dart';

/// This class represents the parameters for the `Socialize.addConnection` method.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/417376f070b21014bbc5a10ce4041860.html#parameters
@JS()
@anonymous
@staticInterop
class AddSocialConnectionParameters {
  /// Create a new [AddSocialConnectionParameters] instance.
  external factory AddSocialConnectionParameters({
    String? authFlow,
    void Function(SocialConnectionResponse response) callback,
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

/// This class represents the parameters for the `Socialize.removeConnection` method.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4177c60370b21014bbc5a10ce4041860.html#parameters
@JS()
@anonymous
@staticInterop
class RemoveSocialConnectionParameters {
  /// Create a new [RemoveSocialConnectionParameters] instance.
  external factory RemoveSocialConnectionParameters({
    void Function(SocialConnectionResponse response) callback,
    String provider,
    bool? forceProvidersLogout,
    String? lastIdentityHandling,
    bool? removeLoginID,
  });
}
