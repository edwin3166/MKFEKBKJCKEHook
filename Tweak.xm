#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CaptainHook/CaptainHook.h>

// --------------------------
// Toggle global para AimKill
// --------------------------
static BOOL AimKillEnabled = YES;

void setAimKillEnabled(BOOL enabled) {
    AimKillEnabled = enabled;
}

BOOL isAimKillEnabled() {
    return AimKillEnabled;
}

// --------------------------
// Clase original MKFEKBKJCKE
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
    // Código original del AimKill
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
// Hook: agregar botón flotante al inicio de la app
// --------------------------
CHDeclareClass(UIApplication)

CHOptimizedMethod1(self, BOOL, UIApplication, didFinishLaunchingWithOptions, NSDictionary *, options) {

    BOOL result = CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);

    // Crear botón flotante
    UIButton *aimkillButton = [UIButton buttonWithType:UIButtonTypeSystem];
    aimkillButton.frame = CGRectMake(20, 100, 140, 40);
    [aimkillButton setTitle:@"AimKill ON" forState:UIControlStateNormal];
    aimkillButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    aimkillButton.layer.cornerRadius = 8;

    [aimkillButton addTarget:self action:@selector(toggleAimKill:) forControlEvents:UIControlEventTouchUpInside];

    // Añadir al keyWindow
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow addSubview:aimkillButton];
    });

    return result;
}

// --------------------------
// Método para toggle
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

    // Instancia de prueba para UpdateAimKill
    MKFEKBKJCKE *aimkill = [[MKFEKBKJCKE alloc] init];
    [aimkill UpdateAimKill];
}
    // Instancia de prueba para UpdateAimKill
    MKFEKBKJCKE *aimkill = [[MKFEKBKJCKE alloc] init];
    [aimkill UpdateAimKill];

    // Puedes llamar UpdateAimKill periódicamente o dentro del hook de Free Fire
}
