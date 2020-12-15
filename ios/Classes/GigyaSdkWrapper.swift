import Gigya

/**
 Plugin specific error constants.
 */
public class PluginErrors {
    static let generalError = "700"
    static let generalErrorMessage = "general error"
    static let missingParameterError = "701"
    static let missingParameterMessage = "request parameter missing"
}

public class GigyaSdkWrapper<T: GigyaAccountProtocol> :GigyaInstanceProtocol {

    let sdk: GigyaCore<T>?

    let resolverHelper: ResolverHelper<T> = ResolverHelper()

    init(accountSchema: T.Type) {
        // Initializing the Gigya SDK instance.
        GigyaDefinitions.versionPrefix = "flutter_0.0.1_"
        sdk = Gigya.sharedInstance(accountSchema)
    }

    // MARK: - Main instance

    /**
     Send general/antonymous request
     */
    
    func sendRequest(arguments: [String: Any], result: @escaping FlutterResult) {
        guard let endpoint = arguments["endpoint"] as? String,
              let parameters = arguments["parameters"] as? [String:Any] else {
            result(FlutterError(code: PluginErrors.missingParameterError, message: PluginErrors.missingParameterMessage, details: nil))
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
                    result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
                }
            }
        }
    }
    
    /**
     Login using credentials (loginId/password combination with optional parameter map).
     */
    func loginWithCredentials(arguments: [String: Any], result: @escaping FlutterResult) {
        guard let loginId = arguments["loginId"] as? String,
              let password = arguments["password"] as? String else {
            result(FlutterError(code: PluginErrors.missingParameterError, message: PluginErrors.missingParameterMessage, details: nil))
            return
        }

        resolverHelper.currentResult = result

        // Optional parameter map.
        let parameters = arguments["parameters"] as? [String: Any] ?? [:]
        sdk?.login(loginId: loginId, password: password, params: parameters) { [weak self] loginResult in
            switch loginResult {
            case .success(let data):
                let mapped = self?.mapObject(data)
                self?.resolverHelper.currentResult?(mapped)

                self?.resolverHelper.dispose()
            case .failure(let error):
                self?.saveResolvesIfNeeded(interruption: error.interruption)

                switch error.error {
                case .gigyaError(let ge):
                    self?.resolverHelper.currentResult?(FlutterError(code: "\(ge.errorCode)", message: ge.errorMessage, details: ge.toDictionary()))
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
        guard let email = arguments["email"] as? String,
              let password = arguments["password"] as? String else {
            result(FlutterError(code: PluginErrors.missingParameterError, message: PluginErrors.missingParameterMessage, details: nil))
            return
        }

        resolverHelper.currentResult = result

        // Optional parameter map.
        let parameters = arguments["parameters"] as? [String: Any] ?? [:]
        sdk?.register(email: email, password: password, params: parameters) { [weak self] loginResult in
            switch loginResult {
            case .success(let data):
                let mapped = self?.mapObject(data)
                self?.resolverHelper.currentResult?(mapped)

                self?.resolverHelper.dispose()
            case .failure(let error):
                self?.saveResolvesIfNeeded(interruption: error.interruption)

                switch error.error {
                case .gigyaError(let ge):
                    self?.resolverHelper.currentResult?(FlutterError(code: "\(ge.errorCode)", message: ge.errorMessage, details: ge.toDictionary()))
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
                let mapped = self?.mapObject(data)
                result(mapped)
            case .failure(let error):
                switch error {
                case .gigyaError(let d):
                    result(FlutterError(code: "\(d.errorCode)", message: d.errorMessage, details: d.toDictionary()))
                default:
                    result(FlutterError(code: PluginErrors.generalError, message: error.localizedDescription, details: nil))
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
                let mapped = self?.mapObject(data)
                result(mapped)
            case .failure(let error):
                switch error {
                case .gigyaError(let d):
                    result(FlutterError(code: "\(d.errorCode)", message: d.errorMessage, details: d.toDictionary()))
                default:
                    result(FlutterError(code: PluginErrors.generalError, message: error.localizedDescription, details: nil))
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
                    result(FlutterError(code: PluginErrors.generalError, message: error.localizedDescription, details: nil))
                }
            }
        })
    }
    
    /**
     Social login with given provider & provider sessions.
     */
    func socialLogin(arguments: [String: Any], result: @escaping FlutterResult) {
        guard
            let viewController = getDisplayedViewController(),
            let providerString = arguments["provider"] as? String,
            let provider = GigyaSocialProviders(rawValue: providerString)
            else {
                result(FlutterError(code: PluginErrors.generalError, message: "provider not exists", details: nil))
                return
        }

        resolverHelper.currentResult = result

        let parameters = arguments["parameters"] as? [String: Any] ?? [:]

        sdk?.login(
            with: provider,
            viewController: viewController,
            params: parameters) { [weak self] (gigyaResponse) in
            switch gigyaResponse {
            case .success(let data):

                let mapped = self?.mapObject(data)
                self?.resolverHelper.currentResult?(mapped)

                self?.resolverHelper.dispose()
            case .failure(let error):
                self?.saveResolvesIfNeeded(interruption: error.interruption)

                switch error.error {
                case .gigyaError(let d):
                    self?.resolverHelper.currentResult?(FlutterError(code: "\(d.errorCode)", message: d.errorMessage, details: d.toDictionary()))
                default:
                    self?.resolverHelper.currentResult?(FlutterError(code: "", message: error.error.localizedDescription, details: nil))
                }
            }
        }
    }

    func addConnection(arguments: [String: Any], result: @escaping FlutterResult) {
        guard
            let viewController = getDisplayedViewController(),
            let providerString = arguments["provider"] as? String,
            let provider = GigyaSocialProviders(rawValue: providerString)
            else {
                result(FlutterError(code: PluginErrors.generalError, message: "provider not exists", details: nil))
                return
        }

        let parameters = arguments["parameters"] as? [String: Any] ?? [:]

        sdk?.addConnection(
            provider: provider,
            viewController: viewController,
            params: parameters) { [weak self] gigyaResponse in
            switch gigyaResponse {
            case .success(let data):

                let mapped = self?.mapObject(data)
                result(mapped)
            case .failure(let error):
                switch error {
                case .gigyaError(let d):
                    result(FlutterError(code: "\(d.errorCode)", message: d.errorMessage, details: d.toDictionary()))
                default:
                    result(FlutterError(code: PluginErrors.generalError, message: error.localizedDescription, details: nil))
                }
            }
        }
    }

    func removeConnection(arguments: [String: Any], result: @escaping FlutterResult) {
        guard
            let providerString = arguments["provider"] as? String,
            let provider = GigyaSocialProviders(rawValue: providerString)
            else {
                result(FlutterError(code: PluginErrors.generalError, message: "provider not exists", details: nil))
                return
        }


        sdk?.removeConnection(provider: provider) { gigyaResponse in
            switch gigyaResponse {
            case .success(let data):
                let returnData = data.mapValues { $0.value }
                result(returnData)
            case .failure(let error):
                switch error {
                case .gigyaError(let d):
                    result(FlutterError(code: "\(d.errorCode)", message: d.errorMessage, details: d.toDictionary()))
                default:
                    result(FlutterError(code: PluginErrors.generalError, message: error.localizedDescription, details: nil))
                }
            }
        }
    }

    /**
     Show screensets call.
     */

    func showScreenSet(arguments: [String: Any], result: @escaping FlutterResult) {
        guard
            let viewController = getDisplayedViewController(),
            let screenSet = arguments["screenSet"] as? String else {
                return
        }

        // Create streamer
        var screenSetsEventHandler: ScreenSetsStreamHandler? = ScreenSetsStreamHandler()
        let eventChannel = FlutterEventChannel(name: "screensetEvents", binaryMessenger: SwiftGigyaFlutterPlugin.registrar!.messenger())

        eventChannel.setStreamHandler(screenSetsEventHandler)

        // Release the await request
        result(nil)

        //TODO missing onAfterValidation in SDK.
        sdk?.showScreenSet(
            with: screenSet,
            viewController: viewController,
            params: arguments) { [weak self] event in
            switch event {
            case .error(let event):
                screenSetsEventHandler?.sink?(["event":"onError", "data" : event])
            case .onHide(let event):
                screenSetsEventHandler?.sink?(["event":"onHide", "data" : event])
                screenSetsEventHandler?.destroy()
                screenSetsEventHandler = nil
            case .onLogin(account: let account):
                screenSetsEventHandler?.sink?(["event":"onLogin", "data" : self?.mapObject(account) ?? [:]])
            case .onLogout:
                screenSetsEventHandler?.sink?(["event":"onLogout"])
            case .onConnectionAdded:
                screenSetsEventHandler?.sink?(["event":"onConnectionAdded"])
            case .onConnectionRemoved:
                screenSetsEventHandler?.sink?(["event":"onConnectionRemoved"])
            case .onBeforeScreenLoad(let event):
                screenSetsEventHandler?.sink?(["event":"onBeforeScreenLoad", "data" : event])
            case .onAfterScreenLoad(let event):
                screenSetsEventHandler?.sink?(["event":"onAfterScreenLoad", "data" : event])
            case .onBeforeValidation(let event):
                screenSetsEventHandler?.sink?(["event":"onBeforeValidation", "data" : event])
            case .onAfterValidation(let event):
                screenSetsEventHandler?.sink?(["event":"onAfterValidation", "data" : event])
            case .onBeforeSubmit(let event):
                screenSetsEventHandler?.sink?(["event":"onBeforeSubmit", "data" : event])
            case .onSubmit(let event):
                screenSetsEventHandler?.sink?(["event":"onSubmit", "data" : event])
            case .onAfterSubmit(let event):
                screenSetsEventHandler?.sink?(["event":"onAfterSubmit", "data" : event])
            case .onFieldChanged(let event):
                screenSetsEventHandler?.sink?(["event":"onFieldChanged", "data" : event])
            case .onCanceled:
                screenSetsEventHandler?.sink?(["event":"onCanceled", "data" : [:]])
                screenSetsEventHandler?.destroy()
                screenSetsEventHandler = nil
            }
        }
    }


}

// MARK: - Resolvers
extension GigyaSdkWrapper {
    /**
     Link account - handler for fetching conflicting accounts from current intrruption state.
     */
    func resolveGetConflictingAccounts(result: @escaping FlutterResult) {
        guard let resolver = resolverHelper.linkAccountResolver else {
            result(FlutterError(code: PluginErrors.generalError, message: "resolver not found", details: nil))

            return
        }

        result(mapObject(resolver.conflictingAccount!))
    }

    /**
     Link account - resolving link to site.
     */
    func resolveLinkToSite(arguments: [String: Any], result: @escaping FlutterResult) {
        resolverHelper.currentResult = result

        guard let resolver = resolverHelper.linkAccountResolver else {
            result(FlutterError(code: PluginErrors.generalError, message: "resolver not found", details: nil))

            return
        }

        guard
            let loginId = arguments["loginId"] as? String ,
            let password = arguments["password"] as? String else {
            result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
            return
        }

        resolver.linkToSite(loginId: loginId, password: password)

    }

    /**
     Link account - resolving link to social.
     */
    func resolveLinkToSocial(arguments: [String: Any], result: @escaping FlutterResult) {
        resolverHelper.currentResult = result

        guard let resolver = resolverHelper.linkAccountResolver else {
            result(FlutterError(code: PluginErrors.generalError, message: "resolver not found", details: nil))

            return
        }

        guard let viewController = getDisplayedViewController(),
              let providerString = arguments["provider"] as? String,
              let provider = GigyaSocialProviders(rawValue: providerString)
              else {
            result(FlutterError(code: PluginErrors.generalError, message: PluginErrors.generalErrorMessage, details: nil))
            return
        }

        resolver.linkToSocial(provider: provider, viewController: viewController)
    }

    /**
     Pending registration - resolving missing account data.
     */
    func resolveSetAccount(arguments: [String: Any], result: @escaping FlutterResult) {
        resolverHelper.currentResult = result

        guard let resolver = resolverHelper.pendingRegistrationResolver else {
            result(FlutterError(code: PluginErrors.generalError, message: "resolver not found", details: nil))

            return
        }

        resolver.setAccount(params: arguments)
    }
}

extension GigyaSdkWrapper {
    private func saveResolvesIfNeeded(interruption: GigyaInterruptions<T>?) {
        guard let interruption = interruption else {
            return
        }

        switch interruption {
        case .pendingRegistration(let resolver):
            resolverHelper.pendingRegistrationResolver = resolver
        case .pendingVerification(let regToken):
            resolverHelper.regToken = regToken
        case .conflitingAccount(let resolver):
            resolverHelper.linkAccountResolver = resolver
        default: break
        }
    }
}

class ResolverHelper<T: GigyaAccountProtocol> {
    var currentResult: FlutterResult?

    var linkAccountResolver: LinkAccountsResolver<T>?

    var pendingRegistrationResolver: PendingRegistrationResolver<T>?

    var regToken: String?

    func dispose() {
        linkAccountResolver = nil
        pendingRegistrationResolver = nil
        regToken = nil
    }
}
