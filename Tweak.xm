#import <UIKit/UIKit.h>

static BOOL executorEnabled = NO;

static UIWindow *getKeyWindow() {
    for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            for (UIWindow *window in scene.windows) {
                if (window.isKeyWindow) {
                    return window;
                }
            }
        }
    }
    return nil;
}

static void toggleExecutor() {
    executorEnabled = !executorEnabled;

    UIWindow *window = getKeyWindow();
    if (!window) return;

    UIView *view = [window viewWithTag:7777];

    if (executorEnabled) {
        if (!view) {
            UIView *panel = [[UIView alloc] initWithFrame:CGRectMake(40, 120, 300, 180)];
            panel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            panel.layer.cornerRadius = 22;
            panel.tag = 7777;

            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 300, 40)];
            label.text = @"Lua Executor";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColor.whiteColor;
            label.font = [UIFont boldSystemFontOfSize:22];
            [panel addSubview:label];

            [window addSubview:panel];
        }
    } else {
        [view removeFromSuperview];
    }
}

%hook UIApplication

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)options {
    BOOL result = %orig; // ✅ AQUÍ sí está bien usado

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        toggleExecutor();
    });

    return result;
}

%end
