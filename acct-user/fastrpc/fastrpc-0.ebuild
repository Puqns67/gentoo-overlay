# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for the Qualcomm FastRPC user space daemons"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( "fastrpc" )

acct-user_add_deps
