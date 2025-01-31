# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

_PN="${PN%-bin}"
_RV="2024.1224.0"

DESCRIPTION="A free-to-win rhythm game. Rhythm is just a click away!"
HOMEPAGE="https://osu.ppy.sh/ https://github.com/ppy/osu"
SRC_URI="
	https://github.com/ppy/osu/releases/download/${PV}/osu.AppImage -> ${_PN}-${PV}.AppImage
	https://github.com/ppy/osu-resources/raw/${_RV}/LICENCE.md -> osu-resources-${_RV}-LICENCE.md
"

S="${WORKDIR}/squashfs-root"

LICENSE="MIT CC-BY-NC-4.0"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror"

DEPEND="
	dev-util/lttng-ust:0/2.12
	media-libs/libsdl3
	x11-themes/hicolor-icon-theme
"
RDEPEND="${DEPEND}"
BDEPEND="media-gfx/imagemagick"

src_unpack() {
	cp "${DISTDIR}/${_PN}-${PV}.AppImage" "${WORKDIR}/appimage"
	chmod +x "${WORKDIR}/appimage"
	"${WORKDIR}/appimage" --appimage-extract
}

src_prepare() {
	default

	mkdir -v icons

	pushd usr/bin
		# Use system sdl
		rm -fv libSDL{2,3}.so

		# Remove pdb files
		rm -fv *.pdb
	popd

	pushd icons
		magick -verbose "${S}/usr/bin/lazer.ico" osu.png
		magick -verbose "${S}/usr/bin/beatmap.ico" beatmap.png

		eval $(magick identify -format "mv -v %f osu-%G;" osu*.png)
		eval $(magick identify -format "mv -v %f beatmap-%G;" beatmap*.png)

		for icon in "${S}"/usr/share/icons/hicolor/*/apps/osu.png; do
			cp -v "${icon}" "osu-$(echo "${icon}" | sed 's/^.*\/\([0-9]\{2,4\}x[0-9]\{2,4\}\)\/.*$/\1/g')"
		done
	popd
}

src_install() {
	# Install game files
	insinto "/usr/lib/${_PN}"
	doins -r usr/bin/*
	fperms +x "/usr/lib/${_PN}/osu!"

	# Install wrapper script
	newbin "${FILESDIR}/${_PN}.bash" "${_PN}"

	# Install desktop file
	domenu "${FILESDIR}/${_PN}.desktop"

	# Install mime file
	insinto /usr/share/mime/application
	doins "${FILESDIR}/${_PN}.xml"

	# Install icons
	pushd icons
		for icon in *; do
			type="${icon%-*}"
			size="${icon##*-}"

			case "${type}" in
			"osu")
				newicon --context "apps" --size "${size}" "${icon}" "${_PN}.png"
				;;
			"beatmap")
				newicon --context "mimetypes" --size "${size}" "${icon}" "${_PN}-beatmap.png"
				;;
			esac
		done
	popd

	# Install license
	insinto "/usr/share/licenses/${_PN}"
	newins "${DISTDIR}/osu-resources-${_RV}-LICENCE.md" osu-resources.md
}
