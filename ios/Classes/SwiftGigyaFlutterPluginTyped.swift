import Flutter
import UIKit
import Gigya

@available(iOS 13.0, *)
public class SwiftGigyaFlutterPluginTyped<T: GigyaAccountProtocol> : NSObject, FlutterPlugin, GigyaInstanceProtocol {
    
    enum GigyaMethods: String {
        case getPlatformVersion
        case initSdk
        case sendRequest
        case loginWithCredentials
        case registerWithCredentials
        case isLoggedIn
        case getAccount
        case setAccount
        case setSession
        case logOut
        case socialLogin
        case showScreenSet
        case addConnection
        case removeConnection
        case sso
        // intteruptions cases
        case getConflictingAccounts
        case linkToSite
        case linkToSocial
        case resolveSetAccount
        case forgotPassword
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
        case .getPlatformVersion:
            result("iOS " + UIDevice.current.systemVersion)
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
        default:
            break
        }
        
        // Methods with arguments
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
            sdk?.showScreenSet(arguments: args, result: result)
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
        default:
            result(nil)
        }
        
    }
    
    
    
    deinit {
        print("[SwiftGigyaFlutterPluginTyped deinit]")
    }
}
