# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

_PN="${PN%-bin}"
_RV="2024.904.0"

DESCRIPTION="A free-to-win rhythm game. Rhythm is just a click away!"
HOMEPAGE="https://osu.ppy.sh/ https://github.com/ppy/osu"
SRC_URI="
	https://github.com/ppy/osu/releases/download/${PV}/osu.AppImage -> ${_PN}-${PV}.AppImage
	https://github.com/ppy/osu-resources/raw/${_RV}/LICENCE.md -> osu-resources-${_RV}-LICENCE.md
"

S="${WORKDIR}/squashfs-root/usr/bin"

LICENSE="MIT CC-BY-NC-4.0"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror"

RDEPEND="
	dev-util/lttng-ust:0/2.12
	media-libs/libsdl2
"

src_unpack() {
	cp "${DISTDIR}/${_PN}-${PV}.AppImage" "${WORKDIR}/app"
	chmod +x app
	./app --appimage-extract
}

src_install() {
	rm -fv libSDL2.so

	newbin "${FILESDIR}/${_PN}.bash" "${_PN}"

	insinto "/usr/lib/${_PN}"
	doins -r *

	chmod 755 "${D}/usr/lib/${_PN}/osu!"

	newicon '../osu!.png' "${_PN}.png"
	domenu "${FILESDIR}/${_PN}.desktop"

	insinto '/usr/share/mime/packages'
	doins "${FILESDIR}/${_PN}.xml"

	insinto "/usr/share/licenses/${_PN}"
	doins "${DISTDIR}/osu-resources-${_RV}-LICENCE.md" "osu-resources-LICENCE.md"
}
