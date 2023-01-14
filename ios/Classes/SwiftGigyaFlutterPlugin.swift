import Flutter
import UIKit
import Gigya

public class SwiftGigyaFlutterPlugin: NSObject, FlutterPlugin {    
    public static func register(with registrar: FlutterPluginRegistrar) {
       // This method is a stub.
       // Register the plugin by calling
       // `SwiftGigyaFlutterPlugin.registerForProtocol(accountSchema: accountSchema, registrar: self)`
       // in your ApplicationDelegate implementation.
    }
    
    /// Register this plugin with Flutter's plugin registry.
    ///
    /// An ``accountSchema``, like the ``GigyaAccount`` implementation provided by the Gigya SDK,
    /// is required for this registration.
    ///
    /// This schema is passed to the Gigya SDK during setup.
    ///
    /// See also: https://github.com/SAP/gigya-swift-sdk/blob/main/GigyaSwift/Models/User/GigyaAccount.swift
    public static func register<T: GigyaAccountProtocol>(accountSchema: T.Type, registrar: FlutterPluginRegistrar) {
        let instance = SwiftGigyaFlutterPluginTyped(accountSchema: accountSchema)
        instance.register(with: registrar)
    }
}