# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit branding unpacker

MY_P="GE-Proton${PV/./-}"

DESCRIPTION="A fancy custom distribution of Valves Proton with various patches"
HOMEPAGE="https://github.com/GloriousEggroll/proton-ge-custom"
SRC_URI="
	https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${MY_P}/${MY_P}-x86_64.tar.gz -> ${P}.tar.gz
"

S="${WORKDIR}"

LICENSE="BSD LGPL-2.1+ LGPL-2 ZLIB OFL-1.1 MIT GPL-2"
SLOT="${PV%%.*}"
KEYWORDS="-* ~amd64"

RESTRICT="mirror strip"

RDEPEND="
	app-arch/brotli
	app-arch/zstd
	app-crypt/mit-krb5
	dev-db/sqlite
	dev-libs/glib:2
	dev-libs/libusb
	dev-libs/wayland
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/libpulse
	media-libs/libva
	media-video/pipewire
	net-libs/gnutls
	net-libs/libpsl
	net-libs/nghttp2
	sci-libs/blas-lapack-aux-wrapper
	sys-apps/pcsc-lite
	sys-devel/gcc
	sys-libs/glibc
	virtual/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
"

QA_PREBUILT="*"

src_unpack() {
	:
}

src_install() {
	dodir /usr/share/steam/compatibilitytools.d
	cd "${D}/usr/share/steam/compatibilitytools.d" || die
	unpacker "${DISTDIR}/${P}.tar.gz"
	mv "${MY_P}-x86_64" "proton-ge-${SLOT}" || die

	# strip the write bits to pass the world-writable QA check.
	find "proton-ge-${SLOT}" -type f -perm -002 -exec chmod g-w,o-w {} + || die

	# update internal name and display name.
	sed -i \
		-e "/Internal name/s/\"${MY_P}-x86_64\"/\"proton-ge-${SLOT}\"/" \
		-e "/display_name/s/\"${MY_P}-x86_64\"/\"GE-Proton ${PV} (${BRANDING_OS_NAME})\"/" \
		"proton-ge-${SLOT}/compatibilitytool.vdf" || die

	# update version name
	sed -i "/CURRENT_PREFIX_VERSION/s/${MY_P}/${PV}-1/" "proton-ge-${SLOT}/proton" || die
	sed -i "s/${MY_P}/proton-ge-${PV/./-}/" "proton-ge-${SLOT}/version" || die

	dosym -r "/usr/share/steam/compatibilitytools.d/proton-ge-${SLOT}" "/opt/proton-ge/${SLOT}"
}
