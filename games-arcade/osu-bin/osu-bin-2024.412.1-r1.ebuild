# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

_PN="${PN%-bin}"

DESCRIPTION="A free-to-win rhythm game. Rhythm is just a click away!"
HOMEPAGE="https://osu.ppy.sh/ https://github.com/ppy/osu"
SRC_URI="https://github.com/ppy/osu/releases/download/${PV}/osu.AppImage -> ${_PN}-${PV}.AppImage"

S="${WORKDIR}/squashfs-root"

LICENSE="MIT CC-BY-NC-4.0"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror"

RDEPEND="dev-util/lttng-ust:0/2.12"

src_unpack() {
	cp "${DISTDIR}/${_PN}-${PV}.AppImage" "${WORKDIR}/app"
	chmod +x app
	./app --appimage-extract
}

src_install() {
	insinto "/usr/lib/${_PN}"
	doins -r usr/bin/*
	chmod 755 "${D}/usr/lib/${_PN}/osu!"

	newbin "${FILESDIR}/${_PN}.bash" "${_PN}"

	newicon 'osu!.png' "${_PN}.png"
	domenu "${FILESDIR}/${_PN}.desktop"

	insinto /usr/share/mime/packages
	doins "${FILESDIR}/${_PN}.xml"
}
