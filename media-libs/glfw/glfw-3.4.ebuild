# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Portable OpenGL FrameWork"
HOMEPAGE="https://www.glfw.org/"
SRC_URI="https://github.com/glfw/glfw/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~riscv ~x86"
IUSE="+wayland"

RDEPEND="
	media-libs/libglvnd
	wayland? ( dev-libs/wayland )
"
DEPEND="
	${RDEPEND}
	wayland? (
		dev-libs/wayland-protocols
		x11-libs/libxkbcommon
	)
"
BDEPEND="
	wayland? (
		dev-util/wayland-scanner
		kde-frameworks/extra-cmake-modules
	)
"

src_configure() {
	local mycmakeargs=(
		-D GLFW_BUILD_X11=no
		-D GLFW_BUILD_WAYLAND=$(usex wayland)
	)
	cmake_src_configure
}
