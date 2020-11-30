import Flutter
import UIKit
import Gigya

public class SwiftGigyaFlutterPluginTyped<T: GigyaAccountProtocol> : NSObject, FlutterPlugin, GigyaInstanceProtocol {

    enum GigyaMethods: String {
        case getPlatformVersion
        case sendRequest
        case loginWithCredentials
        case registerWithCredentials
        case isLoggedIn
        case getAccount
        case setAccount
        case logOut
        case socialLogin
        case showScreenSet

    }
    var sdk: GigyaSdkWrapper<T>?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        // Stub. Not used.
        // Registering using non static register method.
    }
    
    public func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "gigya_flutter_plugin", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(self, channel: channel)
    }
    
    init(accountSchema: T.Type) {
        sdk = GigyaSdkWrapper(accountSchema: accountSchema)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let method = GigyaMethods(rawValue: call.method)
        switch method {
        case .getPlatformVersion:
            result("iOS " + UIDevice.current.systemVersion)
        case .sendRequest:
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
                return
            }
            sdk?.sendRequest(arguments: args, result: result)
        case .loginWithCredentials:
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
                return
            }
            sdk?.loginWithCredentials(arguments: args, result: result)
        case .registerWithCredentials:
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
                return
            }
            sdk?.registerWithCredentials(arguments: args, result: result)
        case .isLoggedIn:
            sdk?.isLoggedIn(result: result)
        case .getAccount:
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
                return
            }
            sdk?.getAccount(arguments: args, result: result)
        case .setAccount:
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
                return
            }
            sdk?.setAccount(arguments: args, result: result)
        case .logOut:
            sdk?.logOut(result: result)
        case .socialLogin:
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
                return
            }
            sdk?.socialLogin(arguments: args, result: result)
        case .showScreenSet:
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
                return
            }
            sdk?.showScreenSet(arguments: args, result: result)

        default:
            result(nil)
        }
        
    }
}
