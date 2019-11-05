# android_device_xiaomi_grus

Android 10 (and 9-compatible) TWRP Device tree for Xiaomi Mi9SE(grus)

To compile:

```
. build/envsetup.sh

breakfast grus eng

mka adbd recoveryimage

```

Kernel source: Kowalski Kernel fork, modded for twrp:
https://github.com/redispade/kowalski-grus
Original kernel:
https://github.com/pengus77/kowalski-grus
