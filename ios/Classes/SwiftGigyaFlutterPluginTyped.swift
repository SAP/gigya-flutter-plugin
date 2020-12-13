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
        case addConnection
        case removeConnection
        // intteruptions cases
        case getConflictingAccounts
        case linkToSite
        case linkToScoial
        case resolveSetAccount
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

        // Methods without arguments
        switch method {
        case .isLoggedIn:
            sdk?.isLoggedIn(result: result)
            return
        case .logOut:
            sdk?.logOut(result: result)
            return
        default:
            break
        }

        // Methods with arguments
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
            return
        }

        switch method {
        case .getPlatformVersion:
            result("iOS " + UIDevice.current.systemVersion)
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
        case .socialLogin:
            sdk?.socialLogin(arguments: args, result: result)
        case .showScreenSet:
            sdk?.showScreenSet(arguments: args, result: result)
        case .addConnection:
            sdk?.addConnection(arguments: args, result: result)
        case .removeConnection:
            sdk?.removeConnection(arguments: args, result: result)
        case .getConflictingAccounts:
            sdk?.resolveGetConflictingAccounts(arguments: args, result: result)
        case .linkToSite:
            sdk?.resolveLinkToSite(arguments: args, result: result)
        case .linkToScoial:
            sdk?.resolveLinkToSocial(arguments: args, result: result)
        default:
            result(nil)
        }
        
    }
}
