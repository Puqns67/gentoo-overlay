# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {19..20} )
EGIT_LFS="yes"

inherit git-r3 llvm-r2 cmake

DESCRIPTION="Material You cloud music player written in C++"
HOMEPAGE="https://github.com/hypengw/Qcm"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	media-libs/qcm-backend
	dev-qt/qtbase:6
	dev-qt/qtquick3d:6
	dev-qt/qtgrpc:6
	dev-libs/kdsingleapplication
	net-misc/curl
	dev-libs/libfmt
	media-libs/cubeb
	dev-libs/qr-code-generator
"
DEPEND="
	"${RDEPEND}"
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=
		llvm-core/llvm:${LLVM_SLOT}=
	')
"
BDEPEND="
	dev-cpp/asio
	dev-libs/pegtl
	dev-cpp/nlohmann_json
	dev-cpp/expected
	dev-util/vulkan-headers
	test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/${PN}-9999-remove_default_clang++.patch"
	"${FILESDIR}/${PN}-9999-use_system_KDSingleApplication_and_qr_code_generator.patch"
)

src_unpack() {
	local EGIT_REPO_URI="https://github.com/hypengw/Qcm.git"
	git-r3_src_unpack
	unset EGIT_LFS

	local EGIT_REPO_URI="https://github.com/hypengw/rstd.git"
	local EGIT_CHECKOUT_DIR="${S}/third_party/rstd"
	git-r3_src_unpack

	local EGIT_REPO_URI="https://github.com/hypengw/ncrequest.git"
	local EGIT_CHECKOUT_DIR="${S}/third_party/ncrequest"
	git-r3_src_unpack

	local EGIT_REPO_URI="https://github.com/hypengw/kstore.git"
	local EGIT_CHECKOUT_DIR="${S}/third_party/kstore"
	git-r3_src_unpack

	local EGIT_REPO_URI="https://github.com/hypengw/QmlMaterial.git"
	local EGIT_CHECKOUT_DIR="${S}/third_party/qml_material"
	git-r3_src_unpack

	local EGIT_REPO_URI="https://github.com/ilqvya/random.git"
	local EGIT_CHECKOUT_DIR="${S}/third_party/random"
	git-r3_src_unpack
}

src_configure() {
	local mycmakeargs=(
		-DQCM_BUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}
