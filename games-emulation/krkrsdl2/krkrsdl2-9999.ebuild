# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="A port of Kirikiri Z that can be run on platforms supporting SDL2"
HOMEPAGE="https://github.com/krkrsdl2/krkrsdl2"
EGIT_REPO_URI="https://github.com/krkrsdl2/krkrsdl2.git"
EGIT_SUBMODULES=(
	"external/krkrz"
	"external/krkrz/external/jxrlib"
)

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-libs/zlib
	dev-libs/oniguruma
	media-libs/freetype
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/libogg
	media-libs/opus
	media-libs/opusfile
	media-libs/libsdl2
	media-libs/openal
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-9999-cmake.patch"
	"${FILESDIR}/${PN}-9999-fix_include_zlib.patch"
)

src_prepare() {
	cmake_src_prepare
	sed -i "s/#include <jinclude.h>//" "external/krkrz/visual/LoadJPEG.cpp"
}
