# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="hatchling"
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi optfeature

DESCRIPTION="No description at now."
HOMEPAGE="
	https://github.com/Puqns67/ncmlyrics
	https://pypi.org/project/ncmlyrics/
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

RDEPEND="
	dev-python/httpx[${PYTHON_USEDEP}]
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
