import 'package:js/js.dart';

// TODO: refactor to extension type

/// This class represents the parameters for the `Accounts.hideScreenset` method.
@JS()
@anonymous
@staticInterop
class HideScreensetParameters {
  /// Construct a new [HideScreensetParameters] instance.
  external factory HideScreensetParameters({String screenSet});
}

/// This class represents the parameters for the `Accounts.showScreenset` method.
@JS()
@anonymous
@staticInterop
class ShowScreensetParameters {
  /// Construct a new [ShowScreensetParameters] instance.
  external factory ShowScreensetParameters({
    String? authFlow,
    bool? communicationLangByScreenSet,
    String? deviceType,
    String? dialogStyle,
    String? enabledProviders,
    String? googlePlayAppID,
    String? lang,
    String? mobileScreenSet,
    Object? Function(ErrorEvent event) onError,
    String? redirectMethod,
    String? redirectURL,
    String? regSource,
    String? regToken,
    String screenSet,
    int? sessionExpiration,
    String? startScreen,
  });
}
