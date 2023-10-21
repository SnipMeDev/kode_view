#import "KodeViewPlugin.h"
#if __has_include(<kode_view/kode_view-Swift.h>)
#import <kode_view/kode_view-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "kode_view-Swift.h"
#endif

@implementation KodeViewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKodeViewPlugin registerWithRegistrar:registrar];
}
@end
