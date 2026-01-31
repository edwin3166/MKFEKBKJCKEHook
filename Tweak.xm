#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

static UIView *mkPanel = nil;
static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;

#pragma mark - Panel Buttons

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
    if (mkPanel) {
        mkPanel.hidden = YES;
    }
}

#pragma mark - Show Panel

static void showMKPanel(UIApplication *app) {
    if (!mkPanel) {
        mkPanel = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 150)];
        mkPanel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        mkPanel.layer.cornerRadius = 10;

        UIButton *aimbotBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        aimbotBtn.frame = CGRectMake(20, 20, 160, 30);
        [aimbotBtn setTitle:@"Aimbot OFF" forState:UIControlStateNormal];
        [aimbotBtn addTarget:app action:@selector(toggleAimbot:) forControlEvents:UIControlEventTouchUpInside];
        [mkPanel addSubview:aimbotBtn];

        UIButton *espBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        espBtn.frame = CGRectMake(20, 60, 160, 30);
        [espBtn setTitle:@"ESP OFF" forState:UIControlStateNormal];
        [espBtn addTarget:app action:@selector(toggleESP:) forControlEvents:UIControlEventTouchUpInside];
        [mkPanel addSubview:espBtn];

        UIButton *minimizeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        minimizeBtn.frame = CGRectMake(20, 100, 160, 30);
        [minimizeBtn setTitle:@"Minimizar" forState:UIControlStateNormal];
        [minimizeBtn addTarget:app action:@selector(minimizePanel:) forControlEvents:UIControlEventTouchUpInside];
        [mkPanel addSubview:minimizeBtn];
    }

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (![mkPanel isDescendantOfView:keyWindow]) {
        [keyWindow addSubview:mkPanel];
    }
    mkPanel.hidden = NO;
}

#pragma mark - Hook UIApplication

CHOptimizedMethod1(0, void, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {
    CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);

    // Mostrar panel al iniciar la app
    showMKPanel(self);
}
