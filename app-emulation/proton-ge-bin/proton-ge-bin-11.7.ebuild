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
SLOT="$(ver_cut 1)"
KEYWORDS="-* ~amd64"

IUSE="+multilib"

QA_PREBUILT="*"

src_unpack() {
	:
}

src_install() {
	dodir /usr/share/steam/compatibilitytools.d
	cd "${D}/usr/share/steam/compatibilitytools.d" || die
	unpacker "${DISTDIR}/${P}.tar.gz"
	mv "${MY_P}-x86_64" "proton-ge-${SLOT}" || die
	cd "${D}/usr/share/steam/compatibilitytools.d/proton-ge-${SLOT}" || die

	if ! use multilib; then
		rm -rv files/lib/i386-linux-gnu
	fi

	# strip the write bits to pass the world-writable QA check.
	find . -type f -perm -002 -exec chmod g-w,o-w {} + || die

	# update internal name and display name.
	sed -i \
		-e "/Internal name/s/\"${MY_P}-x86_64\"/\"proton-ge-${SLOT}\"/" \
		-e "/display_name/s/\"${MY_P}-x86_64\"/\"GE-Proton ${PV} (${BRANDING_OS_NAME})\"/" \
		compatibilitytool.vdf || die

	# update version name
	sed -i "/CURRENT_PREFIX_VERSION/s/${MY_P}/${PV}-1/" proton || die
	sed -i "s/${MY_P}/proton-ge-${PV/./-}/" version || die

	dosym -r "/usr/share/steam/compatibilitytools.d/proton-ge-${SLOT}" "/opt/proton-ge/${SLOT}"
}
