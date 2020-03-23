#import "TreasuredataFlutterPlugin.h"
#if __has_include(<treasuredata_flutter/treasuredata_flutter-Swift.h>)
#import <treasuredata_flutter/treasuredata_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "treasuredata_flutter-Swift.h"
#endif

@implementation TreasuredataFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTreasuredataFlutterPlugin registerWithRegistrar:registrar];
}
@end
