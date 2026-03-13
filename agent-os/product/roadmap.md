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

- Configure USB gadget serial so the BBB USB cable provides a /dev/ttyACM0 login console on the host (like Debian), without requiring a physical UART adapter
  - Enable CONFIG_USB_GADGET + CONFIG_USB_G_SERIAL in the kernel config
  - Add a getty on the gadget serial port via a systemd/SysV service
- Develop a custom kernel module / device driver for an existing BeagleBone Black peripheral (e.g. GPIO, I2C, or SPI)
- Integrate the driver as a Yocto recipe within the BSP layer
- Test and demonstrate the driver on the running image
