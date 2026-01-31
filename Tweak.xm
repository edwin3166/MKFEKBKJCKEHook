// Tweak.xm
#import <UIKit/UIKit.h>

// Variables globales para controlar los toggles
static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;

// Hook principal de la app
%hook UIApplication

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL result = %orig;

    // Aquí podrías inicializar tu panel
    NSLog(@"[MKFEKBKJCKEHook] App launched - Panel ready");

    return result;
}

%end

// Hooks para botones
@interface UIButton (MKHooks)
@end

@implementation UIButton (MKHooks)

- (void)toggleAimbot {
    aimbotEnabled = !aimbotEnabled;
    NSString *title = aimbotEnabled ? @"Aimbot ON" : @"Aimbot OFF";
    [self setTitle:title forState:UIControlStateNormal];
    NSLog(@"[MKFEKBKJCKEHook] Aimbot is now %@", aimbotEnabled ? @"ON" : @"OFF");
}

- (void)toggleESP {
    espEnabled = !espEnabled;
    NSString *title = espEnabled ? @"ESP ON" : @"ESP OFF";
    [self setTitle:title forState:UIControlStateNormal];
    NSLog(@"[MKFEKBKJCKEHook] ESP is now %@", espEnabled ? @"ON" : @"OFF");
}

@end
