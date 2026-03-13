# Plan: Custom BSP Layer for BeagleBone Black (Yocto 5.3 Whinlatter)

## Context

The user is refreshing Yocto/OpenEmbedded skills for a job search in embedded Linux. The goal is to build a custom BSP layer from scratch for the BeagleBone Black, with step-by-step explanations so the concepts transfer to new custom hardware. The repo is currently empty. Yocto 5.3 (Whinlatter) is the target release.

A BSP (Board Support Package) layer is how Yocto encapsulates everything specific to a piece of hardware: machine configuration, bootloader, kernel, and device tree.

## Tasks

1. Save spec documentation ✓
2. Set up the Yocto build environment (clone Poky + meta-openembedded)
3. Create the custom BSP layer skeleton (`meta-beaglebone-bsp`)
4. Write the machine configuration (`beaglebone-black.conf`)
5. Configure U-Boot (`.bbappend`)
6. Configure the Linux kernel (`.bbappend`)
7. Wire everything together (`bblayers.conf` + `local.conf`)
8. First build — `bitbake core-image-minimal`

## Verification

- `bitbake core-image-minimal` completes without errors
- `build/tmp/deploy/images/beaglebone-black/` contains: MLO, u-boot.img, zImage, DTB, .wic
- Flash `.wic` to SD card and boot BBB to a Linux login prompt via serial console (115200 8N1)
