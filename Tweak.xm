#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;
static UIView *mkPanel = nil;

#pragma mark - Buttons

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
    if (mkPanel) mkPanel.hidden = YES;
}

static void showMKPanel(UIApplication *app) {
    if (!mkPanel) {
        mkPanel = [[UIView alloc] initWithFrame:CGRectMake(50,50,200,150)];
        mkPanel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        mkPanel.layer.cornerRadius = 10;

        UIButton *aimbotBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        aimbotBtn.frame = CGRectMake(20, 20, 160, 30);
        [aimbotBtn setTitle:@"Aimbot OFF" forState:UIControlStateNormal];
        [aimbotBtn addTarget:nil action:@selector(toggleAimbotAction:) forControlEvents:UIControlEventTouchUpInside];
        [mkPanel addSubview:aimbotBtn];

        UIButton *espBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        espBtn.frame = CGRectMake(20, 60, 160, 30);
        [espBtn setTitle:@"ESP OFF" forState:UIControlStateNormal];
        [espBtn addTarget:nil action:@selector(toggleESPAction:) forControlEvents:UIControlEventTouchUpInside];
        [mkPanel addSubview:espBtn];

        UIButton *minimizeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        minimizeBtn.frame = CGRectMake(20, 100, 160, 30);
        [minimizeBtn setTitle:@"Minimizar" forState:UIControlStateNormal];
        [minimizeBtn addTarget:nil action:@selector(minimizePanelAction:) forControlEvents:UIControlEventTouchUpInside];
        [mkPanel addSubview:minimizeBtn];
    }

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (![mkPanel isDescendantOfView:keyWindow]) [keyWindow addSubview:mkPanel];
    mkPanel.hidden = NO;
}

#pragma mark - Hook

CHConstructor {
    CHLoadLateClass(UIApplication);

    CHHook(UIApplication, didFinishLaunchingWithOptions) {
        CHSuper(UIApplication, didFinishLaunchingWithOptions, options);

        showMKPanel(self);
    };
}
