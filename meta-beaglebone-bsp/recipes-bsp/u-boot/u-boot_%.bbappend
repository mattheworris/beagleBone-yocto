# u-boot_%.bbappend — BeagleBone Black U-Boot customization
#
# CONCEPT: .bbappend files extend existing recipes without forking them.
# The % wildcard matches any U-Boot version, so this append applies
# regardless of which U-Boot version OE-Core provides.
#
# This append is only applied when building for beaglebone-black because
# UBOOT_MACHINE and SPL_BINARY are already set in beaglebone-black.conf.
# The append reinforces those settings at the recipe level and adds the
# COMPATIBLE_MACHINE guard as a safety net.

# COMPATIBLE_MACHINE: A regex that restricts which machines this append
# applies to. If someone adds this layer to a build for a different board,
# BitBake will not apply this append to that machine. Always set this in
# BSP-specific appends to prevent cross-contamination between machines.
COMPATIBLE_MACHINE:beaglebone-black = "beaglebone-black"

# Confirm the defconfig for this machine.
# am335x_evm_defconfig is the TI AM335x EVM board config, which is the
# correct base for BeagleBone Black. It configures:
#   - DRAM initialization for the BBB's 512MB DDR3
#   - MMC/SD boot support
#   - FAT filesystem support (to read MLO from the boot partition)
#   - USB and Ethernet for network boot fallback
UBOOT_MACHINE = "am335x_evm_defconfig"

# UBOOT_SUFFIX: The file extension of the U-Boot binary that Yocto deploys.
# The AM335x SPL (MLO) is compiled to load u-boot.img (legacy image format),
# not u-boot.bin (flat binary). Setting this ensures the correct file is
# deployed to the images directory and picked up by IMAGE_BOOT_FILES.
UBOOT_SUFFIX = "img"

# SPL_BINARY: The filename of the SPL (Secondary Program Loader).
# The AM335x ROM code searches the FAT partition for exactly "MLO" —
# this is hardcoded in the ROM and cannot be changed. SPL_BINARY tells
# the Yocto U-Boot recipe what to name the built SPL output.
#
# Boot sequence detail:
#   1. AM335x powers on, ROM code runs from internal ROM
#   2. ROM scans SD card FAT partition for "MLO"
#   3. ROM loads MLO into internal SRAM (64KB available at 0x402F0400)
#   4. MLO (SPL) initializes PLL, DRAM controller, DDR3 at 400MHz
#   5. SPL loads u-boot.img from FAT into DRAM at 0x80800000
#   6. U-Boot runs, initializes peripherals, loads kernel + DTB
#   7. U-Boot boots the kernel via 'bootz' command
SPL_BINARY = "MLO"
