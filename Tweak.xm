#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CaptainHook/CaptainHook.h>

// --------------------------
// Toggle global AimKill
// --------------------------
static BOOL AimKillEnabled = YES;
void setAimKillEnabled(BOOL enabled) { AimKillEnabled = enabled; }
BOOL isAimKillEnabled() { return AimKillEnabled; }

// --------------------------
// Clase AimKill original
// --------------------------
@interface MKFEKBKJCKE : NSObject
@property (nonatomic) float AHFNKDJFBEA;
@property (nonatomic) int BOJDJLMBIMB;
@property (nonatomic) int GFPPJCPHMHE;
@property (nonatomic) float HDLKIEHBAKG;
@property (nonatomic) float HJMDIBKNPLO;
@property (nonatomic) float CNNNMCAMAEM;
@property (nonatomic) float GHNEHECJLNM;
@property (nonatomic) float EDHBKJJPLCP;
@property (nonatomic) float IKJJGKIEDNN;
@property (nonatomic) float PCBKGKIIDKO;
@property (nonatomic) float GFPECMNILBK;
- (void)UpdateAimKill;
@end

@implementation MKFEKBKJCKE

- (instancetype)init {
    self = [super init];
    if (self) {
        _AHFNKDJFBEA = 0;
        _BOJDJLMBIMB = 0;
        _GFPPJCPHMHE = 0;
        _HDLKIEHBAKG = 0;
        _HJMDIBKNPLO = 0;
        _CNNNMCAMAEM = 0;
        _GHNEHECJLNM = 0;
        _EDHBKJJPLCP = 0;
        _IKJJGKIEDNN = 0;
        _PCBKGKIIDKO = 0;
        _GFPECMNILBK = 0;
    }
    return self;
}

- (void)UpdateAimKill {
    if (!isAimKillEnabled()) {
        NSLog(@"[AimKill] Desactivado");
        return;
    }

    // --------------------------
    // Código de AimKill para Free Fire
    // --------------------------
    _HDLKIEHBAKG += 1.0f;
    _HJMDIBKNPLO += 2.0f;
    _CNNNMCAMAEM += 3.0f;
    _GHNEHECJLNM += 4.0f;
    _EDHBKJJPLCP += 5.0f;

    NSLog(@"[AimKill] Ejecutado");
}

@end

// --------------------------
// Hook para añadir botón flotante
// --------------------------
CHDeclareClass(UIApplication)

CHOptimizedMethod1(self, BOOL, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {
    BOOL result = CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);

    // Obtener la ventana principal compatible con iOS 13+
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;

    // Crear botón flotante
    UIButton *aimkillButton = [UIButton buttonWithType:UIButtonTypeSystem];
    aimkillButton.frame = CGRectMake(20, 100, 140, 40);
    [aimkillButton setTitle:@"AimKill ON" forState:UIControlStateNormal];
    aimkillButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    aimkillButton.layer.cornerRadius = 8;
    [aimkillButton addTarget:self action:@selector(toggleAimKill:) forControlEvents:UIControlEventTouchUpInside];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [window addSubview:aimkillButton];
    });

    return result;
}

// --------------------------
// Método toggle
// --------------------------
CHDeclareMethod1(void, UIApplication, toggleAimKill, UIButton*, sender) {
    AimKillEnabled = !AimKillEnabled;
    NSString *title = AimKillEnabled ? @"AimKill ON" : @"AimKill OFF";
    [sender setTitle:title forState:UIControlStateNormal];
    NSLog(@"[AimKill] Toggle: %@", AimKillEnabled ? @"ON" : @"OFF");
}

// --------------------------
// Constructor del tweak
// --------------------------
CHConstructor {
    NSLog(@"[MKFEKBKJCKEHook] Tweak cargado");

    MKFEKBKJCKE *aimkill = [[MKFEKBKJCKE alloc] init];
    [aimkill UpdateAimKill];
}
