// Tweak.xm
#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

// Variables globales
static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;

// Función para mostrar el panel MK
extern void showMKPanel(id self);

// ---------- Hooks de botones ----------

CHDeclareMethod1(void, UIApplication, toggleAimbot, UIButton *, sender) {
    aimbotEnabled = !aimbotEnabled;
    NSString *title = aimbotEnabled ? @"Aimbot ON" : @"Aimbot OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

CHDeclareMethod1(void, UIApplication, toggleESP, UIButton *, sender) {
    espEnabled = !espEnabled;
    NSString *title = espEnabled ? @"ESP ON" : @"ESP OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

CHDeclareMethod1(void, UIApplication, minimizePanel, UIButton *, sender) {
    if (!self) return;
    // Aquí puedes agregar lógica para minimizar tu panel MK
}

// ---------- Hook al lanzamiento de la app ----------

CHOptimizedMethod1(0, BOOL, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {
    CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);

    // Muestra el panel MK al iniciar
    showMKPanel(self);

    return YES;
}
