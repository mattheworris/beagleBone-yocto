# bootfiles_1.0.bb — Deploy boot support files for BeagleBone Black
#
# This recipe deploys extlinux.conf to the image deploy directory so it
# can be picked up by IMAGE_BOOT_FILES and placed on the FAT boot partition.
#
# CONCEPT: extlinux.conf is the standard boot configuration file for modern
# U-Boot distro boot. U-Boot searches for extlinux/extlinux.conf on each
# partition and uses it to locate and load the kernel, DTB, and kernel args.

SUMMARY = "BeagleBone Black boot files (extlinux.conf)"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

COMPATIBLE_MACHINE:beaglebone-black = "beaglebone-black"

SRC_URI = "file://extlinux.conf"

S = "${UNPACKDIR}"

# No compilation needed — just deploy the file
do_compile[noexec] = "1"
do_install[noexec] = "1"

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${UNPACKDIR}/extlinux.conf ${DEPLOYDIR}/extlinux.conf
}

addtask deploy before do_build after do_compile

inherit deploy
