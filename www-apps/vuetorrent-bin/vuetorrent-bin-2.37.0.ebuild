# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="17a04b12c0f1d681faceea78259f219a368845db"

DESCRIPTION="The sleekest looking WEBUI for qBittorrent made with Vuejs!"
HOMEPAGE="https://github.com/VueTorrent/VueTorrent"
SRC_URI="https://github.com/VueTorrent/VueTorrent/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/VueTorrent-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"

RESTRICT="mirror"

src_install() {
	insinto "/usr/share/${PN%-bin}"
	doins -r *
}
