// Tweak.xm
#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

// Declaramos la clase UIApplication para CaptainHook
CHDeclareClass(UIApplication)

// Variables globales para el estado de tus toggles
static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;

// Función para mostrar el panel MK
static void showMKPanel(id self) {
    // Aquí tu código para mostrar el panel
    NSLog(@"MK Panel shown!");
}

// Funciones de botones (no como métodos de UIApplication)
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

static void minimizePanel(UIButton *sender) {
    // Código para minimizar el panel
    NSLog(@"Panel minimized!");
}

// Hook al método didFinishLaunchingWithOptions de UIApplication
CHOptimizedMethod1(0, BOOL, UIApplication, application, didFinishLaunchingWithOptions, NSDictionary *, options) {
    // Llamamos al método original
    CHSuper1(UIApplication, application, didFinishLaunchingWithOptions, options);

    // Mostramos el panel MK al iniciar la app
    showMKPanel(self);

    return YES;
}

// Hook opcional a otra función si quieres
// CHDeclareMethod1(void, UIApplication, otraFuncion, ...)

// Inicialización de CaptainHook
CHConstructor {
    // Registramos la clase
    CHLoadLateClass(UIApplication);
}
