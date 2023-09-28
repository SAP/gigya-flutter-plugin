import 'dart:async';
import 'dart:js_interop';
import 'dart:js_util';

import '../models/screenset_event.dart';
import 'static_interop/gigya_web_sdk.dart';
import 'static_interop/global_events/login_event.dart';
import 'static_interop/parameters/add_event_handlers_parameters.dart';
import 'static_interop/parameters/screenset_parameters.dart';
import 'static_interop/screenset_event/screenset_events.dart';

/// This typedef defines the function signature for the handler
/// of the screenset before screen load event.
typedef _BeforeScreenLoadEventHandler = Object? Function(ScreensetEvent event);

/// This typedef defines the function signature for the handler
/// of the screenset before submit event.
typedef _BeforeSubmitEventHandler = bool Function(ScreensetEvent event);

/// This typedef defines the function signature for the handler
/// of the screenset before validation event.
typedef _BeforeValidationEventHandler = Future<Map<String, Object?>?> Function(
  ScreensetEvent event,
);

/// This typedef defines the function signature for the handler
/// of the screenset error event.
typedef _ErrorEventHandler = Map<String, dynamic>? Function(ScreensetEvent event);

/// This class handles showing and hiding screensets for the web.
class WebScreensetDelegate {
  /// Create an instance of [WebScreensetDelegate].
  const WebScreensetDelegate();

  /// Clear any handlers for global events,
  /// that were set by [_setupHandlersForGlobalEvents].
  void _clearGlobalEventHandlers() {
    // Unset the handlers for the global events by setting them to null.
    GigyaWebSdk.instance.accounts.addEventHandlers.callAsFunction(
      null,
      AddEventHandlersParameters(),
    );
  }

  /// Create the parameters for showing a screenset.
  ///
  /// This method will also setup the handlers for the screenset events,
  /// using the specified functions in the [parameters].
  ShowScreensetParameters _createShowScreensetParameters(
    String screenSet,
    StreamController<ScreensetEvent> controller,
    Map<String, dynamic> parameters,
  ) {
    return ShowScreensetParameters(
      authFlow: parameters['authFlow'] as String? ?? 'popup',
      communicationLangByScreenSet: parameters['communicationLangByScreenSet'] as bool? ?? true,
      deviceType: parameters['deviceType'] as String? ?? 'desktop',
      dialogStyle: parameters['dialogStyle'] as String? ?? 'modern',
      enabledProviders: parameters['enabledProviders'] as String?,
      googlePlayAppID: parameters['googlePlayAppID'] as String?,
      lang: parameters['lang'] as String?,
      mobileScreenSet: parameters['mobileScreenSet'] as String?,
      redirectMethod: parameters['redirectMethod'] as String? ?? 'get',
      redirectURL: parameters['redirectURL'] as String?,
      regSource: parameters['regSource'] as String?,
      regToken: parameters['regToken'] as String?,
      screenSet: screenSet,
      sessionExpiration: parameters['sessionExpiration'] as int?,
      startScreen: parameters['startScreen'] as String?,
      onAfterScreenLoad: allowInterop((AfterScreenLoadEvent event) {
        if (!controller.isClosed) {
          controller.add(event.serialize());
        }
      }).toJS,
      onAfterSubmit: allowInterop((AfterSubmitEvent event) {
        if (!controller.isClosed) {
          controller.add(event.serialize());
        }
      }).toJS,
      onAfterValidation: allowInterop((AfterValidationEvent event) {
        if (!controller.isClosed) {
          controller.add(event.serialize());
        }
      }).toJS,
      onBeforeScreenLoad: allowInterop(
        (BeforeScreenLoadEvent event) {
          // Abort the screen load if the controller was closed.
          if (controller.isClosed) {
            return false;
          }

          final ScreensetEvent screensetEvent = event.serialize();

          controller.add(screensetEvent);

          final Object? handler = parameters['onBeforeScreenLoad'];

          // Continue loading the screen if no handler is set.
          if (handler is! _BeforeScreenLoadEventHandler) {
            return true;
          }

          final Object? result = handler(screensetEvent);

          // The handler decided that the screen should be loaded or not.
          // Just forward the result.
          if (result is bool) {
            return result;
          }

          // The handler can return a Map, which contains a `nextScreen` key.
          if (result case {'nextScreen': final String _}) {
            return result.jsify();
          }

          // The handler result is not valid, continue loading the screen.
          return true;
        },
      ).toJS,
      onBeforeSubmit: allowInterop(
        (BeforeSubmitEvent event) {
          // Abort the submission if the controller was closed.
          if (controller.isClosed) {
            return false;
          }

          final ScreensetEvent screensetEvent = event.serialize();

          controller.add(screensetEvent);

          final Object? handler = parameters['onBeforeSubmit'];

          if (handler is _BeforeSubmitEventHandler) {
            return handler(screensetEvent);
          }

          // If there is no handler, do not abort the submission.
          return true;
        },
      ).toJS,
      onBeforeValidation: allowInterop(
        (BeforeValidationEvent event) {
          if (controller.isClosed) {
            return Future<Map<String, Object?>?>.value().toJS;
          }

          final ScreensetEvent screensetEvent = event.serialize();

          controller.add(screensetEvent);

          final Object? handler = parameters['onBeforeValidation'];

          // Resolve with no value if there is no handler.
          // Otherwise the screenset will fail.
          if (handler is! _BeforeValidationEventHandler) {
            return Future<Map<String, Object?>?>.value().toJS;
          }

          // Resolve the Future with no value when the handler fails.
          // Otherwise the screenset will fail.
          return handler(screensetEvent).catchError(
            (Object error, StackTrace stackTrace) {
              return Future<Map<String, Object?>?>.value();
            },
          ).toJS;
        },
      ).toJS,
      onError: allowInterop(
        (ErrorEvent event) {
          if (controller.isClosed) {
            return null;
          }

          final ScreensetEvent screensetEvent = event.serialize();

          controller.add(screensetEvent);

          final Object? handler = parameters['onError'];

          if (handler is _ErrorEventHandler) {
            return handler(screensetEvent).jsify();
          }

          return null;
        },
      ).toJS,
      onFieldChanged: allowInterop((FieldChangedEvent event) {
        if (!controller.isClosed) {
          controller.add(event.serialize());
        }
      }).toJS,
      onHide: allowInterop((HideEvent event) {
        if (!controller.isClosed) {
          controller.add(event.serialize());
        }
      }).toJS,
      onSubmit: allowInterop((SubmitEvent event) {
        if (!controller.isClosed) {
          controller.add(event.serialize());
        }
      }).toJS,
    );
  }

  /// Setup the handlers for the global events.
  void _setupHandlersForGlobalEvents(
    StreamController<ScreensetEvent> controller,
  ) {
    GigyaWebSdk.instance.accounts.addEventHandlers.callAsFunction(
      null,
      AddEventHandlersParameters(
        onAfterResponse: allowInterop(
          (JSAny? event) {
            if (event == null || controller.isClosed) {
              return;
            }

            final Map<Object?, Object?> eventData = event.dartify() as Map<Object?, Object?>;

            controller.add(
              ScreensetEvent(
                eventData['eventName'] as String? ?? 'onAfterResponse',
                eventData.cast<String, Object?>(),
              ),
            );
          },
        ).toJS,
        onLogin: allowInterop(
          (LoginEvent event) {
            if (controller.isClosed) {
              return;
            }

            controller.add(ScreensetEvent('onLogin', event.toMap()));
          },
        ).toJS,
      ),
    );
  }

  /// Hide the screenset with the given [name].
  void hideScreenset(String name) {
    GigyaWebSdk.instance.accounts.hideScreenSet.callAsFunction(
      null,
      HideScreensetParameters(screenSet: name),
    );
  }

  /// Show the screenset with the given [name].
  ///
  /// The [parameters] are used to configure the screenset.
  Stream<ScreensetEvent> showScreenSet(
    String name, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    late StreamController<ScreensetEvent> controller;

    controller = StreamController<ScreensetEvent>.broadcast(onListen: () {
      // First setup the handlers for the global events.
      _setupHandlersForGlobalEvents(controller);

      GigyaWebSdk.instance.accounts.showScreenSet.callAsFunction(
        null,
        _createShowScreensetParameters(name, controller, parameters),
      );
    }, onCancel: () {
      // When the screenset subscription is cancelled,
      // clean up the global event handlers.
      // At most one screenset can be displayed at once.
      _clearGlobalEventHandlers();

      // Automatically hide the screenset when the last listener
      // of the stream cancels its subscription.
      hideScreenset(name);

      unawaited(controller.close());
    });

    return controller.stream;
  }
}
