import Flutter
import UIKit
import Gigya

public class SwiftGigyaFlutterPluginTyped<T: GigyaAccountProtocol> : NSObject, FlutterPlugin, FlutterStreamHandler, GigyaInstanceProtocol, ScreenSetEventDelegate {
    /// The internal Gigya SDK instance.
    var sdk: GigyaSdkWrapper<T>?

    init(accountSchema: T.Type) {
        sdk = GigyaSdkWrapper(accountSchema: accountSchema)
    }    

    // MARK: - ScreenSet events

    /// The event sink for the ScreenSet events.
    var screenSetsEventsSink: FlutterEventSink?

    func addScreenSetEvent(event: [String: Any?]) {
        screenSetsEventsSink?(event)
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        screenSetsEventsSink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        screenSetsEventsSink = nil
        return nil
    }

    // MARK: - Plugin Registration

    public static func register(with registrar: FlutterPluginRegistrar) {
        // This method is a stub and does not register the plugin with the plugin registry.
        // To register the plugin, call the `register()` instance method on an instance of this class.
    }

    public func register(with registrar: FlutterPluginRegistrar) {
        let methodChannel = FlutterMethodChannel(name: "com.sap.gigya_flutter_plugin/methods", binaryMessenger: registrar.messenger())
        let screenSetEventsChannel = FlutterEventChannel(name: "com.sap.gigya_flutter_plugin/screenSetEvents", binaryMessenger: registrar.messenger())

        registrar.addMethodCallDelegate(self, channel: methodChannel)
        screenSetEventsChannel.setStreamHandler(self)
    }

    // MARK: - Method Call Handler implementation

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let method = GigyaSdkMethods(rawValue: call.method)

        // Methods without arguments.
        switch method {
        case .dismissScreenSet:
            sdk?.dismissScreenSet(result: result)
            return
        case .isLoggedIn:
            sdk?.isLoggedIn(result: result)
            return
        case .logOut:
            sdk?.logOut(result: result)
            return
        case .getConflictingAccounts:
            sdk?.resolveGetConflictingAccounts(result: result)
            return
        case .getSession:
            sdk?.getSession(result: result)
            return
        case .biometricIsAvailable:
            sdk?.biometricIsAvailable(result: result)
            return
        case .biometricIsLocked:
            sdk?.biometricIsLocked(result: result)
            return
        case .biometricIsOptIn:
            sdk?.biometricIsOptIn(result: result)
            return
        case .biometricOptIn:
            sdk?.biometricOptIn(result: result)
            return
        case .biometricOptOut:
            sdk?.biometricOptOut(result: result)
            return
        case .biometricLockSession:
            sdk?.biometricLockSession(result: result)
            return
        case .biometricUnlockSession:
            sdk?.biometricUnlockSession(result: result)
            return
        case .getAuthCode:
            sdk?.getAuthCode(result: result)
            return
        default:
            break
        }

        // Methods with arguments.
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
            return
        }

        switch method {
        case .sendRequest:
            sdk?.sendRequest(arguments: args, result: result)
        case .loginWithCredentials:
            sdk?.loginWithCredentials(arguments: args, result: result)
        case .registerWithCredentials:
            sdk?.registerWithCredentials(arguments: args, result: result)
        case .getAccount:
            sdk?.getAccount(arguments: args, result: result)
        case .setAccount:
            sdk?.setAccount(arguments: args, result: result)
        case .setSession:
            sdk?.setSession(arguments: args, result: result)
        case .socialLogin:
            sdk?.socialLogin(arguments: args, result: result)
        case .showScreenSet:
            sdk?.showScreenSet(arguments: args, result: result, handler: self)
        case .addConnection:
            sdk?.addConnection(arguments: args, result: result)
        case .removeConnection:
            sdk?.removeConnection(arguments: args, result: result)
        case .linkToSite:
            sdk?.resolveLinkToSite(arguments: args, result: result)
        case .linkToSocial:
            sdk?.resolveLinkToSocial(arguments: args, result: result)
        case .resolveSetAccount:
            sdk?.resolveSetAccount(arguments: args, result: result)
        case .forgotPassword:
            sdk?.forgotPassword(arguments: args, result: result)
        case .initSdk:
            sdk?.initSdk(arguments: args, result: result)
        case .sso:
            sdk?.sso(arguments: args, result: result)
        case .webAuthnLogin:
            sdk?.webAuthnLogin(result: result)
        case .webAuthnRegister:
            sdk?.webAuthnRegister(result: result)
        case .webAuthnRevoke:
            sdk?.webAuthnRevoke(result: result)
        case .otpLogin:
            sdk?.otpLogin(arguments: args, result: result)
        case .otpUpdate:
            sdk?.otpUpdate(arguments: args, result: result)
        case .otpVerify:
            sdk?.verifyOtp(arguments: args, result: result)
        default:
            result(nil)
        }                  
    }
}
