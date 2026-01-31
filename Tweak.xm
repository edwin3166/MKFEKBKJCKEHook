#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

// Hook del UIApplication
CHDeclareClass(UIApplication)

CHOptimizedMethod1(self, BOOL, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {
    // Llamamos al método original
    CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);

    NSLog(@"[MKFEKBKJCKEHook] App launched - panel ready!");
    return YES;
}
