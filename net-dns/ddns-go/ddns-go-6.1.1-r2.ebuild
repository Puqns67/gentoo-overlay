# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="简单好用的 DDNS。自动获得你的公网 IPv4 或 IPv6 地址，并解析到对应的域名服务。"
HOMEPAGE="https://github.com/jeessy2/ddns-go"
SRC_URI="https://github.com/jeessy2/ddns-go/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Puqns67/gentoo-deps/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

RESTRICT="mirror"

PATCHES=(
	"${FILESDIR}/${P}-remove-update-support.patch"
	"${FILESDIR}/${P}-remove-service-management-support.patch"
)

src_compile() {
	ego build \
		-trimpath \
		-ldflags="-s -w -linkmode external \
			-X 'main.version=${PV}' \
			-X 'main.buildTime=$(date -u +"%Y-%m-%dT%H:%M:%SZ")'" \
		-o "${PN}" \
		.
}

src_install() {
	dobin "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"
	systemd_newunit "${FILESDIR}/${PN}_at.service" "${PN}@.service"
	systemd_dounit "${FILESDIR}/${PN}-web.service"
	keepdir "/etc/${PN}"
}
