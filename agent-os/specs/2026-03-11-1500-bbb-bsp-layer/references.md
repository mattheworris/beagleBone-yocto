# References for BBB BSP Layer

## Yocto Project BSP Developer's Guide

- **URL:** https://docs.yoctoproject.org/bsp-guide/
- **Relevance:** Canonical reference for BSP layer structure, machine configuration variables, and best practices
- **Key sections:** "Preparing Your Build Host to Work With BSP Layers", "BSP Layers", "Creating a New BSP Layer Using the bitbake-layers Script"

## meta-ti (Texas Instruments Official Yocto Layer)

- **URL:** https://git.yoctoproject.org/meta-ti
- **Relevance:** TI's official Yocto layer for AM335x (the SoC on BeagleBone Black). Contains reference machine configs, U-Boot and kernel recipes for AM335x-based boards.
- **Key patterns:** How TI structures machine conf files for AM335x, their U-Boot defconfig choices, kernel device tree references

## meta-beaglebone (Community Layer)

- **URL:** https://github.com/beagleboard/meta-beagleboard
- **Relevance:** Community-maintained BSP for BeagleBone boards. Good reference for BeagleBone-specific quirks.
- **Key patterns:** IMAGE_BOOT_FILES layout, WIC kickstart file for SD card partitioning

## AM335x Technical Reference Manual

- **Source:** Texas Instruments (ti.com)
- **Relevance:** Authoritative source for AM335x boot sequence, memory map, peripheral addresses
- **Key sections:** Section 26 (Initialization), ROM code boot flow, memory map

## BeagleBone Black System Reference Manual

- **Source:** beagleboard.org
- **Relevance:** Board-level details: UART header pinout, SD card slot, eMMC layout, power sequencing
