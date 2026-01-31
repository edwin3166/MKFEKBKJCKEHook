#import <UIKit/UIKit.h>

static BOOL aimBotEnabled = NO;
static BOOL espEnabled = NO;

@interface MKMenuView : UIView
@property (nonatomic, strong) UIButton *minimizeButton;
@property (nonatomic, strong) UISwitch *aimbotSwitch;
@property (nonatomic, strong) UISwitch *espSwitch;
@property (nonatomic, assign) BOOL minimized;
@end

@implementation MKMenuView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(20, 100, 220, 160)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
        self.layer.cornerRadius = 12;
        self.clipsToBounds = YES;

        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 220, 20)];
        title.text = @"MK Panel";
        title.textColor = UIColor.whiteColor;
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:title];

        // Aimbot
        UILabel *aimLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 120, 30)];
        aimLabel.text = @"Aimbot";
        aimLabel.textColor = UIColor.whiteColor;
        [self addSubview:aimLabel];

        self.aimbotSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(150, 40, 0, 0)];
        [self.aimbotSwitch addTarget:self action:@selector(toggleAimbot:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.aimbotSwitch];

        // ESP
        UILabel *espLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 120, 30)];
        espLabel.text = @"ESP";
        espLabel.textColor = UIColor.whiteColor;
        [self addSubview:espLabel];

        self.espSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(150, 80, 0, 0)];
        [self.espSwitch addTarget:self action:@selector(toggleESP:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.espSwitch];

        // Minimize button
        self.minimizeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.minimizeButton.frame = CGRectMake(10, 120, 200, 30);
        [self.minimizeButton setTitle:@"Minimizar" forState:UIControlStateNormal];
        [self.minimizeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.minimizeButton addTarget:self action:@selector(toggleMinimize) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.minimizeButton];

        // Drag
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)toggleAimbot:(UISwitch *)sw {
    aimBotEnabled = sw.isOn;
    NSLog(@"[MK] Aimbot %@", aimBotEnabled ? @"ON" : @"OFF");
}

- (void)toggleESP:(UISwitch *)sw {
    espEnabled = sw.isOn;
    NSLog(@"[MK] ESP %@", espEnabled ? @"ON" : @"OFF");
}

- (void)toggleMinimize {
    self.minimized = !self.minimized;

    if (self.minimized) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 120, 40);
        [self.minimizeButton setTitle:@"Abrir" forState:UIControlStateNormal];
        self.aimbotSwitch.hidden = YES;
        self.espSwitch.hidden = YES;
        for (UIView *v in self.subviews) {
            if ([v isKindOfClass:[UILabel class]] && ![(UILabel *)v.text isEqualToString:@"MK Panel"]) {
                v.hidden = YES;
            }
        }
    } else {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 220, 160);
        [self.minimizeButton setTitle:@"Minimizar" forState:UIControlStateNormal];
        self.aimbotSwitch.hidden = NO;
        self.espSwitch.hidden = NO;
        for (UIView *v in self.subviews) {
            v.hidden = NO;
        }
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:self.superview];
    self.center = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:self.superview];
}

@end

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIWindow *window = UIApplication.sharedApplication.connectedScenes.allObjects.count
            ? ((UIWindowScene *)UIApplication.sharedApplication.connectedScenes.allObjects.firstObject).windows.firstObject
            : nil;

        if (!window) return;

        MKMenuView *menu = [[MKMenuView alloc] init];
        [window addSubview:menu];
    });
}
