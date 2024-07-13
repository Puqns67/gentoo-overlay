# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_12 )

inherit distutils-r1 pypi

DESCRIPTION="A rewritten version of MCDaemon, a python tool to control your Minecraft server"
HOMEPAGE="
	https://mcdreforged.com/
	https://github.com/MCDReforged/MCDReforged
	https://pypi.org/project/mcdreforged
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/colorlog-6.4[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.4.4[${PYTHON_USEDEP}]
	>=dev-python/packaging-23[${PYTHON_USEDEP}]
	>=dev-python/parse-1.18[${PYTHON_USEDEP}]
	=dev-python/prompt-toolkit-3*[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.8[${PYTHON_USEDEP}]
	>=dev-python/requests-2.26[${PYTHON_USEDEP}]
	dev-python/resolvelib[${PYTHON_USEDEP}]
	=dev-python/ruamel-yaml-0*[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.6[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${PN}-2.13.0-skip-environment-check.patch"
	"${FILESDIR}/${PN}-2.13.0-fix-qa.patch"
)

distutils_enable_tests unittest
