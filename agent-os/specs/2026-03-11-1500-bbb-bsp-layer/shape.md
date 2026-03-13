# BBB BSP Layer — Shaping Notes

## Scope

Build a custom Yocto BSP layer (`meta-beaglebone-bsp`) from scratch for the BeagleBone Black targeting Yocto 5.3 (Whinlatter). Each step is explained in detail so the user can transfer the skills to new custom hardware.

## Decisions

- **Yocto release:** Whinlatter 5.3 (user's choice — latest available)
- **Layer name:** `meta-beaglebone-bsp` (follows `meta-<boardname>` convention)
- **Image target:** `core-image-minimal` (smallest useful image to validate BSP)
- **Distro:** `poky` (Yocto reference distro — no custom distro layer needed for now)
- **References:** Yocto BSP Developer's Guide + meta-ti + meta-beaglebone

## Context

- **Visuals:** None
- **References:** Yocto Project BSP Developer's Guide, meta-ti (TI official layer), meta-beaglebone (community)
- **Product alignment:** Phase 1 MVP — custom BSP layer with bootable image
- **Teaching goal:** User must understand each step deeply enough to apply to unfamiliar hardware

## Standards Applied

None — standards index is empty.
