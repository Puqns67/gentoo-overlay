# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517="maturin"
PYTHON_COMPAT=( python3_{12..15} )
RUST_MIN_VER="1.85.0"

CRATES="
	aho-corasick@1.1.3
	anyhow@1.0.89
	beef@0.5.2
	bitflags@2.6.0
	bytes@1.10.1
	cfg-if@1.0.0
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	either@1.13.0
	equivalent@1.0.1
	errno@0.3.9
	fastrand@2.1.1
	fixedbitset@0.5.7
	fnv@1.0.7
	foldhash@0.1.5
	hashbrown@0.14.5
	hashbrown@0.15.5
	heck@0.5.0
	indexmap@2.5.0
	itertools@0.13.0
	itoa@1.0.11
	lazy_static@1.5.0
	libc@0.2.158
	linux-raw-sys@0.4.14
	log@0.4.22
	logos-codegen@0.15.0
	logos-derive@0.15.0
	logos@0.15.0
	memchr@2.7.4
	miette-derive@7.2.0
	miette@7.2.0
	multimap@0.10.0
	nu-ansi-term@0.50.1
	once_cell@1.21.3
	petgraph@0.8.3
	pin-project-lite@0.2.14
	portable-atomic@1.8.0
	prettyplease@0.2.22
	proc-macro2@1.0.107
	prost-build@0.14.4
	prost-derive@0.14.4
	prost-reflect@0.16.0
	prost-types@0.14.4
	prost@0.14.4
	protox-parse@0.9.0
	protox@0.9.1
	pyo3-build-config@0.29.0
	pyo3-ffi@0.29.0
	pyo3-macros-backend@0.29.0
	pyo3-macros@0.29.0
	pyo3@0.29.0
	quick-xml@0.41.0
	quote@1.0.37
	rayon-core@1.13.0
	rayon@1.12.0
	regex-automata@0.4.16
	regex-syntax@0.8.11
	regex@1.13.1
	rustc-hash@2.1.3
	rustc_version@0.4.1
	rustix@0.38.37
	semver@1.0.26
	serde@1.0.229
	serde_core@1.0.229
	serde_derive@1.0.229
	serde_json@1.0.151
	sharded-slab@0.1.7
	smallvec@1.13.2
	syn@2.0.87
	syn@3.0.3
	target-lexicon@0.13.4
	tempfile@3.12.0
	thiserror-impl@1.0.68
	thiserror-impl@2.0.19
	thiserror@1.0.68
	thiserror@2.0.19
	thread_local@1.1.8
	tracing-attributes@0.1.31
	tracing-core@0.1.36
	tracing-log@0.2.0
	tracing-subscriber@0.3.23
	tracing@0.1.44
	unicode-ident@1.0.13
	unicode-width@0.1.14
	valuable@0.1.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	zmij@1.0.2
"

inherit cargo distutils-r1 pypi

DESCRIPTION="高性能的 B 站 XML/protobuf 弹幕转 ASS 工具"
HOMEPAGE="https://pypi.org/project/biliass/"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT Unicode-DFS-2016 ZLIB
"

SLOT="0"
KEYWORDS="~amd64 ~riscv"

src_unpack() {
	cargo_src_unpack
}
