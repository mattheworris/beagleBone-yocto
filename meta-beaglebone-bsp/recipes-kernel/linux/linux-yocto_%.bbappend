# linux-yocto_%.bbappend — BeagleBone Black kernel customization
#
# CONCEPT: .bbappend files extend existing recipes without forking them.
# The % wildcard matches any linux-yocto version.
#
# NOTE ON OVERRIDE SYNTAX: Since Yocto Honister (4.0), variable overrides
# use ':' instead of '_'. e.g. VARIABLE:machine-name not VARIABLE_machine-name.
# Using the old '_' syntax causes silent failures — BitBake treats it as a
# literal variable name rather than an override, which is why getting this
# wrong produces confusing errors.

# COMPATIBLE_MACHINE: Restrict this append to beaglebone-black only.
# Uses the new ':' override syntax (required since Yocto 4.0+).
COMPATIBLE_MACHINE:beaglebone-black = "beaglebone-black"

# KBUILD_DEFCONFIG: Use the upstream kernel's own defconfig for AM335x/OMAP.
# This file lives in the kernel source tree at:
#   arch/arm/configs/omap2plus_defconfig
#
# Why this approach instead of linux-yocto BSP metadata?
# - More portable: survives linux-yocto version upgrades
# - Closer to mainline: uses TI/community-maintained config, not Yocto's copy
# - Transferable skill: same approach works for any SoC with an upstream defconfig
# - omap2plus_defconfig covers the full OMAP/AM335x family including BeagleBone
KBUILD_DEFCONFIG = "omap2plus_defconfig"

# KCONFIG_MODE: Tell linux-yocto to use KBUILD_DEFCONFIG as the base config.
# "defconfig" mode runs 'make <KBUILD_DEFCONFIG>' to generate the initial
# .config, then applies any additional config fragments from SRC_URI on top.
# KCONFIG_MODE controls the base config used when merging fragments.
#
# "defconfig" triggers merge_config.sh -n (allnoconfig base): everything is
# disabled by default. Options like CONFIG_PRINTK, CONFIG_TTY, CONFIG_MMU,
# CONFIG_ARCH_MULTI_V7 that omap2plus_defconfig assumes are always on must
# all be added explicitly — a maintenance burden that grows indefinitely.
#
# "alldefconfig" uses alldefconfig as base: Kconfig defaults are applied
# first (PRINTK=y, TTY=y, MMU=y, etc.), then omap2plus_defconfig overrides
# OMAP-specific options, then our .cfg fragment overrides BBB-specific ones.
# This is the correct mode when using an upstream defconfig as a fragment.
KCONFIG_MODE = "alldefconfig"

# LINUX_VERSION_EXTENSION: Appends to the kernel version string in 'uname -r'.
# Useful for identifying your custom kernel vs a distro kernel.
LINUX_VERSION_EXTENSION = "-beaglebone-bsp"

# FILESEXTRAPATHS: Prepend our layer's recipe directory to the file search
# path so BitBake finds our config fragment. The :prepend ensures our files
# take priority over any same-named files in other layers.
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# SRC_URI: Add our config fragment on top of omap2plus_defconfig.
# linux-yocto applies all .cfg fragments after the base defconfig is generated.
SRC_URI:append:beaglebone-black = " file://beaglebone-black.cfg"
SRC_URI += "file://0001-ARM-dts-am335x-boneblack-enable-UART4-on-P9.11-P9.13.patch"

