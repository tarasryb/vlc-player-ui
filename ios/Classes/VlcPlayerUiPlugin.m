#import "VlcPlayerUiPlugin.h"
#if __has_include(<vlc_player_ui/vlc_player_ui-Swift.h>)
#import <vlc_player_ui/vlc_player_ui-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vlc_player_ui-Swift.h"
#endif

@implementation VlcPlayerUiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVlcPlayerUiPlugin registerWithRegistrar:registrar];
}
@end
