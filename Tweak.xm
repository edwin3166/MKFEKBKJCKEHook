#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

CHDeclareClass(UIApplication)

static BOOL executorVisible = NO;
static UIView *executorView = nil;
static UITextView *scriptBox = nil;
static UIButton *executeButton = nil;

// Hook al didFinishLaunchingWithOptions para agregar GUI
CHOptimizedMethod1(self, BOOL, UIApplication, didFinishLaunchingWithOptions, NSDictionary*, options) {
    BOOL ret = CHSuper1(UIApplication, didFinishLaunchingWithOptions, options);

    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    // Crear GUI executor
    executorView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 300, 400)];
    executorView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    executorView.hidden = YES;
    executorView.layer.cornerRadius = 10;
    
    scriptBox = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 280, 300)];
    scriptBox.backgroundColor = [UIColor darkGrayColor];
    scriptBox.textColor = [UIColor whiteColor];
    [executorView addSubview:scriptBox];

    executeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    executeButton.frame = CGRectMake(10, 320, 280, 50);
    [executeButton setTitle:@"Ejecutar Lua" forState:UIControlStateNormal];
    [executeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    executeButton.backgroundColor = [UIColor systemBlueColor];
    executeButton.layer.cornerRadius = 8;
    
    [executeButton addTarget:nil action:@selector(runLuaScript) forControlEvents:UIControlEventTouchUpInside];
    [executorView addSubview:executeButton];

    [window addSubview:executorView];

    return ret;
}

// Método toggle visible/invisible
CHDeclareMethod0(void, UIApplication, toggleExecutor) {
    executorVisible = !executorVisible;
    executorView.hidden = !executorVisible;
}

// Método para ejecutar Lua
CHDeclareMethod0(void, UIApplication, runLuaScript) {
    NSString *luaCode = scriptBox.text;
    if(luaCode.length > 0) {
        // Aquí es donde se evaluaría Lua dentro del cliente
        // En este ejemplo solo imprime el script
        NSLog(@"[Lua Executor] %@", luaCode);
    }
}
