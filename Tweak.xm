#import <UIKit/UIKit.h>

// ============================== //  FFHook – TrollFools compatible //  Sin %orig fuera de métodos //  iOS 15+ (UIWindowScene) // ==============================

static UIWindow *FFGetKeyWindow(void) { for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) { if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) { UIWindowScene *ws = (UIWindowScene *)scene; for (UIWindow *w in ws.windows) { if (w.isKeyWindow) return w; } // fallback return ws.windows.firstObject; } } return nil; }

static UIView *ffPanel = nil; static UIButton *ffButton = nil; static BOOL ffVisible = NO;

static void FFBuildGUI(void) { if (ffPanel) return;

UIWindow *keyWindow = FFGetKeyWindow();
if (!keyWindow) return;

// Panel
ffPanel = [[UIView alloc] initWithFrame:CGRectMake(40, 120, 220, 160)];
ffPanel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
ffPanel.layer.cornerRadius = 16;
ffPanel.hidden = YES;

UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 220, 24)];
title.text = @"FFHook";
title.textAlignment = NSTextAlignmentCenter;
title.textColor = UIColor.whiteColor;
title.font = [UIFont boldSystemFontOfSize:18];
[ffPanel addSubview:title];

UISwitch *s1 = [[UISwitch alloc] initWithFrame:CGRectMake(20, 60, 0, 0)];
[ffPanel addSubview:s1];

UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 60, 120, 30)];
l1.text = @"Feature 1";
l1.textColor = UIColor.whiteColor;
[ffPanel addSubview:l1];

UISwitch *s2 = [[UISwitch alloc] initWithFrame:CGRectMake(20, 100, 0, 0)];
[ffPanel addSubview:s2];

UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 120, 30)];
l2.text = @"Feature 2";
l2.textColor = UIColor.whiteColor;
[ffPanel addSubview:l2];

[keyWindow addSubview:ffPanel];

// Botón flotante
ffButton = [UIButton buttonWithType:UIButtonTypeSystem];
ffButton.frame = CGRectMake(20, 300, 56, 56);
ffButton.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.85];
ffButton.layer.cornerRadius = 28;
[ffButton setTitle:@"FF" forState:UIControlStateNormal];
[ffButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
[ffButton addTarget:nil action:@selector(ff_toggle) forControlEvents:UIControlEventTouchUpInside];
[keyWindow addSubview:ffButton];

}

// Método Objective‑C real (NO Logos) para evitar %orig @interface NSObject (FFActions)

(void)ff_toggle; @end


@implementation NSObject (FFActions)

(void)ff_toggle { if (!ffPanel) return; ffVisible = !ffVisible; ffPanel.hidden = !ffVisible; } @end


// Hook mínimo: solo para construir GUI cuando la app entra a foreground %hook UIApplication

(void)applicationDidBecomeActive:(UIApplication *)application { %orig; // <-- %orig VÁLIDO (dentro de método hookeado) dispatch_async(dispatch_get_main_queue(), ^{ FFBuildGUI(); }); } %end
