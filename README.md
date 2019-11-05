# android_device_xiaomi_grus

Android 10 (and 9-compatible) TWRP Device tree for Xiaomi Mi9SE(grus)

To compile:

```
. build/envsetup.sh

breakfast grus eng

mka adbd recoveryimage ALLOW_MISSING_DEPENDENCIES=true

```

Kernel source: Kowalski Kernel
https://github.com/pengus77/kowalski-grus
