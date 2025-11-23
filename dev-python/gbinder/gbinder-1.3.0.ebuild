# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"
DISTUTILS_EXT=1

inherit distutils-r1

DESCRIPTION="Python bindings for dev-libs/gbinder"
HOMEPAGE="https://github.com/waydroid/gbinder-python"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/waydroid/gbinder-python/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-python-${PV}"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/waydroid/gbinder-python.git"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/gbinder
	dev-libs/libglibutil
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-python/cython[${PYTHON_USEDEP}]
"
