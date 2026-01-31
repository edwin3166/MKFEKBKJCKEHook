#include <substrate.h>
#include <mach-o/dyld.h>
#include <Foundation/Foundation.h>

struct MKFEKBKJCKE {
    void* klass;    // 0x0
    void* monitor;  // 0x8

    float AHFNKDJFBEA; // 0x10
    int   BOJDJLMBIMB; // 0x14
    int   GFPPJCPHMHE; // 0x18
    float HDLKIEHBAKG; // 0x1C
    float HJMDIBKNPLO; // 0x20
    float CNNNMCAMAEM; // 0x24
    float GHNEHECJLNM; // 0x28
    float EDHBKJJPLCP; // 0x2C
    float IKJJGKIEDNN; // 0x30
    float PCBKGKIIDKO; // 0x34
    float GFPECMNILBK; // 0x38
};

void (*orig_Method)(MKFEKBKJCKE* self);

void hook_Method(MKFEKBKJCKE* self) {
    // Passthrough: mantiene el código original
    orig_Method(self);
}

__attribute__((constructor))
static void init() {
    uintptr_t base = (uintptr_t)_dyld_get_image_vmaddr_slide(0);
    uintptr_t addr = base + 0x4F16C30; // RVA del método

    MSHookFunction(
        (void*)addr,
        (void*)&hook_Method,
        (void**)&orig_Method
    );

    NSLog(@"[MKFEKBKJCKE] Hook cargado");
}
