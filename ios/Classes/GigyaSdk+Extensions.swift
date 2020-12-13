//
//  GigyaSdk+Extensions.swift
//  gigya_flutter_plugin
//
//  Created by Shmuel, Sagi on 26/11/2020.
//

import Foundation

extension Dictionary {

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
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }

    /**
     Mapping typed account object.
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
    
}

