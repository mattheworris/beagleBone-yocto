# BeagleBone Black Yocto BSP

A custom Yocto BSP (Board Support Package) layer for the BeagleBone Black,
targeting Yocto Project 5.3 (Whinlatter).

## Repository Structure

```
meta-beaglebone-bsp/          ← Our custom BSP layer
├── conf/
│   ├── layer.conf            ← Registers the layer with BitBake
│   └── machine/
│       └── beaglebone-black.conf  ← Machine definition (CPU, bootloader, kernel)
├── recipes-bsp/
│   └── u-boot/
│       └── u-boot_%.bbappend     ← U-Boot customization (defconfig, SPL)
├── recipes-kernel/
│   └── linux/
│       └── linux-yocto_%.bbappend ← Kernel customization (device tree, BSP name)
└── wic/
    └── beaglebone-black.wks  ← SD card partition layout

conf-templates/               ← Copy these into your build/conf/
├── local.conf.sample         ← Per-developer build settings
└── bblayers.conf.sample      ← Layer list template

agent-os/                     ← Project documentation (AI-assisted)
└── product/
    ├── mission.md
    ├── roadmap.md
    └── tech-stack.md
```

## Host Setup

Tested on Ubuntu 22.04 / 24.04.

```bash
sudo apt-get install build-essential chrpath cpio debianutils diffstat file \
  gawk gcc git iputils-ping libacl1 locales python3 python3-git python3-jinja2 \
  python3-pexpect python3-pip python3-subunit socat texinfo unzip wget xz-utils zstd
```

Ensure the `en_US.UTF-8` locale is enabled:

```bash
locale -a | grep en_US.utf8
# If missing:
sudo locale-gen en_US.UTF-8
```

Minimum specs: 140 GB free disk, 8 GB RAM (32 GB recommended for fast builds).

## Build Environment Setup (Whinlatter 5.3+)

Yocto 5.3 uses `bitbake-setup init` instead of the traditional Poky clone.

**Step 1: Clone BitBake**

```bash
git clone https://git.openembedded.org/bitbake
```

**Step 2: Initialize the build environment**

Run the interactive setup tool:
```bash
./bitbake/bin/bitbake-setup init
```

When prompted, select:
- Configuration: `poky-master` (or the whinlatter-tagged option if available)
- Distribution: `distro/poky`
- Machine: `qemux86-64` (we'll override this for BBB in local.conf)
- Setup directory name: choose a name or accept the default

This creates a directory (e.g. `poky-master-poky-distro_poky-machine_qemux86-64/`)
containing a `build/` subdirectory with `conf/local.conf` and `conf/bblayers.conf`.

**Step 3: Add the BeagleBone BSP layer**

```bash
# Source the build environment (adjust path to match your setup directory)
source poky-master-*/build/init-build-env

# Add our BSP layer
bitbake-layers add-layer /path/to/beagleBone-yocto/meta-beaglebone-bsp
```

**Step 4: Configure for BeagleBone Black**

Edit `build/conf/local.conf` and set:
```
MACHINE = "beaglebone-black"
```

Or copy the template:
```bash
cp /path/to/beagleBone-yocto/conf-templates/local.conf.sample build/conf/local.conf
```

## Building

```bash
# Source the environment (run this every new terminal session)
source poky-master-*/build/init-build-env

# Build a minimal bootable image
bitbake core-image-minimal
```

First build downloads sources and compiles everything from scratch — expect
2-4 hours depending on your hardware. Subsequent builds use the sstate cache
and are much faster (minutes for incremental changes).

## Output Artifacts

After a successful build, find images in:
```
build/tmp/deploy/images/beaglebone-black/
├── MLO                              ← First-stage bootloader (SPL, ~100KB)
├── u-boot.img                       ← U-Boot bootloader
├── zImage                           ← Compressed Linux kernel
├── am335x-boneblack.dtb             ← Device Tree Blob
├── core-image-minimal-beaglebone-black.ext4  ← Root filesystem
└── core-image-minimal-beaglebone-black.wic   ← Complete SD card image ← USE THIS
```

## Flashing to SD Card

```bash
# Find your SD card device (check dmesg after inserting)
lsblk

# Flash the complete image (replace sdX with your device — BE CAREFUL)
sudo dd if=build/tmp/deploy/images/beaglebone-black/core-image-minimal-beaglebone-black.wic \
        of=/dev/sdX bs=4M status=progress conv=fsync

# Alternative: faster with bmaptool
sudo bmaptool copy core-image-minimal-beaglebone-black.wic /dev/sdX
```

## Serial Console

Connect a 3.3V USB-UART adapter to the J1 header (6-pin, near the 5V barrel jack):
- Pin 1: GND (black)
- Pin 4: RX (connect to TX of adapter)
- Pin 5: TX (connect to RX of adapter)

Settings: **115200 baud, 8N1, no flow control**

```bash
# minicom
minicom -D /dev/ttyUSB0 -b 115200

# or screen
screen /dev/ttyUSB0 115200
```

Boot the BBB with the SD card inserted while holding the S2 (Boot) button to
force SD boot on boards that have eMMC loaded.

## Key Concepts

| Concept | What it is |
|---|---|
| BitBake | The build engine — reads recipes, resolves dependencies, runs tasks |
| Recipe (`.bb`) | Instructions for fetching, patching, compiling, and packaging one software component |
| Append (`.bbappend`) | Extends a recipe without forking it |
| Layer | A directory of recipes grouped by purpose (BSP, distro, app) |
| Machine config | Defines CPU arch, bootloader, kernel, console for one board |
| SSTATE cache | BitBake's build cache — skip tasks whose inputs haven't changed |
| WIC | Tool that assembles a partitioned disk image from built artifacts |
| Device Tree | Hardware description passed to the kernel at boot (arch/arm/boot/dts/) |
| SPL/MLO | Tiny first-stage bootloader that fits in SRAM and initializes DRAM |

## References

- [Yocto Project Quick Build](https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html)
- [Yocto BSP Developer's Guide](https://docs.yoctoproject.org/bsp-guide/)
- [meta-ti (TI official layer)](https://git.yoctoproject.org/meta-ti)
- [AM335x Technical Reference Manual](https://www.ti.com/lit/ug/spruh73/spruh73.pdf)
- [BeagleBone Black SRM](https://github.com/beagleboard/beaglebone-black/wiki/System-Reference-Manual)
