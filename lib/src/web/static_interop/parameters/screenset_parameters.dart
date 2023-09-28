import 'dart:js_interop';

import '../../static_interop/screenset_event/screenset_events.dart';

/// The extension type that defines the parameters
/// for the `Accounts.hideScreenset` method.
@JS()
@anonymous
@staticInterop
extension type HideScreensetParameters._(JSObject _) implements JSObject {
  /// Construct a new [HideScreensetParameters] instance.
  /// 
  /// The given [screenSet] is the name of the screen set to hide.
  external factory HideScreensetParameters({String screenSet});
}

// TODO: move DartDoc comments for the ShowScreensetParameters function arguments
// The function arguments have some documentation, which is only relevant for the constructor,
// since the type has no fields. However, DartDoc does not yet support documenting constructor arguments.
//
// See https://github.com/dart-lang/dartdoc/issues/1259

/// The extension type that defines the parameters
/// for the `Accounts.showScreenset` method.
@JS()
@anonymous
@staticInterop
extension type ShowScreensetParameters._(JSObject _) implements JSObject {
  /// Construct a new [ShowScreensetParameters] instance.
  /// 
  /// The [onAfterScreenLoad] function receives an [AfterScreenLoadEvent] as argument,
  /// and has [JSVoid] as return type.
  /// 
  /// The [onAfterSubmit] function receives an [AfterSubmitEvent] as argument,
  /// and has [JSVoid] as return type.
  /// 
  /// The [onAfterValidation] function receives an [AfterValidationEvent] as argument,
  /// and has [JSVoid] as return type.
  /// 
  /// The [onBeforeScreenLoad] function receives a [BeforeScreenLoadEvent] as argument,
  /// and has a nullable [JSAny] as return type.
  /// 
  /// The [onBeforeSubmit] function receives a [BeforeSubmitEvent] as argument,
  /// and has a boolean as return type.
  /// 
  /// The [onBeforeValidation] function receives a [BeforeValidationEvent] as argument,
  /// and has a nullable [JSAny] as return type.
  /// 
  /// The [onError] function receives an [ErrorEvent] as argument,
  /// and has a nullable [JSAny] as return type.
  /// 
  /// The [onFieldChanged] function receives a [FieldChangedEvent] as argument,
  /// and has [JSVoid] as return type.
  /// 
  /// The [onHide] function receives a [HideEvent] as argument,
  /// and has [JSVoid] as return type.
  /// 
  /// The [onSubmit] function receives a [SubmitEvent] as argument,
  /// and has [JSVoid] as return type.
  external factory ShowScreensetParameters({
    String? authFlow,
    bool? communicationLangByScreenSet,
    String? deviceType,
    String? dialogStyle,
    String? enabledProviders,
    String? googlePlayAppID,
    String? lang,
    String? mobileScreenSet,
    JSFunction onAfterScreenLoad,
    JSFunction onAfterSubmit,
    JSFunction onAfterValidation,
    JSFunction onBeforeScreenLoad,
    JSFunction onBeforeSubmit,
    JSFunction onBeforeValidation,
    JSFunction onError,
    JSFunction onFieldChanged,
    JSFunction onHide,
    JSFunction onSubmit,
    String? redirectMethod,
    String? redirectURL,
    String? regSource,
    String? regToken,
    String screenSet,
    int? sessionExpiration,
    String? startScreen,
  });
}
