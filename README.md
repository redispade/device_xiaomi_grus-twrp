# android_device_xiaomi_grus

For building TWRP for Xiaomi Mi 9 SE ONLY
Based on Kudproject device tree for Grus

To compile:

```
. build/envsetup.sh
breakfast grus eng
mka adbd recoveryimage ALLOW_MISSING_DEPENDENCIES=true
```

Kernel source: Prebuilt, Okita Kernel

