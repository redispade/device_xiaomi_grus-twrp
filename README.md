# android_device_xiaomi_grus

For building TWRP for Xiaomi Mi 9 SE ONLY
Based on Kudproject device tree for Grus

To compile:

```
. build/envsetup.sh && breakfast grus eng && mka recoveryimage
```

Kernel source: Prebuilt, extracted from [miui_GRUS_9.5.30_fadcc8f3d6_9.0.zip](http://bigota.d.miui.com/9.5.30/miui_GRUS_9.5.30_fadcc8f3d6_9.0.zip)

OSS kernel from Xiaomi as a reference: [grus-p-oss](https://github.com/MiCode/Xiaomi_Kernel_OpenSource/tree/grus-p-oss)
