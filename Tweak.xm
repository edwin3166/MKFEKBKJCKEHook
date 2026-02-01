#import <UIKit/UIKit.h>

static UIView *menuView;
static UIButton *toggleBtn;

UIWindow *getKeyWindow() {
    for (UIWindow *window in UIApplication.sharedApplication.windows) {
        if (window.isKeyWindow) {
            return window;
        }
    }
    return UIApplication.sharedApplication.windows.firstObject;
}

void showMenu() {
    UIWindow *window = getKeyWindow();
    if (!window) return;

    if (menuView) return;

    menuView = [[UIView alloc] initWithFrame:CGRectMake(40, 120, 260, 300)];
    menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    menuView.layer.cornerRadius = 18;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 260, 40)];
    title.text = @"FF Executor";
    title.textColor = UIColor.whiteColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:20];
    [menuView addSubview:title];

    UIButton *aimbot = [UIButton buttonWithType:UIButtonTypeSystem];
    aimbot.frame = CGRectMake(20, 70, 220, 44);
    [aimbot setTitle:@"Aimbot (GUI only)" forState:UIControlStateNormal];
    aimbot.backgroundColor = UIColor.systemGreenColor;
    aimbot.layer.cornerRadius = 12;
    [aimbot setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [menuView addSubview:aimbot];

    [window addSubview:menuView];
}

void createToggleButton() {
    UIWindow *window = getKeyWindow();
    if (!window) return;

    toggleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    toggleBtn.frame = CGRectMake(20, 300, 60, 60);
    toggleBtn.layer.cornerRadius = 30;
    toggleBtn.backgroundColor = UIColor.systemGreenColor;
    [toggleBtn setTitle:@"FF" forState:UIControlStateNormal];
    [toggleBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];

    [toggleBtn addTarget:nil action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];

    [window addSubview:toggleBtn];
}

@interface UIApplication (Hook)
@end

@implementation UIApplication (Hook)

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        createToggleButton();
    });
}

@end

@interface NSObject (Menu)
@end

@implementation NSObject (Menu)

- (void)toggleMenu {
    if (menuView.superview) {
        [menuView removeFromSuperview];
    } else {
        showMenu();
    }
}

@end
