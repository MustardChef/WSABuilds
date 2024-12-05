#!/bin/bash
#
# This file is part of MagiskOnWSALocal.
#
# MagiskOnWSALocal is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# MagiskOnWSALocal is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with MagiskOnWSALocal.  If not, see <https://www.gnu.org/licenses/>.
#
# Copyright (C) 2024 LSPosed Contributors
#

if [ ! "$BASH_VERSION" ]; then
    echo "Please do not use sh to run this script, just execute it directly" 1>&2
    exit 1
fi
HOST_ARCH=$(uname -m)
if [ "$HOST_ARCH" != "x86_64" ] && [ "$HOST_ARCH" != "aarch64" ]; then
    echo "Unsupported architectures: $HOST_ARCH"
    exit 1
fi
cd "$(dirname "$0")" || exit 1
# export TMPDIR=$HOME/.cache/wsa
if [ "$TMPDIR" ] && [ ! -d "$TMPDIR" ]; then
    mkdir -p "$TMPDIR"
fi
WORK_DIR=$(mktemp -d -t wsa-build-XXXXXXXXXX_) || exit 1

DOWNLOAD_DIR=../download
PYTHON_VENV_DIR="$(dirname "$PWD")/python3-env"
dir_clean() {
    rm -rf "${WORK_DIR:?}"
    if [ "$TMPDIR" ] && [ -d "$TMPDIR" ]; then
        echo "Cleanup Temp Directory"
        rm -rf "${TMPDIR:?}"
        unset TMPDIR
    fi
    if [ "$(python3 -c 'import sys ; print( 1 if sys.prefix != sys.base_prefix else 0 )')" = "1" ]; then
        echo "deactivate python3 venv"
        deactivate
    fi
}
trap dir_clean EXIT
abort() {
    [ "$1" ] && echo -e "ERROR: $1"
    echo "Build: an error has occurred, exit"
    if [ -d "$WORK_DIR" ]; then
        echo -e "\nCleanup Work Directory"
        dir_clean
    fi
    exit 1
}
trap abort INT TERM
# shellcheck disable=SC1091
[ -f "$PYTHON_VENV_DIR/bin/activate" ] && {
    source "$PYTHON_VENV_DIR/bin/activate" || abort "Failed to activate virtual environment, please re-run install_deps.sh"
}
MAGISK_VER=$1
ARCH=$2
TARGET=$3
if [ -z "$MAGISK_VER" ] || [ -z "$ARCH" ] || [ -z "$TARGET" ]; then
    echo "Usage: $0 <release|debug> <x64|arm64> <initrd>"
    exit 1
fi
MAGISK_ZIP=magisk-$MAGISK_VER.zip
MAGISK_PATH=$DOWNLOAD_DIR/$MAGISK_ZIP
if [ ! -f "$MAGISK_PATH" ]; then
    echo "Custom Magisk $MAGISK_ZIP not found"
    MAGISK_ZIP=app-$MAGISK_VER.apk
    echo -e "Fallback to $MAGISK_ZIP\n"
    MAGISK_PATH=$DOWNLOAD_DIR/$MAGISK_ZIP
    if [ ! -f "$MAGISK_PATH" ]; then
        abort "Custom Magisk $MAGISK_ZIP not found\nPlease put custom Magisk in $DOWNLOAD_DIR"
    fi
fi
echo "Extracting Magisk"
if [ -f "$MAGISK_PATH" ]; then
    if ! python3 extractMagisk.py "$ARCH" "$MAGISK_PATH" "$WORK_DIR"; then
        abort "Unzip Magisk failed, is the download incomplete?"
    fi
    chmod +x "$WORK_DIR/magisk/magiskboot" || abort
elif [ -z "${CUSTOM_MAGISK+x}" ]; then
    abort "The Magisk zip package does not exist, is the download incomplete?"
else
    abort "The Magisk zip package does not exist, rename it to magisk-debug.zip and put it in the download folder."
fi
echo -e "done\n"
echo "Integrating Magisk"
SKIP="#"
SINGLEABI="#"
SKIPINITLD="#"
if [ -f "$WORK_DIR/magisk/magisk64" ]; then
    "$WORK_DIR/magisk/magiskboot" compress=xz "$WORK_DIR/magisk/magisk64" "$WORK_DIR/magisk/magisk64.xz"
    "$WORK_DIR/magisk/magiskboot" compress=xz "$WORK_DIR/magisk/magisk32" "$WORK_DIR/magisk/magisk32.xz"
    unset SINGLEABI
else
    "$WORK_DIR/magisk/magiskboot" compress=xz "$WORK_DIR/magisk/magisk" "$WORK_DIR/magisk/magisk.xz"
    unset SKIP
fi
if [ -f "$WORK_DIR/magisk/init-ld" ]; then
    "$WORK_DIR/magisk/magiskboot" compress=xz "$WORK_DIR/magisk/init-ld" "$WORK_DIR/magisk/init-ld.xz"
    unset SKIPINITLD
fi
"$WORK_DIR/magisk/magiskboot" compress=xz "$MAGISK_PATH" "$WORK_DIR/magisk/stub.xz"
"$WORK_DIR/magisk/magiskboot" cpio "$TARGET" \
    "add 0750 /lspinit ../bin/$ARCH/lspinit" \
    "add 0750 /magiskinit $WORK_DIR/magisk/magiskinit" \
    "$SINGLEABI add 0644 overlay.d/sbin/magisk64.xz $WORK_DIR/magisk/magisk64.xz" \
    "$SINGLEABI add 0644 overlay.d/sbin/magisk32.xz $WORK_DIR/magisk/magisk32.xz" \
    "$SKIP add 0644 overlay.d/sbin/magisk.xz $WORK_DIR/magisk/magisk.xz" \
    "$SKIPINITLD add 0644 overlay.d/sbin/init-ld.xz $WORK_DIR/magisk/init-ld.xz" \
    "add 0644 overlay.d/sbin/stub.xz $WORK_DIR/magisk/stub.xz" \
    || abort "Unable to patch initrd"
