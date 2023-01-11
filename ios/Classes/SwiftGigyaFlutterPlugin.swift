import Flutter
import UIKit
import Gigya

public class SwiftGigyaFlutterPlugin<T: GigyaAccountProtocol>: NSObject, FlutterPlugin, FlutterStreamHandler, GigyaInstanceProtocol, ScreenSetEventDelegate {
    var sdk: GigyaSdkWrapper<T>?

    var screenSetsEventsSink: FlutterEventSink?

    func addScreenSetError(error: FlutterError) {
        screenSetsEventsSink?(error)
    }

    func addScreenSetEvent(event: [String, Any?]) {
        screenSetsEventsSink?(event)
    }

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        screenSetsEventsSink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        screenSetsEventsSink = nil
        return nil
    }

    // TODO: let register(with registrar: FlutterPluginRegistrar) handle a default registration
    // TODO: provide a mechanism to register a custom scheme

    public static func register(with registrar: FlutterPluginRegistrar) {
        // This method is a stub and does not actually register the plugin,
        // as it needs a `GigyaAccountProtocol` type to be registered with.
        // Instead, manually register the plugin using `registerForAccountProtocol`
        // with your implementation of `GigyaAccountProtocol`. 
    }

    public static func registerForAccountProtocol<T: GigyaAccountProtocol>(registrar: FlutterPluginRegistrar, accountSchema: T.Type) {
        let channel = FlutterMethodChannel(name: "com.sap.gigya_flutter_plugin/methods", binaryMessenger: registrar.messenger())
        let screenSetEventsChannel = FlutterEventChannel(name: "com.sap.gigya_flutter_plugin/screenSetEvents", binaryMessenger: registrar.messenger())
        let instance = SwiftGigyaFlutterPlugin(accountSchema: accountSchema)

        registrar.addMethodCallDelegate(instance, channel: channel)
        screenSetEventsChannel.setStreamHandler(instance)
    }

    init(accountSchema: T.Type) {
        sdk = GigyaSdkWrapper(accountSchema: accountSchema)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let method = GigyaMethods(rawValue: call.method)

        // Methods without arguments.
        switch method {
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

    enum GigyaMethods: String {
        case initSdk
        case sendRequest
        case loginWithCredentials
        case registerWithCredentials
        case isLoggedIn
        case getAccount
        case setAccount
        case getSession
        case setSession
        case logOut
        case socialLogin
        case showScreenSet
        case addConnection
        case removeConnection
        case sso
        // interruption cases
        case getConflictingAccounts
        case linkToSite
        case linkToSocial
        case resolveSetAccount
        case forgotPassword
        // webauthn
        case webAuthnLogin
        case webAuthnRegister
        case webAuthnRevoke
        // otp
        case otpLogin
        case otpUpdate
        case otpVerify
    }
}