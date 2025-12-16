# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {19..21} )

inherit llvm-r2 cmake

DESCRIPTION="Material You cloud music player written in C++"
HOMEPAGE="https://github.com/hypengw/Qcm"

RSTD_COMMIT="7eb8b411258b4a886231b8b87f7b5a472b6712e1"
NCREQUEST_COMMIT="b919f0ad9a85dc006392ebf8802eb4c7df7584a2"
KSTORE_COMMIT="d6f32d1a04be01328e1e528c0539e37b359c87e3"
RANDOM_COMMIT="6983466aadd1173627b362ff1a297527d9842531"

SRC_URI="
	https://github.com/hypengw/Qcm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/hypengw/rstd/archive/${RSTD_COMMIT}.tar.gz -> rstd-${RSTD_COMMIT}.tar.gz
	https://github.com/hypengw/ncrequest/archive/${NCREQUEST_COMMIT}.tar.gz -> ncrequest-${NCREQUEST_COMMIT}.tar.gz
	https://github.com/hypengw/kstore/archive/${KSTORE_COMMIT}.tar.gz -> kstore-${KSTORE_COMMIT}.tar.gz
	https://github.com/ilqvya/random/archive/${RANDOM_COMMIT}.tar.gz -> random-${RANDOM_COMMIT}.tar.gz
"

S="${WORKDIR}/Qcm-${PV}"

LICENSE="GPL-2+ MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="lto test"
RESTRICT="!test? ( test )"

RDEPEND="
	media-libs/qcmbackend:=
	dev-libs/qmlmaterial:=
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

src_configure() {
	AR="llvm-ar"
	CC="clang-${LLVM_SLOT}"
	CXX="clang++-${LLVM_SLOT}"
	NM="llvm-nm"
	RANLIB="llvm-ranlib"

	local mycmakeargs=(
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_SOURCE_DIR_RSTD="${WORKDIR}/rstd-${RSTD_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_NCREQUEST="${WORKDIR}/ncrequest-${NCREQUEST_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_KSTORE="${WORKDIR}/kstore-${KSTORE_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_RANDOM="${WORKDIR}/random-${RANDOM_COMMIT}"
		-DQCM_USE_LTO="$(usex lto)"
		-DQCM_BUILD_TESTS="$(usex test)"
	)
	cmake_src_configure
}
