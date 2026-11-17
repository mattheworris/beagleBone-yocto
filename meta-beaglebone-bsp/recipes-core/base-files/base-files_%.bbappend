FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://serial-console.sh"

do_install:append() {
    install -d ${D}${sysconfdir}/profile.d
    install -m 0644 ${S}/serial-console.sh ${D}${sysconfdir}/profile.d/serial-console.sh
}
