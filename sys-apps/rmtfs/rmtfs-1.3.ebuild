# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd toolchain-funcs udev

DESCRIPTION="Qualcomm Remote Filesystem Service implementation"
HOMEPAGE="https://github.com/linux-msm/rmtfs"
SRC_URI="
	https://github.com/linux-msm/rmtfs/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	net-libs/qrtr:=
	virtual/libudev:=
"
DEPEND="${RDEPEND}"

src_compile() {
	# Upstream passes the libraries through LDFLAGS, and a command line
	# assignment overrides that, so they are repeated here.
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS} -lqrtr -ludev -lpthread" \
		prefix="/usr" \
		rmtfs rmtfs.service rmtfs-dir.service
}

src_install() {
	dobin rmtfs

	systemd_dounit rmtfs.service rmtfs-dir.service

	udev_dorules rmtfs.rules

	# Used by rmtfs-dir.service; the daemon does not create it itself.
	keepdir /var/lib/rmtfs
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
