# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake-multilib

DESCRIPTION="Portable OpenGL FrameWork (With wayland patchs for Minecraft)"
HOMEPAGE="https://github.com/bczhc/glfw"

LICENSE="ZLIB"
SLOT="0"

IUSE="wayland X"

# Most are dlopen'd so use strings or check the source:
# grep -Eiro '[a-z0-9-]+\.so\.[0-9]+'
DEPEND="
	wayland? (
		dev-libs/wayland[${MULTILIB_USEDEP}]
		dev-libs/wayland-protocols
	)
	X? (
		x11-base/xorg-proto
		x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-libs/libXcursor[${MULTILIB_USEDEP}]
		x11-libs/libXi[${MULTILIB_USEDEP}]
		x11-libs/libXinerama[${MULTILIB_USEDEP}]
		x11-libs/libxkbcommon[${MULTILIB_USEDEP}]
		x11-libs/libXrandr[${MULTILIB_USEDEP}]
	)
"
RDEPEND="
	${DEPEND}
	media-libs/libglvnd[X?,${MULTILIB_USEDEP}]
	wayland? (
		gui-libs/libdecor[${MULTILIB_USEDEP}]
	)
	X? (
		x11-libs/libXrender[${MULTILIB_USEDEP}]
		x11-libs/libXxf86vm[${MULTILIB_USEDEP}]
	)
"
BDEPEND="
	wayland? (
		dev-util/wayland-scanner
		kde-frameworks/extra-cmake-modules
	)
"

EGIT_REPO_URI="https://github.com/bczhc/glfw.git"

src_configure() {
	local mycmakeargs=(
		-DGLFW_BUILD_EXAMPLES=no
		-DGLFW_BUILD_WAYLAND=$(usex wayland)
		-DGLFW_BUILD_X11=$(usex X)
	)

	cmake-multilib_src_configure
}
