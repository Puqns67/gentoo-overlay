# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info go-module systemd

DESCRIPTION="A lightweight and high-performance transparent proxy solution based on eBPF"
HOMEPAGE="https://github.com/daeuniverse/dae"
SRC_URI="https://github.com/daeuniverse/dae/releases/download/v${PV//_/}/dae-full-src.zip -> ${P}.zip"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosite"
BDEPEND="sys-devel/clang"

S="${WORKDIR}"

pkg_pretend() {
	if kernel_is lt 5 8 0; then
		ewarn "Your kernel version is lower than 5.8.0, some features will not work correctly."
		ewarn "Please read this article for more information:"
		ewarn "https://github.com/daeuniverse/dae/blob/main/docs/en/README.md#kernel-version"
	fi

	CONFIG_CHECK="~BPF ~BPF_EVENTS ~BPF_JIT ~BPF_STREAM_PARSER ~BPF_SYSCALL
		~CGROUPS ~DEBUG_INFO ~DEBUG_INFO_BTF ~KPROBES ~KPROBE_EVENTS
		~NET_CLS_ACT ~NET_CLS_BPF ~NET_EGRESS ~NET_INGRESS ~NET_SCH_INGRESS"
	check_extra_config
}

src_compile() {
	CFLAGS="-fno-stack-protector" GOFLAGS="-trimpath" VERSION="${PV}" emake
}

src_install() {
	dobin dae
	systemd_dounit install/dae.service
	insinto /etc/dae
	newins example.dae config.dae.example
	newins install/empty.dae config.dae
	dosym -r "/usr/share/v2ray/geosite.dat" /usr/share/dae/geosite.dat
	dosym -r "/usr/share/v2ray/geoip.dat" /usr/share/dae/geoip.dat
}
