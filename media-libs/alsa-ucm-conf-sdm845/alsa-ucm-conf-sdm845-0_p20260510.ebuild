# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Snapshot of the sdm845-mainline fork of alsa-ucm-conf (postmarketOS
# alsa-ucm-conf-sdm845).  Ships only the SDM845 device additions that are
# not present in media-libs/alsa-ucm-conf, so it can be installed alongside it.
COMMIT="1b8d290e5aa2ca16b7f2fa8d74910ad19ef88b3a"

DESCRIPTION="ALSA UCM configuration for Qualcomm SDM845 devices"
HOMEPAGE="https://gitlab.com/sdm845-mainline/alsa-ucm-conf"
SRC_URI="https://gitlab.com/sdm845-mainline/alsa-ucm-conf/-/archive/${COMMIT}/alsa-ucm-conf-${COMMIT}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/alsa-ucm-conf-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="media-libs/alsa-ucm-conf"

src_install() {
	insinto /usr/share/alsa/ucm2
	doins -r \
		"${S}"/ucm2/OnePlus \
		"${S}"/ucm2/Xiaomi \
		"${S}"/ucm2/SHIFT \
		"${S}"/ucm2/Google

	insinto /usr/share/alsa/ucm2/Samsung
	doins -r "${S}"/ucm2/Samsung/starqltechn

	# UCM profile symlinks for SDM845 devices.  DB845c.conf and the Lenovo
	# Yoga C630 symlink are already shipped by media-libs/alsa-ucm-conf.
	dodir /usr/share/alsa/ucm2/conf.d/sdm845
	dosym ../../Qualcomm/sdm845/Lenovo-YOGA-C630-13Q50.conf /usr/share/alsa/ucm2/conf.d/sdm845/ayn-AYNOdinM2-Unknown.conf
	dosym ../../Xiaomi/beryllium/beryllium.conf "/usr/share/alsa/ucm2/conf.d/sdm845/Xiaomi Poco F1.conf"
	dosym ../../Samsung/starqltechn/starqltechn.conf "/usr/share/alsa/ucm2/conf.d/sdm845/Samsung Galaxy S9.conf"
	dosym ../../SHIFT/axolotl/axolotl.conf /usr/share/alsa/ucm2/conf.d/sdm845/SHIFT6mq.conf
	dosym ../../OnePlus/fajita/fajita.conf "/usr/share/alsa/ucm2/conf.d/sdm845/OnePlus 6T.conf"
	dosym ../../OnePlus/enchilada/enchilada.conf "/usr/share/alsa/ucm2/conf.d/sdm845/OnePlus 6.conf"
	dosym ../../Google/blueline/blueline.conf "/usr/share/alsa/ucm2/conf.d/sdm845/Google Pixel 3.conf"
	dosym "Xiaomi Poco F1.conf" /usr/share/alsa/ucm2/conf.d/sdm845/xiaomi-XiaomiPocophoneF1Tianma.conf
	dosym SHIFT6mq.conf /usr/share/alsa/ucm2/conf.d/sdm845/shift-SHIFTSHIFT6mq.conf
	dosym SHIFT6mq.conf /usr/share/alsa/ucm2/conf.d/sdm845/shift-SHIFTSHIFT6mq-.conf
	dosym "OnePlus 6T.conf" /usr/share/alsa/ucm2/conf.d/sdm845/oneplus-OnePlus6T.conf
	dosym "OnePlus 6T.conf" /usr/share/alsa/ucm2/conf.d/sdm845/oneplus-OnePlus6T-.conf
	dosym "OnePlus 6.conf" /usr/share/alsa/ucm2/conf.d/sdm845/oneplus-OnePlus6.conf
	dosym "OnePlus 6.conf" /usr/share/alsa/ucm2/conf.d/sdm845/oneplus-OnePlus6-.conf
}
