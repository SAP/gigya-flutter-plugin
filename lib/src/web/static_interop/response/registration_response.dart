import 'response.dart';

/// The static interop class for the Gigya InitRegistration API response.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4136cef070b21014bbc5a10ce4041860.html?locale=en-US#response-example
class InitRegistrationResponse extends Response {
  /// The registration token for the registration.
  external String? get regToken;
}
