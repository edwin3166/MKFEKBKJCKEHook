#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;
static UIView *mkPanel = nil;

CHDeclareClass(UIApplication);

// didFinishLaunchingWithOptions corregido
CHOptimizedMethod1(self, void, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {
    CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    mkPanel = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 200, 150)];
    mkPanel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    mkPanel.layer.cornerRadius = 10;
    
    // Botón Aimbot
    UIButton *aimButton = [UIButton buttonWithType:UIButtonTypeSystem];
    aimButton.frame = CGRectMake(20, 20, 160, 30);
    [aimButton setTitle:@"Aimbot OFF" forState:UIControlStateNormal];
    [aimButton addTarget:self action:@selector(toggleAimbot:) forControlEvents:UIControlEventTouchUpInside];
    [mkPanel addSubview:aimButton];
    
    // Botón ESP
    UIButton *espButton = [UIButton buttonWithType:UIButtonTypeSystem];
    espButton.frame = CGRectMake(20, 60, 160, 30);
    [espButton setTitle:@"ESP OFF" forState:UIControlStateNormal];
    [espButton addTarget:self action:@selector(toggleESP:) forControlEvents:UIControlEventTouchUpInside];
    [mkPanel addSubview:espButton];
    
    // Botón minimizar
    UIButton *minButton = [UIButton buttonWithType:UIButtonTypeSystem];
    minButton.frame = CGRectMake(20, 100, 160, 30);
    [minButton setTitle:@"Minimizar" forState:UIControlStateNormal];
    [minButton addTarget:self action:@selector(minimizePanel:) forControlEvents:UIControlEventTouchUpInside];
    [mkPanel addSubview:minButton];
    
    [window addSubview:mkPanel];
}

// Toggle Aimbot
CHDeclareMethod1(void, UIApplication, toggleAimbot, UIButton *, sender) {
    aimbotEnabled = !aimbotEnabled;
    NSString *title = aimbotEnabled ? @"Aimbot ON" : @"Aimbot OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

// Toggle ESP
CHDeclareMethod1(void, UIApplication, toggleESP, UIButton *, sender) {
    espEnabled = !espEnabled;
    NSString *title = espEnabled ? @"ESP ON" : @"ESP OFF";
    [sender setTitle:title forState:UIControlStateNormal];
}

// Minimizar panel
CHDeclareMethod1(void, UIApplication, minimizePanel, UIButton *, sender) {
    mkPanel.hidden = !mkPanel.hidden;
}

CHConstructor {
    CHLoadLateClass(UIApplication);
}
