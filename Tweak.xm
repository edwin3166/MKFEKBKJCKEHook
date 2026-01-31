#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;
static UIView *mkPanel = nil;

// Función para crear el panel y botones
static void createMKPanel() {
    if (mkPanel) return; // Ya existe
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow ?: [UIApplication sharedApplication].windows.firstObject;
    if (!keyWindow) return;

    mkPanel = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 200, 150)];
    mkPanel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    mkPanel.layer.cornerRadius = 10;
    
    // Botón Aimbot
    UIButton *aimButton = [UIButton buttonWithType:UIButtonTypeSystem];
    aimButton.frame = CGRectMake(10, 10, 180, 40);
    [aimButton setTitle:@"Aimbot OFF" forState:UIControlStateNormal];
    [aimButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [aimButton addTarget:nil action:@selector(toggleAimbot:) forControlEvents:UIControlEventTouchUpInside];
    [mkPanel addSubview:aimButton];

    // Botón ESP
    UIButton *espButton = [UIButton buttonWithType:UIButtonTypeSystem];
    espButton.frame = CGRectMake(10, 60, 180, 40);
    [espButton setTitle:@"ESP OFF" forState:UIControlStateNormal];
    [espButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [espButton addTarget:nil action:@selector(toggleESP:) forControlEvents:UIControlEventTouchUpInside];
    [mkPanel addSubview:espButton];

    // Botón minimizar/expandir
    UIButton *minButton = [UIButton buttonWithType:UIButtonTypeSystem];
    minButton.frame = CGRectMake(10, 110, 180, 30);
    [minButton setTitle:@"Minimizar" forState:UIControlStateNormal];
    [minButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [minButton addTarget:nil action:@selector(minimizePanel:) forControlEvents:UIControlEventTouchUpInside];
    [mkPanel addSubview:minButton];

    [keyWindow addSubview:mkPanel];
}

#pragma mark - Toggles

CHDeclareMethod1(void, UIApplication, toggleAimbot:, UIButton *sender) {
    aimbotEnabled = !aimbotEnabled;
    NSString *title = aimbotEnabled ? @"Aimbot ON" : @"Aimbot OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

CHDeclareMethod1(void, UIApplication, toggleESP:, UIButton *sender) {
    espEnabled = !espEnabled;
    NSString *title = espEnabled ? @"ESP ON" : @"ESP OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

CHDeclareMethod1(void, UIApplication, minimizePanel:, UIButton *sender) {
    if (!mkPanel) return;
    BOOL hidden = !mkPanel.hidden;
    mkPanel.hidden = hidden;
    [sender setTitle:(hidden ? @"Expandir" : @"Minimizar") forState:UIControlStateNormal];
}

#pragma mark - Launch Hook

CHOptimizedMethod1(void, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {
    CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);
    createMKPanel(); // Crear el panel al iniciar la app
}
