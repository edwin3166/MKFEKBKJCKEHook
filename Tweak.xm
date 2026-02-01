#import <UIKit/UIKit.h>

@interface RBLXRootViewController : UIViewController
@end

static UIView *rbxGUI = nil;

static void showRobloxGUI() {
    if (rbxGUI) return;

    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) return;

    CGFloat width = 260;
    CGFloat height = 160;

    rbxGUI = [[UIView alloc] initWithFrame:CGRectMake(
        (keyWindow.bounds.size.width - width) / 2,
        100,
        width,
        height
    )];

    rbxGUI.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    rbxGUI.layer.cornerRadius = 14;
    rbxGUI.layer.borderWidth = 1.5;
    rbxGUI.layer.borderColor = UIColor.whiteColor.CGColor;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, width, 30)];
    title.text = @"Roblox Executor";
    title.textColor = UIColor.whiteColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:18];
    [rbxGUI addSubview:title];

    UIButton *close = [UIButton buttonWithType:UIButtonTypeSystem];
    close.frame = CGRectMake(width - 40, 5, 35, 35);
    [close setTitle:@"✕" forState:UIControlStateNormal];
    close.tintColor = UIColor.redColor;
    [close addTarget:nil action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    [rbxGUI addSubview:close];

    UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, width - 20, 80)];
    info.text = @"GUI activo\n(Executor base)";
    info.textColor = UIColor.whiteColor;
    info.textAlignment = NSTextAlignmentCenter;
    info.numberOfLines = 2;
    info.font = [UIFont systemFontOfSize:15];
    [rbxGUI addSubview:info];

    [keyWindow addSubview:rbxGUI];
}

%hook RBLXRootViewController

- (void)viewDidAppear:(BOOL)animated {
    %orig;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            showRobloxGUI();
        });
    });
}

%end
