# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {19..21} )
EGIT_LFS="yes"

inherit git-r3 llvm-r2 cmake

DESCRIPTION="Material You cloud music player written in C++"
HOMEPAGE="https://github.com/hypengw/Qcm"

LICENSE="GPL-2+ MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="lto test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/qmlmaterial:=
	media-libs/qcm-backend:=
	dev-qt/qtbase:6[gui]
	dev-qt/qtgrpc:6
	dev-libs/kdsingleapplication
	dev-libs/openssl
	dev-libs/qr-code-generator
	media-libs/cubeb
	media-video/ffmpeg
	net-misc/curl
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=
		llvm-core/llvm:${LLVM_SLOT}=
	')
	dev-cpp/asio
	dev-libs/pegtl
	dev-util/vulkan-headers
	virtual/pkgconfig
	test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/${PN}-9999-remove_default_clang++_and_optional_lto.patch"
	"${FILESDIR}/${PN}-9999-use_system_KDSingleApplication_and_qr_code_generator.patch"
)

src_unpack() {
	local EGIT_REPO_URI="https://github.com/hypengw/Qcm.git"
	git-r3_src_unpack

	local EGIT_REPO_URI="https://github.com/hypengw/rstd.git"
	local EGIT_CHECKOUT_DIR="${WORKDIR}/rstd"
	git-r3_src_unpack

	local EGIT_REPO_URI="https://github.com/hypengw/ncrequest.git"
	local EGIT_CHECKOUT_DIR="${WORKDIR}/ncrequest"
	git-r3_src_unpack

	local EGIT_REPO_URI="https://github.com/hypengw/kstore.git"
	local EGIT_CHECKOUT_DIR="${WORKDIR}/kstore"
	git-r3_src_unpack

	local EGIT_REPO_URI="https://github.com/ilqvya/random.git"
	local EGIT_CHECKOUT_DIR="${WORKDIR}/random"
	git-r3_src_unpack
}

src_configure() {
	AR="llvm-ar"
	CC="clang-${LLVM_SLOT}"
	CXX="clang++-${LLVM_SLOT}"
	NM="llvm-nm"
	RANLIB="llvm-ranlib"

	local mycmakeargs=(
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_SOURCE_DIR_RSTD="${WORKDIR}/rstd"
		-DFETCHCONTENT_SOURCE_DIR_NCREQUEST="${WORKDIR}/ncrequest"
		-DFETCHCONTENT_SOURCE_DIR_KSTORE="${WORKDIR}/kstore"
		-DFETCHCONTENT_SOURCE_DIR_RANDOM="${WORKDIR}/random"
		-DQCM_USE_LTO="$(usex lto)"
		-DQCM_BUILD_TESTS="$(usex test)"
	)
	cmake_src_configure
}
