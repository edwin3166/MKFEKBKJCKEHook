#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;

// Ejemplo: toggle Aimbot
CHDeclareMethod1(void, UIButton, toggleAimbot:, UIButton *sender) {
    aimbotEnabled = !aimbotEnabled;
    NSString *title = aimbotEnabled ? @"Aimbot ON" : @"Aimbot OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

// Ejemplo: toggle ESP
CHDeclareMethod1(void, UIButton, toggleESP:, UIButton *sender) {
    espEnabled = !espEnabled;
    NSString *title = espEnabled ? @"ESP ON" : @"ESP OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

// Hook didFinishLaunching
CHOptimizedMethod1(0, BOOL, UIApplication, application, didFinishLaunchingWithOptions, NSDictionary *, options) {
    BOOL result = CHSuper1(UIApplication, application, didFinishLaunchingWithOptions, options);

    // Aquí tu función para mostrar panel
    // showMKPanel(self);

    return result;
}
