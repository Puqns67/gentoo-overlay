# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="3f05cd085d5ea17573ed0b233a01304af024e25d"

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
