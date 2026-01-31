#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

CHDeclareClass(UIApplication)

static BOOL executorVisible = NO;
static UIView *executorView = nil;
static UITextView *scriptBox = nil;
static UIButton *executeButton = nil;
static UIButton *toggleButton = nil;

CHOptimizedMethod1(self, BOOL, UIApplication, didFinishLaunchingWithOptions, NSDictionary*, options) {
    BOOL ret = CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);

    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    // Botón flotante toggle
    toggleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    toggleButton.frame = CGRectMake(window.bounds.size.width - 70, 150, 60, 60);
    toggleButton.layer.cornerRadius = 30;
    toggleButton.backgroundColor = [[UIColor systemBlueColor] colorWithAlphaComponent:0.8];
    [toggleButton setTitle:@"Lua" forState:UIControlStateNormal];
    [toggleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    toggleButton.layer.shadowColor = [UIColor blackColor].CGColor;
    toggleButton.layer.shadowOpacity = 0.3;
    toggleButton.layer.shadowOffset = CGSizeMake(0,4);
    toggleButton.layer.shadowRadius = 6;
    [toggleButton addTarget:nil action:@selector(toggleExecutor) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:toggleButton];

    // Vista del executor
    executorView = [[UIView alloc] initWithFrame:CGRectMake(30, 120, window.bounds.size.width - 60, 400)];
    executorView.backgroundColor = [[UIColor systemGray6Color] colorWithAlphaComponent:0.95];
    executorView.layer.cornerRadius = 20;
    executorView.layer.masksToBounds = YES;
    executorView.hidden = YES;

    // TextView para scripts
    scriptBox = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, executorView.frame.size.width - 30, 300)];
    scriptBox.backgroundColor = [[UIColor systemGray5Color] colorWithAlphaComponent:0.8];
    scriptBox.textColor = [UIColor labelColor];
    scriptBox.layer.cornerRadius = 15;
    scriptBox.text = @"-- Escribe tu script Lua aquí";
    [executorView addSubview:scriptBox];

    // Botón ejecutar
    executeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    executeButton.frame = CGRectMake(15, 325, executorView.frame.size.width - 30, 50);
    executeButton.backgroundColor = [[UIColor systemGreenColor] colorWithAlphaComponent:0.9];
    [executeButton setTitle:@"Ejecutar Lua" forState:UIControlStateNormal];
    [executeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    executeButton.layer.cornerRadius = 12;
    [executeButton addTarget:nil action:@selector(runLuaScript) forControlEvents:UIControlEventTouchUpInside];
    [executorView addSubview:executeButton];

    [window addSubview:executorView];

    return ret;
}

// Toggle para mostrar/ocultar executor
CHDeclareMethod0(void, UIApplication, toggleExecutor) {
    executorVisible = !executorVisible;
    executorView.hidden = !executorVisible;
}

// Ejecutar Lua
CHDeclareMethod0(void, UIApplication, runLuaScript) {
    NSString *luaCode = scriptBox.text;
    if(luaCode.length > 0) {
        NSLog(@"[Lua Executor] %@", luaCode);

        // TODO: Integrar LuaJIT o motor Lua para ejecutar código real
        // Ejemplo:
        // luaL_dostring(L, [luaCode UTF8String]);
    }
}
