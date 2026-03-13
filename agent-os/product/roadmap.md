# Product Roadmap

## Phase 1: MVP

- Set up Yocto/OpenEmbedded build environment from scratch
- Create a custom BSP layer for the BeagleBone Black
  - Machine configuration
  - Bootloader (U-Boot) integration
  - Kernel configuration and recipe
- Build a minimal, bootable Linux image that runs on the BeagleBone Black hardware
- Validate the image boots successfully on the board

## Phase 2: Post-Launch

- Develop a custom kernel module / device driver for an existing BeagleBone Black peripheral (e.g. GPIO, I2C, or SPI)
- Integrate the driver as a Yocto recipe within the BSP layer
- Test and demonstrate the driver on the running image
