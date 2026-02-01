#import <UIKit/UIKit.h>

// MARK: - Helpers static UIWindow *GetActiveWindow(void) { for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) { if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:UIWindowScene.class]) { UIWindowScene *ws = (UIWindowScene *)scene; for (UIWindow *w in ws.windows) { if (w.isKeyWindow) return w; } return ws.windows.firstObject; } } return nil; }

// MARK: - Simple iOS 26 style overlay @interface MKExecutorView : UIView @property (nonatomic, strong) UITextView *editor; @end

@implementation MKExecutorView

(instancetype)initWithFrame:(CGRect)frame { if ((self = [super initWithFrame:frame])) { self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.12]; self.layer.cornerRadius = 22; self.layer.masksToBounds = YES; self.layer.borderWidth = 0.5; self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.25].CGColor;

UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
  UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
  blurView.frame = self.bounds;
  blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self addSubview:blurView];

  _editor = [[UITextView alloc] initWithFrame:CGRectInset(self.bounds, 12, 12)];
  _editor.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _editor.backgroundColor = UIColor.clearColor;
  _editor.textColor = UIColor.labelColor;
  _editor.font = [UIFont monospacedSystemFontOfSize:14 weight:UIFontWeightRegular];
  _editor.text = @"-- Lua executor (placeholder)\nprint(\"Hello iOS 26\")";
  [self addSubview:_editor];

} return self; } @end


// MARK: - Logos Hook (NO CaptainHook) %hook UIApplication

(void)toggleExecutor { UIWindow *window = GetActiveWindow(); if (!window) return;

UIView *existing = [window viewWithTag:0xBEEF]; if (existing) { [existing removeFromSuperview]; return; }

CGFloat w = MIN(window.bounds.size.width - 24, 360); CGFloat h = MIN(window.bounds.size.height - 24, 420); CGRect frame = CGRectMake((window.bounds.size.width - w)/2.0, (window.bounds.size.height - h)/2.0, w, h);

MKExecutorView *panel = [[MKExecutorView alloc] initWithFrame:frame]; panel.tag = 0xBEEF;

// Shadow panel.layer.shadowColor = UIColor.blackColor.CGColor; panel.layer.shadowOpacity = 0.25; panel.layer.shadowRadius = 24; panel.layer.shadowOffset = CGSizeMake(0, 12);

[window addSubview:panel]; }

(void)runLuaScript { // Placeholder: integrate your Lua VM / bridge here }


%end
