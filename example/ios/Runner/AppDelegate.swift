import UIKit
import Flutter
import gigya_flutter_plugin
import Gigya
import FBSDKCoreKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    SwiftGigyaFlutterPlugin.register(accountSchema: GigyaAccount.self)
    
    // Register social providers here.
    Gigya.sharedInstance(GigyaAccount.self).registerSocialProvider(of: .facebook, wrapper: FacebookWrapper())
    Gigya.sharedInstance(GigyaAccount.self).registerSocialProvider(of: .google, wrapper: GoogleWrapper())
    
    ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
}