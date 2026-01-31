#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

// Variables globales
static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;

// Funciones helper para toggles
void toggleAimbot(UIButton *sender) {
    aimbotEnabled = !aimbotEnabled;
    NSString *title = aimbotEnabled ? @"Aimbot ON" : @"Aimbot OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

void toggleESP(UIButton *sender) {
    espEnabled = !espEnabled;
    NSString *title = espEnabled ? @"ESP ON" : @"ESP OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

// Hook del UIApplication
CHOptimizedMethod1(self, BOOL, UIApplication, application, didFinishLaunchingWithOptions, NSDictionary *, options) {
    // Llamamos al método original
    CHSuper1(UIApplication, application, didFinishLaunchingWithOptions, options);

    // Aquí se puede inicializar tu panel o botones
    NSLog(@"[MKFEKBKJCKEHook] App launched - panel ready!");

    return YES;
}
