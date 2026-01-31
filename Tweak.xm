#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

static BOOL aimKillEnabled = YES;
static UIButton *aimKillButton = nil;

CHDeclareClass(UIApplication)

// Hook a didFinishLaunchingWithOptions
CHOptimizedMethod1(self, BOOL, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {
    BOOL result = CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);

    // Obtenemos la primera escena
    UIScene *firstScene = [UIApplication sharedApplication].connectedScenes.anyObject;
    if ([firstScene isKindOfClass:[UIWindowScene class]]) {
        UIWindowScene *windowScene = (UIWindowScene *)firstScene;
        UIWindow *window = windowScene.windows.firstObject;

        // Crear botón toggle AimKill
        aimKillButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aimKillButton.frame = CGRectMake(20, 50, 120, 40);
        [aimKillButton setTitle:@"AimKill ON" forState:UIControlStateNormal];
        [aimKillButton setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]];
        [aimKillButton addTarget:self action:@selector(toggleAimKill:) forControlEvents:UIControlEventTouchUpInside];

        [window addSubview:aimKillButton];
    }

    return result;
}

// Método toggle
CHDeclareMethod1(void, UIApplication, toggleAimKill, UIButton*, sender) {
    aimKillEnabled = !aimKillEnabled;

    NSString *title = aimKillEnabled ? @"AimKill ON" : @"AimKill OFF";
    [aimKillButton setTitle:title forState:UIControlStateNormal];

    NSLog(@"[MKFEKBKJCKEHook] AimKill %@", aimKillEnabled ? @"activado" : @"desactivado");

    // Aquí iría la lógica real del AimKill
}

// Constructor: registra hooks
CHConstructor {
    CHLoadLateClass(UIApplication);
    CHClassHook(UIApplication, didFinishLaunchingWithOptions);
    CHClassHook(UIApplication, toggleAimKill:);
}
