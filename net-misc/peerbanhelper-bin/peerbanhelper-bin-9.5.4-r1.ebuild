# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Automatically block unwanted, leeches and abnormal BT peers with rules"
HOMEPAGE="https://github.com/PBH-BTN/PeerBanHelper"
SRC_URI="https://github.com/PBH-BTN/PeerBanHelper/releases/download/v${PV}/peerbanhelper_${PV}_all.deb"

S="${WORKDIR}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"

DEPEND="acct-group/peerbanhelper"
RDEPEND="
	${DEPEND}
	acct-user/peerbanhelper
	>=virtual/jre-25
"

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${D}" || die
	unpacker "${DISTDIR}/peerbanhelper_${PV}_all.deb"

	eapply "${FILESDIR}/peerbanhelper-9.5.4-systemd_service.patch"
	insinto /etc/default
	newins "${FILESDIR}/peerbanhelper.default" peerbanhelper

	# remove uneeded file
	rm -r usr/share || die
}

pkg_preinst() {
	fowners root:peerbanhelper /etc/peerbanhelper
	fowners root:peerbanhelper /etc/peerbanhelper/{config,profile}.yml
	fperms g+w /etc/peerbanhelper
	fperms g+w /etc/peerbanhelper/{config,profile}.yml
}
