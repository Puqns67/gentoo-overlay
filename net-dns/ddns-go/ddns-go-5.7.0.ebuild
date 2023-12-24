# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="简单好用的 DDNS。自动获得你的公网 IPv4 或 IPv6 地址，并解析到对应的域名服务。"
HOMEPAGE="https://github.com/jeessy2/ddns-go"
SRC_URI="https://github.com/jeessy2/ddns-go/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Puqns67/gentoo-deps/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.20"

PATCHES=(
	"${FILESDIR}/ddns-go-5.6.6-remove-update-support.patch"
	"${FILESDIR}/ddns-go-5.7.0-remove-service-management-support.patch"
)

src_compile() {
	ego build \
		-trimpath \
		-ldflags="-s -w \
			-X 'main.version=${PV}' \
			-X 'main.buildTime=$(date -u +"%Y-%m-%dT%H:%M:%SZ")'" \
		-o ddns-go \
		.
}

src_install() {
	dobin ddns-go
	systemd_dounit "${FILESDIR}/ddns-go.service"
	systemd_newunit "${FILESDIR}/ddns-go_at.service" ddns-go@.service
	systemd_dounit "${FILESDIR}/ddns-go-web.service"
	systemd_newunit "${FILESDIR}/ddns-go-web_at.service" ddns-go-web@.service
	keepdir /etc/ddns-go
}
