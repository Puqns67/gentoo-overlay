# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd

DESCRIPTION="Trivial File Transfer Protocol server over QRTR"
HOMEPAGE="https://github.com/linux-msm/tqftpserv"
SRC_URI="
	https://github.com/linux-msm/tqftpserv/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	app-arch/zstd:=
	net-libs/qrtr:=
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		# The unit directory is passed explicitly because upstream only
		# installs the unit when systemd.pc is found at build time, which
		# would make the installed files depend on the build host.
		-Dsystemd-unit-prefix="$(systemd_get_systemunitdir)"
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	# Requests below /readwrite/ are served from this directory.
	keepdir /var/lib/tqftpserv
}
