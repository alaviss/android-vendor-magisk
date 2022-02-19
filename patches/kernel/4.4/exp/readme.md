# Experimental patches

These patches are not required for a successful integration, but they are used
to bring in additional features.

## Patch description

* `0002-md-dm-init-move-early-boot-DM-setup-to-a-module.patch`: This patch is
  derived from Pixel 2 XL kernel source. It moves early boot device-mapper setup
  into a module so that dm-verity is checked for the root filesystem.
