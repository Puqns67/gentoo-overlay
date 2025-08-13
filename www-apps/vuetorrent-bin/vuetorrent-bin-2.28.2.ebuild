# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

_COMMIT="02fd7f0f1c58b0285f061edad9def72cdc4a4cc7"

DESCRIPTION="The sleekest looking WEBUI for qBittorrent made with Vuejs!"
HOMEPAGE="https://github.com/VueTorrent/VueTorrent"
SRC_URI="https://github.com/VueTorrent/VueTorrent/archive/${_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/VueTorrent-${_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"

RESTRICT="mirror"

src_install() {
	insinto "/usr/share/${PN%-bin}"
	doins -r *
}
