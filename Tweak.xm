#import <UIKit/UIKit.h>

// ============================== //  Free Fire – GUI Overlay Only //  TrollFools compatible dylib //  iOS 15+ (scene-safe) // ==============================

static BOOL ff_guiVisible = NO; static UIView *ff_panel = nil; static UIButton *ff_floatingBtn = nil;

// -------- Window helper (iOS 15+) -------- static UIWindow *FFGetKeyWindow(void) { for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) { if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) { UIWindowScene *ws = (UIWindowScene *)scene; for (UIWindow *w in ws.windows) { if (w.isKeyWindow) return w; } } } return nil; }

// -------- Glass panel -------- static UIView *FFCreatePanel(void) { UIView *panel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 180)]; panel.center = CGPointMake(UIScreen.mainScreen.bounds.size.width/2, UIScreen.mainScreen.bounds.size.height/2); panel.layer.cornerRadius = 22; panel.clipsToBounds = YES;

UIVisualEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterialDark];
UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
blurView.frame = panel.bounds;
blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
[panel addSubview:blurView];

UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, panel.bounds.size.width, 28)];
title.text = @"FF Overlay";
title.textAlignment = NSTextAlignmentCenter;
title.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
title.textColor = UIColor.whiteColor;
[panel addSubview:title];

UIButton *close = [UIButton buttonWithType:UIButtonTypeSystem];
close.frame = CGRectMake(panel.bounds.size.width-44, 10, 34, 34);
[close setTitle:@"✕" forState:UIControlStateNormal];
close.tintColor = UIColor.whiteColor;
close.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
[close addTarget:nil action:@selector(ff_toggleGUI) forControlEvents:UIControlEventTouchUpInside];
[panel addSubview:close];

// Example toggles (placeholders)
NSArray *labels = @[ @"Aimbot", @"ESP" ];
for (int i = 0; i < labels.count; i++) {
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(24, 70 + i*44, 0, 0)];
    [panel addSubview:sw];

    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(90, 70 + i*44, 120, 30)];
    lb.text = labels[i];
    lb.textColor = UIColor.whiteColor;
    lb.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [panel addSubview:lb];
}

// Drag
UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:panel action:@selector(ff_handlePan:)];
[panel addGestureRecognizer:pan];

return panel;

}

// -------- Floating button -------- static UIButton *FFCreateFloatingButton(void) { UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom]; btn.frame = CGRectMake(20, 120, 56, 56); btn.layer.cornerRadius = 28; btn.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.9];

UIVisualEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
blurView.frame = btn.bounds;
blurView.layer.cornerRadius = 28;
blurView.clipsToBounds = YES;
blurView.userInteractionEnabled = NO;
[btn addSubview:blurView];

UILabel *icon = [[UILabel alloc] initWithFrame:btn.bounds];
icon.text = @"Δ";
icon.textAlignment = NSTextAlignmentCenter;
icon.font = [UIFont systemFontOfSize:26 weight:UIFontWeightBold];
icon.textColor = UIColor.whiteColor;
icon.userInteractionEnabled = NO;
[btn addSubview:icon];

[btn addTarget:nil action:@selector(ff_toggleGUI) forControlEvents:UIControlEventTouchUpInside];

UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:btn action:@selector(ff_handlePan:)];
[btn addGestureRecognizer:pan];

return btn;

}

// -------- Actions -------- @interface UIView (FFPan)

(void)ff_handlePan:(UIPanGestureRecognizer *)gr; @end


@implementation UIView (FFPan)

(void)ff_handlePan:(UIPanGestureRecognizer *)gr { CGPoint t = [gr translationInView:self.superview]; self.center = CGPointMake(self.center.x + t.x, self.center.y + t.y); [gr setTranslation:CGPointZero inView:self.superview]; } @end


@interface NSObject (FFActions)

(void)ff_toggleGUI; @end


@implementation NSObject (FFActions)

(void)ff_toggleGUI { UIWindow *w = FFGetKeyWindow(); if (!w) return;

ff_guiVisible = !ff_guiVisible; if (ff_guiVisible) { if (!ff_panel) ff_panel = FFCreatePanel(); if (!ff_panel.superview) [w addSubview:ff_panel]; ff_panel.alpha = 0.0; [UIView animateWithDuration:0.25 animations:^{ ff_panel.alpha = 1.0; }]; } else { [UIView animateWithDuration:0.25 animations:^{ ff_panel.alpha = 0.0; } completion:^(BOOL f){ [ff_panel removeFromSuperview]; }]; } } @end


// -------- Inject on Free Fire launch -------- %hook UIApplication

(void)applicationDidBecomeActive:(UIApplication *)application { %orig;

NSString *bid = NSBundle.mainBundle.bundleIdentifier ?: @""; if (![bid isEqualToString:@"com.dts.freefireth"] && ![bid isEqualToString:@"com.dts.freefiremax"]) { return; // Only Free Fire }

UIWindow *w = FFGetKeyWindow(); if (!w) return;

if (!ff_floatingBtn) ff_floatingBtn = FFCreateFloatingButton(); if (!ff_floatingBtn.superview) [w addSubview:ff_floatingBtn]; } %end
