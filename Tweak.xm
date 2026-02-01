#import <UIKit/UIKit.h>

static UIView *executorView = nil;
static UIButton *floatingButton = nil;
static BOOL guiVisible = NO;
static BOOL injected = NO;

UIWindow *GetMainWindow() {
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

void ToggleExecutor() {
    if (!executorView) return;
    guiVisible = !guiVisible;
    executorView.hidden = !guiVisible;
}

void CreateExecutorGUI() {
    if (executorView) return;

    UIWindow *window = GetMainWindow();
    if (!window) return;

    executorView = [[UIView alloc] initWithFrame:CGRectMake(40, 120, 260, 160)];
    executorView.backgroundColor = [UIColor colorWithWhite:0.08 alpha:0.95];
    executorView.layer.cornerRadius = 18;
    executorView.layer.zPosition = 9999;
    executorView.hidden = YES;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 260, 24)];
    title.text = @"Lua Executor";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColor.whiteColor;
    title.font = [UIFont boldSystemFontOfSize:16];
    [executorView addSubview:title];

    UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 240, 80)];
    info.text = @"Aquí va tu executor\n(conecta Lua después)";
    info.textAlignment = NSTextAlignmentCenter;
    info.numberOfLines = 0;
    info.textColor = UIColor.lightGrayColor;
    info.font = [UIFont systemFontOfSize:13];
    [executorView addSubview:info];

    [window addSubview:executorView];
}

void CreateFloatingButton() {
    if (floatingButton) return;

    UIWindow *window = GetMainWindow();
    if (!window) return;

    floatingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    floatingButton.frame = CGRectMake(20, 300, 56, 56);
    floatingButton.layer.cornerRadius = 28;
    floatingButton.layer.zPosition = 10000;
    floatingButton.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:1 alpha:1];

    [floatingButton setTitle:@"≡" forState:UIControlStateNormal];
    floatingButton.titleLabel.font = [UIFont boldSystemFontOfSize:28];

    [floatingButton addTarget:nil
                       action:@selector(toggleExecutorAction)
             forControlEvents:UIControlEventTouchUpInside];

    UIPanGestureRecognizer *pan =
        [[UIPanGestureRecognizer alloc] initWithTarget:nil
                                                action:@selector(dragButton:)];
    [floatingButton addGestureRecognizer:pan];

    [window addSubview:floatingButton];
}

@interface UIApplication (Executor)
- (void)toggleExecutorAction;
- (void)dragButton:(UIPanGestureRecognizer *)gesture;
@end

@implementation UIApplication (Executor)

- (void)toggleExecutorAction {
    ToggleExecutor();
}

- (void)dragButton:(UIPanGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    CGPoint translation = [gesture translationInView:view.superview];
    view.center = CGPointMake(view.center.x + translation.x,
                              view.center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:view.superview];
}

@end

void InjectGUI() {
    if (injected) return;
    injected = YES;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
        CreateExecutorGUI();
        CreateFloatingButton();
    });
}

%hook UIApplication

- (void)applicationDidBecomeActive:(UIApplication *)application {
    %orig;

    NSString *bundleID = NSBundle.mainBundle.bundleIdentifier;
    if ([bundleID isEqualToString:@"com.apple.springboard"]) return;

    InjectGUI();
}

%end
