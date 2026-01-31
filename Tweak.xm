#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

// Variable global para activar/desactivar AimKill
static BOOL aimKillEnabled = YES;

// Botón flotante
static UIButton *aimKillButton = nil;

CHDeclareClass(UIApplication)

CHOptimizedMethod1(self, BOOL, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, launchOptions) {

    // Llamada al método original
    BOOL result = CHSuper1(UIApplication, didFinishLaunchingWithOptions, launchOptions);

    // Crear botón flotante si no existe
    if (!aimKillButton) {
        UIWindowScene *scene = [UIApplication sharedApplication].connectedScenes.anyObject;
        UIWindow *window = scene.windows.firstObject;

        aimKillButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aimKillButton.frame = CGRectMake(20, 50, 100, 40);
        [aimKillButton setTitle:@"AimKill ON" forState:UIControlStateNormal];
        [aimKillButton setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]];
        [aimKillButton addTarget:self action:@selector(toggleAimKill:) forControlEvents:UIControlEventTouchUpInside];
        [window addSubview:aimKillButton];
    }

    return result;
}

// Toggle AimKill
CHDeclareMethod1(void, UIApplication, toggleAimKill, UIButton*, sender) {
    aimKillEnabled = !aimKillEnabled;
    NSString *title = aimKillEnabled ? @"AimKill ON" : @"AimKill OFF";
    [sender setTitle:title forState:UIControlStateNormal];

    // Aquí puedes poner tu lógica de AimKill ON/OFF
    if (aimKillEnabled) {
        NSLog(@"AimKill activado");
    } else {
        NSLog(@"AimKill desactivado");
    }
}

CHConstructor {
    NSLog(@"MKFEKBKJCKEHook loaded");
}
