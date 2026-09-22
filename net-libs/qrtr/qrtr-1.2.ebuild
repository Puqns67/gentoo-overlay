# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Userspace reference for the QRTR (QIPCRTR) socket family"
HOMEPAGE="https://github.com/linux-msm/qrtr"
SRC_URI="
	https://github.com/linux-msm/qrtr/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="~amd64 ~arm64"

src_configure() {
	local emesonargs=(
		# The name service was moved into the kernel in Linux 5.7
		# (net/qrtr/ns.c, compiled with CONFIG_QRTR), so the userspace
		# implementation is only needed on older kernels. The unit file is
		# disabled as well, as upstream would only install it depending on
		# whether systemd.pc is found at build time.
		-Dqrtr-ns=disabled
		-Dsystemd-service=disabled
	)

	meson_src_configure
}
