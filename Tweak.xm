#import <UIKit/UIKit.h>

static BOOL aimbotEnabled = NO;
static BOOL espEnabled = NO;
static BOOL menuMinimized = NO;

static UIView *menuView;
static UIButton *menuButton;
static UIView *contentView;

UIWindow *getKeyWindow() {
    for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive &&
            [scene isKindOfClass:[UIWindowScene class]]) {
            UIWindowScene *windowScene = (UIWindowScene *)scene;
            for (UIWindow *window in windowScene.windows) {
                if (window.isKeyWindow) {
                    return window;
                }
            }
        }
    }
    return nil;
}

void toggleMenu() {
    menuView.hidden = !menuView.hidden;
}

void toggleMinimize() {
    menuMinimized = !menuMinimized;
    contentView.hidden = menuMinimized;

    CGRect frame = menuView.frame;
    frame.size.height = menuMinimized ? 50 : 160;
    menuView.frame = frame;
}

void switchAimbot(UISwitch *sw) {
    aimbotEnabled = sw.isOn;
}

void switchESP(UISwitch *sw) {
    espEnabled = sw.isOn;
}

void handleDrag(UIPanGestureRecognizer *gesture) {
    UIView *v = gesture.view;
    CGPoint t = [gesture translationInView:v.superview];
    v.center = CGPointMake(v.center.x + t.x, v.center.y + t.y);
    [gesture setTranslation:CGPointZero inView:v.superview];
}

UIView *createMenu() {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 120, 220, 160)];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.85];
    view.layer.cornerRadius = 12;
    view.hidden = YES;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 160, 30)];
    title.text = @"MK Panel";
    title.textColor = UIColor.whiteColor;
    title.font = [UIFont boldSystemFontOfSize:18];
    [view addSubview:title];

    UIButton *minBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    minBtn.frame = CGRectMake(180, 10, 30, 30);
    [minBtn setTitle:@"—" forState:UIControlStateNormal];
    [minBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    minBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    [minBtn addTarget:nil action:@selector(toggleMinimize) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:minBtn];

    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 220, 110)];
    [view addSubview:contentView];

    UILabel *aimLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 120, 25)];
    aimLabel.text = @"Aimbot";
    aimLabel.textColor = UIColor.whiteColor;
    [contentView addSubview:aimLabel];

    UISwitch *aimSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(150, 5, 0, 0)];
    [aimSwitch addTarget:nil action:@selector(switchAimbot:) forControlEvents:UIControlEventValueChanged];
    [contentView addSubview:aimSwitch];

    UILabel *espLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 120, 25)];
    espLabel.text = @"ESP";
    espLabel.textColor = UIColor.whiteColor;
    [contentView addSubview:espLabel];

    UISwitch *espSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(150, 45, 0, 0)];
    [espSwitch addTarget:nil action:@selector(switchESP:) forControlEvents:UIControlEventValueChanged];
    [contentView addSubview:espSwitch];

    UIPanGestureRecognizer *pan =
    [[UIPanGestureRecognizer alloc] initWithTarget:nil action:@selector(handleDrag:)];
    [view addGestureRecognizer:pan];

    return view;
}

UIButton *createButton() {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(20, 200, 55, 55);
    btn.layer.cornerRadius = 27.5;
    btn.backgroundColor = UIColor.systemBlueColor;
    [btn setTitle:@"MK" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn addTarget:nil action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];

    UIPanGestureRecognizer *pan =
    [[UIPanGestureRecognizer alloc] initWithTarget:nil action:@selector(handleDrag:)];
    [btn addGestureRecognizer:pan];

    return btn;
}

%hook UIApplication
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)options {
    BOOL ret = %orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC),
    dispatch_get_main_queue(), ^{
        UIWindow *window = getKeyWindow();
        if (!window) return;

        menuView = createMenu();
        menuButton = createButton();

        [window addSubview:menuView];
        [window addSubview:menuButton];
    });

    return ret;
}
%end
