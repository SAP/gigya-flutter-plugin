#import "GigyaFlutterPlugin.h"
#if __has_include(<gigya_flutter_plugin/gigya_flutter_plugin-Swift.h>)
#import <gigya_flutter_plugin/gigya_flutter_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "gigya_flutter_plugin-Swift.h"
#endif

@implementation GigyaFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGigyaFlutterPlugin registerWithRegistrar:registrar];
}
@end
