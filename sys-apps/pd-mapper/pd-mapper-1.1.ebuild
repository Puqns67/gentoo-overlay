# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd toolchain-funcs

DESCRIPTION="Qualcomm Protection Domain mapper"
HOMEPAGE="https://github.com/andersson/pd-mapper"
SRC_URI="
	https://github.com/andersson/pd-mapper/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

# lzma_decomp.c is derived from a public domain LZMA example.
LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	app-arch/xz-utils:=
	net-libs/qrtr:=
"
DEPEND="${RDEPEND}"

src_compile() {
	# Upstream passes the libraries through LDFLAGS, and a command line
	# assignment overrides that, so they are repeated here.
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS} -lqrtr -llzma" \
		prefix="/usr" \
		pd-mapper pd-mapper.service
}

src_install() {
	dobin pd-mapper

	systemd_dounit pd-mapper.service
}
