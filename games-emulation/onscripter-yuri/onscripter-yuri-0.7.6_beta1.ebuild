# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{3..4} luajit )

inherit cmake lua-single

_PN="OnscripterYuri"
_PV="${PV/_beta/beta}"

DESCRIPTION="An enhancement ONScripter project porting to many platforms, especially web."
HOMEPAGE="https://github.com/YuriSizuku/OnscripterYuri"
SRC_URI="https://github.com/YuriSizuku/OnscripterYuri/archive/refs/tags/v${_PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${_PN}-${_PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	media-libs/mesa
	app-arch/bzip2
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/libsdl2
	media-libs/sdl2-image
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=("${FILESDIR}/${PN}-0.7.6_beta1-fix-lua-link-error.patch")

pkg_setup() {
	lua-single_pkg_setup
}
