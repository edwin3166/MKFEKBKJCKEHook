#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

// Variables globales para los toggles
static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;
static UIView *mkPanel = nil;

// Función para mostrar el panel
void showMKPanel() {
    if (mkPanel) return; // Evitar duplicados

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (!keyWindow) return;

    mkPanel = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 200, 120)];
    mkPanel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    mkPanel.layer.cornerRadius = 10;

    // Botón Aimbot
    UIButton *aimButton = [UIButton buttonWithType:UIButtonTypeSystem];
    aimButton.frame = CGRectMake(10, 10, 180, 30);
    [aimButton setTitle:@"Aimbot OFF" forState:UIControlStateNormal];
    [aimButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [aimButton addTarget:nil action:@selector(toggleAimbot:) forControlEvents:UIControlEventTouchUpInside];
    [mkPanel addSubview:aimButton];

    // Botón ESP
    UIButton *espButton = [UIButton buttonWithType:UIButtonTypeSystem];
    espButton.frame = CGRectMake(10, 50, 180, 30);
    [espButton setTitle:@"ESP OFF" forState:UIControlStateNormal];
    [espButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [espButton addTarget:nil action:@selector(toggleESP:) forControlEvents:UIControlEventTouchUpInside];
    [mkPanel addSubview:espButton];

    // Botón minimizar
    UIButton *minButton = [UIButton buttonWithType:UIButtonTypeSystem];
    minButton.frame = CGRectMake(10, 90, 180, 20);
    [minButton setTitle:@"Minimizar" forState:UIControlStateNormal];
    [minButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [minButton addTarget:nil action:@selector(minimizePanel:) forControlEvents:UIControlEventTouchUpInside];
    [mkPanel addSubview:minButton];

    [keyWindow addSubview:mkPanel];
}

// Métodos de toggle
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
    if (!mkPanel) return;
    BOOL hidden = !mkPanel.hidden;
    mkPanel.hidden = hidden;
    [sender setTitle:(hidden ? @"Expandir" : @"Minimizar") forState:UIControlStateNormal];
}

// Hook a didFinishLaunching para mostrar el panel al iniciar
CHOptimizedMethod1(self, BOOL, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {
    CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);

    showMKPanel(); // Mostrar panel al iniciar

    return YES;
}
