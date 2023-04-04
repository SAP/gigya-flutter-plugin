import Flutter
import UIKit
import Gigya

public class SwiftGigyaFlutterPlugin: NSObject, FlutterPlugin {
    /// A reference to the plugin registry
    /// that is used to register a ``SwiftGigyaFlutterPluginTyped`` instance
    /// with a specific ``GigyaAccountProtocol``.
    ///
    /// This reference is discarded after registration is complete.
    static var registrar: FlutterPluginRegistrar?
    
    /// The ``FlutterPlugin.register()`` implementation of this plugin
    /// only saves a reference to the plugin registry.
    ///
    /// To actually register an instance of the plugin,
    /// call the ``register(accountSchema: schema)`` method in your AppDelegate implementation,
    /// after all other plugins have been registered.
    public static func register(with registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }
    
    /// Register this plugin with Flutter's plugin registry.
    ///
    /// An ``accountSchema``, like the ``GigyaAccount`` implementation provided by the Gigya SDK,
    /// is required for this registration.
    ///
    /// This schema is passed to the Gigya SDK during setup.
    ///
    /// See also: https://github.com/SAP/gigya-swift-sdk/blob/main/GigyaSwift/Models/User/GigyaAccount.swift
    public static func register<T: GigyaAccountProtocol>(accountSchema: T.Type) {
        guard let registrar = self.registrar else { return }

        self.registrar = nil // Discard the plugin registry reference.

        let instance = SwiftGigyaFlutterPluginTyped(accountSchema: accountSchema)
        instance.register(with: registrar)
    }
}