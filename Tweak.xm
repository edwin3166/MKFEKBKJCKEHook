#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

// Declaración de clases para CaptainHook
CHDeclareClass(UIApplication)
CHDeclareClass(UILabel)
CHDeclareClass(UIButton)
CHDeclareClass(UIView)
CHDeclareClass(UIWindow)

// Variables globales del panel
static UIView *mkPanel = nil;
static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;

// Helper: Crear botón
static UIButton* createButton(CGRect frame, NSString *title, SEL action, id target) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    button.layer.cornerRadius = 8;
    button.tintColor = [UIColor whiteColor];
    return button;
}

// Toggle Aimbot
CHDeclareMethod1(void, UIApplication, toggleAimbot, UIButton*, sender) {
    aimbotEnabled = !aimbotEnabled;
    NSString *title = aimbotEnabled ? @"Aimbot ON" : @"Aimbot OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

// Toggle ESP
CHDeclareMethod1(void, UIApplication, toggleESP, UIButton*, sender) {
    espEnabled = !espEnabled;
    NSString *title = espEnabled ? @"ESP ON" : @"ESP OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

// Minimizar panel
CHDeclareMethod1(void, UIApplication, minimizePanel, UIButton*, sender) {
    if (mkPanel) mkPanel.hidden = YES;
}

// Mostrar panel
CHDeclareMethod0(void, UIApplication, showMKPanel) {
    if (mkPanel) {
        mkPanel.hidden = NO;
        return;
    }

    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) return;

    mkPanel = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 200, 150)];
    mkPanel.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
    mkPanel.layer.cornerRadius = 10;

    UIButton *aimbotBtn = createButton(CGRectMake(20, 20, 160, 40), @"Aimbot OFF", @selector(toggleAimbot:), (id)[UIApplication sharedApplication]);
    UIButton *espBtn = createButton(CGRectMake(20, 70, 160, 40), @"ESP OFF", @selector(toggleESP:), (id)[UIApplication sharedApplication]);
    UIButton *minBtn = createButton(CGRectMake(20, 120, 160, 20), @"Minimizar", @selector(minimizePanel:), (id)[UIApplication sharedApplication]);

    [mkPanel addSubview:aimbotBtn];
    [mkPanel addSubview:espBtn];
    [mkPanel addSubview:minBtn];

    [window addSubview:mkPanel];
}

// Hook al inicio de la app
CHOptimizedMethod1(self, BOOL, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {
    CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);

    // Mostrar panel MK al iniciar
    [UIApplication showMKPanel];

    return YES;
}
