import UIKit
import Flutter
import gigya_flutter_plugin
import Gigya

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    SwiftGigyaFlutterPlugin.register(accountSchema: GigyaAccount.self)

    // Register social providers here, i.e. 
    // Gigya.sharedInstance(GigyaAccount.self).registerSocialProvider(of: .facebook, wrapper: FacebookWrapper())

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}