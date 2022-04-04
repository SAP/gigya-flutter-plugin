import Flutter
import UIKit
import Gigya

public class SwiftGigyaFlutterPlugin: NSObject, FlutterPlugin {
    
    static var registrar: FlutterPluginRegistrar?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }
    
    @available(iOS 13.0, *)
    public static func register<T: GigyaAccountProtocol>(accountSchema: T.Type) {
        guard let registrar = self.registrar else { return }
        let instance = SwiftGigyaFlutterPluginTyped(accountSchema: accountSchema)
        instance.register(with: registrar) 
    }
        
    deinit {
        print("[SwiftGigyaFlutterPlugin deinit]")
    }
}
