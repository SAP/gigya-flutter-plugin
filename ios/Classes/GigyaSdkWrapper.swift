import Gigya

public class GigyaSdkWrapper<T: GigyaAccountProtocol> :GigyaInstanceProtocol {

    let sdk: GigyaCore<T>?
    
    init(accountSchema: T.Type) {
        // Initializing the Gigya SDK instance.
        sdk = Gigya.sharedInstance(accountSchema)
    }
    
    /**
     Send general/antonymous request
     */
    
    func sendRequest(arguments: [String: Any], result: @escaping FlutterResult) {
        guard let endpoint = arguments["endpoint"] as? String else {
            result(FlutterError(code: PluginErrors.MISSING_PARAMETER_ERROR, message: PluginErrors.MISSING_PARAMETER_MESSAGE, details: nil))
            return
        }
        guard let parameters = arguments["parameters"] as? [String:Any] else {
            result(FlutterError(code: PluginErrors.MISSING_PARAMETER_ERROR, message: PluginErrors.MISSING_PARAMETER_MESSAGE, details: nil))
            return
        }
        sdk?.send(api: endpoint, params: parameters) { (gigyaResponse) in
            switch gigyaResponse {
            case .success(let data):
                let json = data.mapValues { $0.value }.asJson
                result(json)
            case .failure(let error):
                switch error {
                case .gigyaError(let d):
                    result(FlutterError(code: "\(d.errorCode)", message: d.errorMessage, details: d.toDictionary()))
                default:
                    result(FlutterError(code: PluginErrors.GENERAL_ERROR, message: PluginErrors.GENERAL_ERROR_MESSAGE, details: nil))
                }
            }
        }
    }
    
    /**
     Login using credentials (loginId/password combination with optional parameter map).
     */
    func loginWithCredentials(arguments: [String: Any], result: @escaping FlutterResult) {
        guard let loginId = arguments["loginId"] as? String else {
            result(FlutterError(code: PluginErrors.MISSING_PARAMETER_ERROR, message: PluginErrors.MISSING_PARAMETER_MESSAGE, details: nil))
            return
        }
        guard let password = arguments["password"] as? String else {
            result(FlutterError(code: PluginErrors.MISSING_PARAMETER_ERROR, message: PluginErrors.MISSING_PARAMETER_MESSAGE, details: nil))
            return
        }
        // Optional parameter map.
        let parameters = arguments["parameters"] as? [String: Any] ?? [:]
        sdk?.login(loginId: loginId, password: password, params: parameters) { [weak self] loginResult in
            switch loginResult {
            case .success(let data):
                let mapped = self?.mapAccountObject(account: data)
                result(mapped)
            case .failure(let error):
                switch error.error {
                case .gigyaError(let ge):
                    result(FlutterError(code: "\(ge.errorCode)", message: ge.errorMessage, details: ge.toDictionary()))
                default:
                    break;
                }
            }
        }
    }
    
    /**
     Register a new user using credentials (email/password combination with optional parameter map).
     */
    func registerWithCredentials(arguments: [String: Any], result: @escaping FlutterResult) {
        guard let email = arguments["email"] as? String else {
            result(FlutterError(code: PluginErrors.MISSING_PARAMETER_ERROR, message: PluginErrors.MISSING_PARAMETER_MESSAGE, details: nil))
            return
        }
        guard let password = arguments["password"] as? String else {
            result(FlutterError(code: PluginErrors.MISSING_PARAMETER_ERROR, message: PluginErrors.MISSING_PARAMETER_MESSAGE, details: nil))
            return
        }
        // Optional parameter map.
        let parameters = arguments["parameters"] as? [String: Any] ?? [:]
        sdk?.register(email: email, password: password, params: parameters) { [weak self] loginResult in
            switch loginResult {
            case .success(let data):
                let mapped = self?.mapAccountObject(account: data)
                result(mapped)
            case .failure(let error):
                switch error.error {
                case .gigyaError(let ge):
                    result(FlutterError(code: "\(ge.errorCode)", message: ge.errorMessage, details: ge.toDictionary()))
                default:
                    break;
                }
            }
        }
    }
    
    /**
     Check login status.
     */
    func isLoggedIn(result: @escaping FlutterResult) {
        let logInState = sdk?.isLoggedIn() ?? false
        result(logInState)
    }
    
    /**
     Request active account.
     */
    func getAccount(arguments: [String: Any], result: @escaping FlutterResult) {
        // Optionals.
        let clearCache = arguments["invalidate"] as? Bool ?? false
        let parameters = arguments["parameters"] as? [String: Any] ?? [:]
        sdk?.getAccount(clearCache, params: parameters) { [weak self] accountResult in
            switch accountResult {
            case .success(let data):
                let mapped = self?.mapAccountObject(account: data)
                result(mapped)
            case .failure(let error):
                switch error {
                case .gigyaError(let d):
                    result(FlutterError(code: "\(d.errorCode)", message: d.errorMessage, details: d.toDictionary()))
                default:
                    result(FlutterError(code: "", message: error.localizedDescription, details: nil))
                }
            }
        }
    }
    
    /**
     Update account information
     */
    func setAccount(arguments: [String: Any], result: @escaping FlutterResult) {
        let account = arguments["account"] as? [String: Any] ?? [:]
        sdk?.setAccount(with: account, completion: { [weak self] accountResult in
            switch accountResult {
            case .success(let data):
                let mapped = self?.mapAccountObject(account: data)
                result(mapped)
            case .failure(let error):
                switch error {
                case .gigyaError(let d):
                    result(FlutterError(code: "\(d.errorCode)", message: d.errorMessage, details: d.toDictionary()))
                default:
                    result(FlutterError(code: "", message: error.localizedDescription, details: nil))
                }
            }
        })
    }
    
    /**
     Logout of existing session.
     */
    func logOut(result: @escaping FlutterResult) {
        sdk?.logout(completion: { gigyaResponse in
            switch gigyaResponse {
            case .success( _):
                result(nil)
            case .failure(let error):
                switch error {
                case .gigyaError(let d):
                    result(FlutterError(code: "\(d.errorCode)", message: d.errorMessage, details: d.toDictionary()))
                default:
                    result(FlutterError(code: "", message: error.localizedDescription, details: nil))
                }
            }
        })
    }
    
    /**
     Social login with given provider & provider sessions.
     */
    func socialLogin(arguments: [String: Any], result: @escaping FlutterResult) {
        
    }

    /**
     Mapping typed account object.
     */
    func mapAccountObject(account: T) -> [String: Any] {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(account)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: [])
                as? [String: Any]
            return dictionary ?? [:]
        } catch {
            print(error)
        }
        return [:]
    }
}

/**
 Plugin specific error constants.
 */
public class PluginErrors {
    
    static let GENERAL_ERROR = "700"
    static let GENERAL_ERROR_MESSAGE = "general error"
    static let MISSING_PARAMETER_ERROR = "701"
    static let MISSING_PARAMETER_MESSAGE = "request parameter missing"
}

extension Dictionary {
    
    var asJson: String {
        if let jsonData: Data = try? JSONSerialization.data(withJSONObject: self, options:[]),
            let result = String(data: jsonData, encoding: .utf8) {
            return result
        }
        return ""
    }
}
