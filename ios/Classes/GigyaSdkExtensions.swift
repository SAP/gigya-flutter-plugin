import Foundation
import Gigya

extension Dictionary {
    /**
    Get this dictionary as a JSON string.
    */
    var asJson: String {
        if let jsonData: Data = try? JSONSerialization.data(withJSONObject: self, options:[]),
            let result = String(data: jsonData, encoding: .utf8) {
            return result
        }
        return ""
    }
}

extension GigyaSdkWrapper {
    /**
     Get top view controller.
     */
    func getDisplayedViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }

    /**
     Map the given object to a Dictionary.
     The returned dictionary uses String keys.
     */
    func mapObject<T: Codable>(_ obj: T) -> [String: Any] {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(obj)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: [])
                as? [String: Any]
            return dictionary ?? [:]
        } catch {
            print(error)
        }
        return [:]
    }

    /**
    Save the resolver for the given interruption nto the resolver helper.
    */
    func saveResolvesIfNeeded(interruption: GigyaInterruptions<T>?) {
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
        default: 
            break
        }
    }    
}