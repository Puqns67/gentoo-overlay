# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The sleekest looking WEBUI for qBittorrent made with Vuejs!"
HOMEPAGE="https://github.com/VueTorrent/VueTorrent"
SRC_URI="https://github.com/VueTorrent/VueTorrent/releases/download/v${PV}/vuetorrent.zip -> ${P}.zip"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~riscv"

RESTRICT="mirror"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	dodir /usr/share
	cp -rv "${S}/${PN%-bin}" "${D}/usr/share" || die
}
