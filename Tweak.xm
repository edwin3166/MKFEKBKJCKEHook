#import <UIKit/UIKit.h>

static UIWindow *ffWindow = nil;

static void FFBuildGUI(void) {
    if (ffWindow) return;

    ffWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ffWindow.windowLevel = UIWindowLevelAlert + 1;
    ffWindow.backgroundColor = [UIColor clearColor];
    ffWindow.hidden = NO;

    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor clearColor];
    ffWindow.rootViewController = vc;

    // 👉 AQUÍ llamas tus funciones de cheats
    // FFEnableAimbot();
    // FFNoRecoil();
    // FFWallhack();
}

%hook UIApplication
- (void)applicationDidBecomeActive:(UIApplication *)application {
    %orig;          // ✔️ uso correcto
    FFBuildGUI();   // inicia GUI
}
%end
