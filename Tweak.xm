#import <UIKit/UIKit.h>

static UIView *executorView = nil;
static BOOL guiShown = NO;

#pragma mark - Obtener ventana correcta (iOS 13+)

UIWindow *GetMainWindow(void) {
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive &&
            [scene isKindOfClass:[UIWindowScene class]]) {

            UIWindowScene *ws = (UIWindowScene *)scene;
            for (UIWindow *window in ws.windows) {
                if (window.isKeyWindow) {
                    return window;
                }
            }
        }
    }
    return nil;
}

#pragma mark - Crear GUI estilo iOS 26

void CreateExecutorGUI(void) {
    if (executorView) return;

    CGRect frame = CGRectMake(40, 120, 280, 180);
    executorView = [[UIView alloc] initWithFrame:frame];
    executorView.backgroundColor =
        [UIColor colorWithWhite:0.1 alpha:0.85];
    executorView.layer.cornerRadius = 22;
    executorView.clipsToBounds = YES;

    // Blur
    UIVisualEffect *blur =
        [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
    UIVisualEffectView *blurView =
        [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.frame = executorView.bounds;
    blurView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [executorView addSubview:blurView];

    // Botón ejecutar
    UIButton *runBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    runBtn.frame = CGRectMake(40, 110, 200, 44);
    runBtn.layer.cornerRadius = 14;
    runBtn.backgroundColor =
        [UIColor colorWithRed:0.2 green:0.6 blue:1 alpha:1];
    [runBtn setTitle:@"Run Script" forState:UIControlStateNormal];
    [runBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [runBtn addTarget:nil
               action:@selector(runLuaScript)
     forControlEvents:UIControlEventTouchUpInside];

    [executorView addSubview:runBtn];
}

#pragma mark - Mostrar GUI

void ShowExecutorIfNeeded(void) {
    if (guiShown) return;

    UIWindow *window = GetMainWindow();
    if (!window) return;

    CreateExecutorGUI();
    executorView.alpha = 0;
    [window addSubview:executorView];

    // Animación iOS 26 style
    [UIView animateWithDuration:0.35
                          delay:0
         usingSpringWithDamping:0.85
          initialSpringVelocity:0.5
                        options:0
                     animations:^{
        executorView.alpha = 1;
        executorView.transform = CGAffineTransformIdentity;
    } completion:nil];

    guiShown = YES;
}

#pragma mark - Acción del botón

@interface UIApplication (Executor)
- (void)runLuaScript;
@end

@implementation UIApplication (Executor)

- (void)runLuaScript {
    // 🔥 AQUÍ VA TU EXECUTOR LUA 🔥
    NSLog(@"[Executor] Run Lua Script");
}

@end

#pragma mark - Hook principal

%hook UIApplication

- (void)applicationDidBecomeActive:(UIApplication *)application {
    %orig;

    NSString *bundleID = NSBundle.mainBundle.bundleIdentifier;

    // ❌ No mostrar en SpringBoard
    if ([bundleID isEqualToString:@"com.apple.springboard"]) return;

    // Delay pequeño para asegurar ventana
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
        ShowExecutorIfNeeded();
    });
}

%end
