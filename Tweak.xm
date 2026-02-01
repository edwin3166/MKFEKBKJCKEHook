// FFHook - TrollFools GUI Overlay (iOS 15+) // Target: Free Fire only

#import <UIKit/UIKit.h>

static BOOL ff_guiVisible = NO; static UIView *ff_panel = nil; static UIButton *ff_toggleBtn = nil;

static UIWindow *FFGetActiveWindow(void) { if (@available(iOS 13.0, *)) { for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) { if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:UIWindowScene.class]) { UIWindowScene *ws = (UIWindowScene *)scene; for (UIWindow *w in ws.windows) { if (w.isKeyWindow) return w; } if (ws.windows.count > 0) return ws.windows.firstObject; } } } return UIApplication.sharedApplication.delegate.window; }

static void FFBuildGUI(void) { UIWindow *window = FFGetActiveWindow(); if (!window) return;

if (!ff_toggleBtn) {
    ff_toggleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    ff_toggleBtn.frame = CGRectMake(20, 120, 56, 56);
    ff_toggleBtn.layer.cornerRadius = 28;
    ff_toggleBtn.backgroundColor = [[UIColor systemBlueColor] colorWithAlphaComponent:0.85];
    [ff_toggleBtn setTitle:@"FF" forState:UIControlStateNormal];
    [ff_toggleBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [ff_toggleBtn addTarget:nil action:@selector(ff_toggle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:ff_toggleBtn];
}

if (!ff_panel) {
    ff_panel = [[UIView alloc] initWithFrame:CGRectMake(20, 190, 260, 220)];
    ff_panel.layer.cornerRadius = 16;
    ff_panel.backgroundColor = [[UIColor systemBackgroundColor] colorWithAlphaComponent:0.92];
    ff_panel.hidden = YES;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 12, 228, 28)];
    title.text = @"FF Overlay";
    title.font = [UIFont boldSystemFontOfSize:18];
    [ff_panel addSubview:title];

    UISwitch *sw1 = [[UISwitch alloc] initWithFrame:CGRectMake(16, 56, 0, 0)];
    [ff_panel addSubview:sw1];
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 56, 160, 31)];
    l1.text = @"Feature 1";
    [ff_panel addSubview:l1];

    UISwitch *sw2 = [[UISwitch alloc] initWithFrame:CGRectMake(16, 104, 0, 0)];
    [ff_panel addSubview:sw2];
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 104, 160, 31)];
    l2.text = @"Feature 2";
    [ff_panel addSubview:l2];

    [window addSubview:ff_panel];
}

}

@interface UIApplication (FFHook) @end

@implementation UIApplication (FFHook)

(void)ff_toggle { ff_guiVisible = !ff_guiVisible; ff_panel.hidden = !ff_guiVisible; }


@end

%hook UIApplication

(void)applicationDidBecomeActive:(UIApplication *)application { %orig; FFBuildGUI(); }


%end
