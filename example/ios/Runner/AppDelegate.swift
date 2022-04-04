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
      if #available(iOS 13.0, *) {
          SwiftGigyaFlutterPlugin.register(accountSchema: UserHost.self)
      } else {
          // Fallback on earlier versions
      }
    
    Gigya.sharedInstance(UserHost.self).registerSocialProvider(of: .facebook, wrapper: FacebookWrapper())
    Gigya.sharedInstance(UserHost.self).registerSocialProvider(of: .google, wrapper: GoogleWrapper())
    
    ApplicationDelegate.shared.application(
                application,
                didFinishLaunchingWithOptions: launchOptions
            )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

