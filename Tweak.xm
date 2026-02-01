#import <UIKit/UIKit.h>

static BOOL executorEnabled = NO; static UIView *executorView = nil;

static UIWindow *GetKeyWindow(void) { if (@available(iOS 13.0, *)) { for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) { if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) { for (UIWindow *window in ((UIWindowScene *)scene).windows) { if (window.isKeyWindow) return window; } } } } return [UIApplication sharedApplication].keyWindow; }

static void ToggleExecutor(void) { UIWindow *keyWindow = GetKeyWindow(); if (!keyWindow) return;

executorEnabled = !executorEnabled;

if (executorEnabled) {
    if (!executorView) {
        UIVisualEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
        blurView.frame = CGRectMake(40, 120, keyWindow.bounds.size.width - 80, 260);
        blurView.layer.cornerRadius = 24;
        blurView.clipsToBounds = YES;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, blurView.bounds.size.width, 30)];
        label.text = @"Lua Executor (iOS 26)";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];

        [blurView.contentView addSubview:label];
        executorView = blurView;
    }
    [keyWindow addSubview:executorView];
} else {
    [executorView removeFromSuperview];
}

}

%hook UIApplication

(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)options { BOOL ret = %orig;

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ ToggleExecutor(); });

return ret; }


%end
