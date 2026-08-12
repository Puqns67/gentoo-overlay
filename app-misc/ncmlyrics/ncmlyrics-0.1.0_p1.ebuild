# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="hatchling"
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi optfeature

DESCRIPTION="一个用于快速从网易云音乐拉取歌词的命令行工具"
HOMEPAGE="https://github.com/Puqns67/ncmlyrics https://pypi.org/project/ncmlyrics/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

RDEPEND="
	dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/httpx2[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest

pkg_postinst() {
	optfeature "HTTP/2 support" dev-python/h2
	optfeature "Decoding Brotli compressed responses support" dev-python/brotlicffi
	optfeature "Decoding Zstandard compressed responses support" dev-python/zstandard
}
