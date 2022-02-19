# Magisk integration for ROM builders

If you have this crazy idea of running a verified boot system with Magisk
integrated, this is the stuff for you.

This repository should be cloned into `vendor/magisk`.

## Tested on

* Google Pixel 2 XL (taimen) | Android 12

This is developed with devices using legacy SAR booting method and doesn't use
any convoluted init scheme (ie. Sony)

## How to use

* Add the following to your device `BoardConfig.mk`:

```makefile
include vendor/magisk/BoardConfigMagisk.mk
```

* Add the following to the product Makefile:

```makefile
PRODUCT_PACKAGES += magiskinit.recovery
```

* Apply the patches in `patches/` to their respective projects.

The resulting ROM should have `magiskinit` integrated. After first boot,
download the latest version of Magisk from
[here](https://github.com/topjohnwu/Magisk/releases/latest) and install it.

## Notes

* There is no advantage to integrating Magisk into the ROM except to employ
  verified boot. If you are not looking to use verified boot, don't bother with
  this and install Magisk the normal way, it's easier and is officially
  supported.

* On some legacy SAR devices (taimen), the kernel will only setup dm-verity
  only if the initramfs was not used. Some patching might have to be done to
  make the kernel set it up anyway.
