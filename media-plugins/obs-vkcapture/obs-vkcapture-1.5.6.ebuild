# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="OBS Linux Vulkan/OpenGL game capture"
HOMEPAGE="https://github.com/nowrep/obs-vkcapture"
SRC_URI="https://github.com/nowrep/obs-vkcapture/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="+X wayland"
REQUIRED_USE="|| ( X wayland )"

RDEPEND="
	>=media-video/obs-studio-30.2.0
	>=media-libs/libglvnd-1.7.0[X?]
	X? ( x11-libs/libxcb:= )
	wayland? ( >=dev-libs/wayland-1.22.0 )
"
DEPEND="${RDEPEND}
	media-libs/vulkan-loader[X?,wayland?]
	dev-util/vulkan-headers
	X? ( x11-libs/libX11 )
	wayland? ( >=dev-util/wayland-scanner-1.22.0 )
"

QA_SONAME="/usr/lib64/libVkLayer_obs_vkcapture.so"

pkg_postinst() {
	if [[ $(</sys/module/nvidia_drm/parameters/modeset) != Y ]] 2>/dev/null; then
		elog "This plugin needs nvidia-drm with modeset configured properly"
		elog "to capture windows. To enable, edit /etc/modprobe.d/nvidia.conf"
		elog "and uncomment the nvidia-drm options to enable modeset."
		elog
	fi

	elog "This plugin can only capture the game window if you add one of the"
	elog "following launcher options to the game (Steam as an example):"
	elog "  - OBS_VKCAPTURE=1 %command% (recommended, Vulkan)"
	elog "  - obs-gamecapture %command% (generic, OpenGL and Vulkan)"
	elog
	elog "HINT: This may currently not work on wayland with"
	elog "x11-drivers/nvidia-drivers[kernel-open]"
}
