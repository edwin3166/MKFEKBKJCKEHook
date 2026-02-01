#import <UIKit/UIKit.h>

static UIWindow *ffWindow = nil;
static UIView *ffPanel = nil;

#pragma mark - Window helper (iOS 15+ safe)

static UIWindow *FFGetKeyWindow(void) {
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive &&
            [scene isKindOfClass:[UIWindowScene class]]) {

            UIWindowScene *ws = (UIWindowScene *)scene;
            for (UIWindow *w in ws.windows) {
                if (w.isKeyWindow) return w;
            }
        }
    }
    return nil;
}

#pragma mark - GUI

static void FFBuildGUI(void) {
    if (ffPanel) return;

    ffWindow = FFGetKeyWindow();
    if (!ffWindow) return;

    ffPanel = [[UIView alloc] initWithFrame:CGRectMake(40, 120, 240, 180)];
    ffPanel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    ffPanel.layer.cornerRadius = 14;
    ffPanel.layer.borderWidth = 1.5;
    ffPanel.layer.borderColor = UIColor.greenColor.CGColor;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 240, 30)];
    title.text = @"FF Executor";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColor.greenColor;
    title.font = [UIFont boldSystemFontOfSize:18];
    [ffPanel addSubview:title];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(30, 70, 180, 40);
    [btn setTitle:@"Toggle GUI" forState:UIControlStateNormal];
    btn.tintColor = UIColor.greenColor;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = UIColor.greenColor.CGColor;
    btn.layer.cornerRadius = 8;
    [btn addTarget:nil action:@selector(ff_toggle) forControlEvents:UIControlEventTouchUpInside];
    [ffPanel addSubview:btn];

    [ffWindow addSubview:ffPanel];
}

#pragma mark - UIApplication hook

@interface UIApplication (FFHook)
- (void)ff_toggle;
@end

@implementation UIApplication (FFHook)

- (void)ff_toggle {
    if (!ffPanel) {
        FFBuildGUI();
        return;
    }
    ffPanel.hidden = !ffPanel.hidden;
}

@end

__attribute__((constructor))
static void FFInit(void) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
        FFBuildGUI();
    });
}
