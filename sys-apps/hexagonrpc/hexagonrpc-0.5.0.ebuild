# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson udev

DESCRIPTION="FastRPC ioctl wrapper library and reverse tunnel for Qualcomm Hexagon DSPs"
HOMEPAGE="https://github.com/linux-msm/hexagonrpc"
SRC_URI="https://github.com/linux-msm/hexagonrpc/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="debug"

RDEPEND="
	acct-group/fastrpc
	acct-user/fastrpc
"

PATCHES=( "${FILESDIR}/${PN}-0.5.0-systemd-unit-dir.patch" )

src_configure() {
	# tools/sscregistrygen is only built, never installed, and only when
	# json-c happens to be present, so it needs no dependency here.
	local emesonargs=(
		$(meson_use debug hexagonrpcd_verbose)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	udev_dorules "${FILESDIR}"/60-hexagonrpc.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
