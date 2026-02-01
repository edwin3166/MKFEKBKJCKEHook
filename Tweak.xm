// Tweak.xm — GUI iOS neutral (rootless, TrollFools safe) // No hooks de cheats. Callbacks vacíos.

#import <UIKit/UIKit.h>

#pragma mark - Floating Button

@interface FFButton : UIButton @end

@implementation FFButton

(instancetype)init { self = [super initWithFrame:CGRectMake(20, 200, 56, 56)]; if (self) { self.backgroundColor = [UIColor systemBlueColor]; self.layer.cornerRadius = 28; [self setTitle:@"≡" forState:UIControlStateNormal]; self.titleLabel.font = [UIFont boldSystemFontOfSize:26]; [self addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside]; } return self; }

(void)tap { [[NSNotificationCenter defaultCenter] postNotificationName:@"FFToggleMenu" object:nil]; } @end


#pragma mark - Menu View

@interface FFMenu : UIView @end

@implementation FFMenu

(instancetype)init { self = [super initWithFrame:CGRectMake(40, 120, 280, 360)]; if (self) { self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9]; self.layer.cornerRadius = 16; self.hidden = YES;

UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 280, 28)];
  title.text = @"Menu";
  title.textColor = UIColor.whiteColor;
  title.textAlignment = NSTextAlignmentCenter;
  title.font = [UIFont boldSystemFontOfSize:18];
  [self addSubview:title];

  [self addToggle:@"Option 1" y:60 sel:@selector(t1:)];
  [self addToggle:@"Option 2" y:110 sel:@selector(t2:)];
  [self addToggle:@"Option 3" y:160 sel:@selector(t3:)];

  UISlider *sl = [[UISlider alloc] initWithFrame:CGRectMake(20, 230, 240, 30)];
  [sl addTarget:self action:@selector(slide:) forControlEvents:UIControlEventValueChanged];
  [self addSubview:sl];

} return self; }

(void)addToggle:(NSString*)name y:(CGFloat)y sel:(SEL)sel { UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 160, 30)]; l.text = name; l.textColor = UIColor.whiteColor; [self addSubview:l];

UISwitch *s = [[UISwitch alloc] initWithFrame:CGRectMake(200, y, 0, 0)]; [s addTarget:self action:sel forControlEvents:UIControlEventValueChanged]; [self addSubview:s]; }

(void)t1:(UISwitch*)s { NSLog(@"T1 %d", s.isOn); }

(void)t2:(UISwitch*)s { NSLog(@"T2 %d", s.isOn); }

(void)t3:(UISwitch*)s { NSLog(@"T3 %d", s.isOn); }

(void)slide:(UISlider*)sl { NSLog(@"Slider %f", sl.value); }


@end

#pragma mark - Loader (NO %orig fuera de hooks)

static FFMenu *gMenu;

%ctor { dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{ UIWindow *w = UIApplication.sharedApplication.keyWindow; if (!w) return;

FFButton *btn = [[FFButton alloc] init];
    gMenu = [[FFMenu alloc] init];

    [w addSubview:btn];
    [w addSubview:gMenu];

    [[NSNotificationCenter defaultCenter] addObserverForName:@"FFToggleMenu"
                                                      object:nil
                                                       queue:NSOperationQueue.mainQueue
                                                  usingBlock:^(NSNotification * _Nonnull note) {
        gMenu.hidden = !gMenu.hidden;
    }];
});

}
