# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Desktop integration for the waywallen wallpaper daemon"
HOMEPAGE="https://github.com/waywallen/waywallen-display"

SRC_URI="https://github.com/waywallen/waywallen-display/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+egl vulkan gnome plasma"

RDEPEND="
	dev-libs/icu
	virtual/zlib
	media-libs/mesa
	media-libs/vulkan-loader
	media-video/ffmpeg
	dev-libs/glib
	gnome? ( gui-libs/gtk )
	plasma? (
		dev-qt/qtbase:6[dbus,gui]
		dev-qt/qtdeclarative:6
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	media-libs/libglvnd
	dev-util/vulkan-headers
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DWAYWALLEN_DISPLAY_WITH_EGL="$(usex egl)"
		-DWAYWALLEN_DISPLAY_WITH_VULKAN="$(usex vulkan)"
		-DWAYWALLEN_DISPLAY_PLUGIN_QML="$(usex plasma)"
		-DWAYWALLEN_DISPLAY_PLUGIN_GOBJECT="$(usex gnome)"
		-DWAYWALLEN_DISPLAY_PLUGIN_GNOME="$(usex gnome)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	if use plasma; then
		insinto /usr/share/plasma/wallpapers/org.waywallen.kde
		doins -r extensions/kde/package/*
	fi
}
