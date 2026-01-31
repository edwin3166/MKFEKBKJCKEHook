#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

CHDeclareClass(UIApplication)

// Variables globales
static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;

// Función para mostrar panel MK
static void showMKPanel(id self) {
    NSLog(@"MK Panel shown!");
}

// Botones
static void toggleAimbot(UIButton *sender) {
    aimbotEnabled = !aimbotEnabled;
    NSString *title = aimbotEnabled ? @"Aimbot ON" : @"Aimbot OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

static void toggleESP(UIButton *sender) {
    espEnabled = !espEnabled;
    NSString *title = espEnabled ? @"ESP ON" : @"ESP OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

// Hook correcto al método UIApplication
CHOptimizedMethod1(self, void, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {
    CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);
    showMKPanel(self);
}

// Inicialización de CaptainHook
CHConstructor {
    CHLoadLateClass(UIApplication);
}
