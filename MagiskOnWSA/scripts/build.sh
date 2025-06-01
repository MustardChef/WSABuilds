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

# lowerdir
ROOT_MNT_RO="$WORK_DIR/erofs"
VENDOR_MNT_RO="$ROOT_MNT_RO/vendor"
PRODUCT_MNT_RO="$ROOT_MNT_RO/product"
SYSTEM_EXT_MNT_RO="$ROOT_MNT_RO/system_ext"

# upperdir
ROOT_MNT_RW="$WORK_DIR/upper"
VENDOR_MNT_RW="$ROOT_MNT_RW/vendor"
PRODUCT_MNT_RW="$ROOT_MNT_RW/product"
SYSTEM_EXT_MNT_RW="$ROOT_MNT_RW/system_ext"
SYSTEM_MNT_RW="$ROOT_MNT_RW/system"

# merged
# shellcheck disable=SC2034
ROOT_MNT="$WORK_DIR/system_root_merged"
SYSTEM_MNT="$ROOT_MNT/system"
VENDOR_MNT="$ROOT_MNT/vendor"
PRODUCT_MNT="$ROOT_MNT/product"
SYSTEM_EXT_MNT="$ROOT_MNT/system_ext"

DOWNLOAD_DIR=../download
DOWNLOAD_CONF_NAME=download.list
PYTHON_VENV_DIR="$(dirname "$PWD")/python3-env"

dir_clean() {
    rm -rf "${WORK_DIR:?}"
    if [ "$TMPDIR" ] && [ -d "$TMPDIR" ]; then
        echo "Cleanup Temp Directory"
        rm -rf "${TMPDIR:?}"
        unset TMPDIR
    fi
    rm -f "${DOWNLOAD_DIR:?}/$DOWNLOAD_CONF_NAME"
    if [ "$(python3 -c 'import sys ; print( 1 if sys.prefix != sys.base_prefix else 0 )')" = "1" ]; then
        echo "deactivate python3 venv"
        deactivate
    fi
}
trap dir_clean EXIT
OUTPUT_DIR=../output
WSA_WORK_ENV="${WORK_DIR:?}/ENV"
if [ -f "$WSA_WORK_ENV" ]; then rm -f "${WSA_WORK_ENV:?}"; fi
touch "$WSA_WORK_ENV"
export WSA_WORK_ENV
clean_download() {
    if [ -d "$DOWNLOAD_DIR" ]; then
        echo "Cleanup Download Directory"
        if [ "$CLEAN_DOWNLOAD_WSA" ]; then
            rm -f "${WSA_ZIP_PATH:?}"
        fi
        if [ "$CLEAN_DOWNLOAD_MAGISK" ]; then
            rm -f "${MAGISK_PATH:?}"
        fi
        if [ "$CLEAN_DOWNLOAD_GAPPS" ]; then
            rm -f "${GAPPS_IMAGE_PATH:?}"
            rm -f "${GAPPS_RC_PATH:?}"
        fi
        if [ "$CLEAN_DOWNLOAD_KERNELSU" ]; then
            rm -f "${KERNELSU_PATH:?}"
            rm -f "${KERNELSU_INFO:?}"
        fi
    fi
}
abort() {
    [ "$1" ] && echo -e "ERROR: $1"
    echo "Build: an error has occurred, exit"
    if [ -d "$WORK_DIR" ]; then
        echo -e "\nCleanup Work Directory"
        dir_clean
    fi
    clean_download
    exit 1
}
trap abort INT TERM

default() {
    ARCH=x64
    RELEASE_TYPE=retail
    MAGISK_VER=stable
    ROOT_SOL=magisk
    COMPRESS_FORMAT=none
}

exit_with_message() {
    echo "ERROR: $1"
    usage
    exit 1
}

ARCH_MAP=(
    "x64"
    "arm64"
)

RELEASE_TYPE_MAP=(
    "retail"
    "RP"
    "WIS"
    "WIF"
)

MAGISK_VER_MAP=(
    "stable"
    "beta"
    "canary"
    "debug"
    "release"
)

ROOT_SOL_MAP=(
    "magisk"
    "kernelsu"
    "none"
)

COMPRESS_FORMAT_MAP=(
    "7z"
    "zip"
    "none"
)

ARR_TO_STR() {
    local arr=("$@")
    local joined
    printf -v joined "%s, " "${arr[@]}"
    echo "${joined%, }"
}

usage() {
    default
    echo -e "
Usage:
    --arch              Architecture of WSA.

                        Possible values: $(ARR_TO_STR "${ARCH_MAP[@]}")
                        Default: $ARCH

    --release-type      Release type of WSA.
                        RP means Release Preview, WIS means Insider Slow, WIF means Insider Fast.

                        Possible values: $(ARR_TO_STR "${RELEASE_TYPE_MAP[@]}")
                        Default: $RELEASE_TYPE

    --magisk-ver        Magisk version.

                        Possible values: $(ARR_TO_STR "${MAGISK_VER_MAP[@]}")
                        Default: $MAGISK_VER

    --root-sol          Root solution.
                        \"none\" means no root.

                        Possible values: $(ARR_TO_STR "${ROOT_SOL_MAP[@]}")
                        Default: $ROOT_SOL

    --compress-format   Compress format of output file.

                        Possible values: $(ARR_TO_STR "${COMPRESS_FORMAT_MAP[@]}")
                        Default: $COMPRESS_FORMAT

Additional Options:
    --offline           Build WSA offline
    --magisk-custom     Install custom Magisk
    --skip-download-wsa Skip download WSA
    --help              Show this help message and exit

Example:
    ./build.sh --release-type RP --magisk-ver beta
    ./build.sh --arch arm64 --release-type WIF
    ./build.sh --release-type WIS
    ./build.sh --offline --magisk-custom
    ./build.sh --release-type WIF --magisk-custom --magisk-ver release
    "
}

ARGUMENT_LIST=(
    "compress-format:"
    "arch:"
    "release-type:"
    "root-sol:"
    "magisk-ver:"
    "magisk-custom"
    "install-gapps"
    "remove-amazon"
    "offline"
    "skip-download-wsa"
    "help"
    "debug"
)

default

opts=$(
    getopt \
        --longoptions "$(printf "%s," "${ARGUMENT_LIST[@]}")" \
        --name "$(basename "$0")" \
        --options "" \
        -- "$@"
) || exit_with_message "Failed to parse options, please check your input"

eval set --"$opts"
while [[ $# -gt 0 ]]; do
    case "$1" in
        --compress-format)
            COMPRESS_FORMAT="$2"
            shift 2
            ;;
        --arch)
            ARCH="$2"
            shift 2
            ;;
        --release-type)
            RELEASE_TYPE="$2"
            shift 2
            ;;
        --root-sol)
            ROOT_SOL="$2"
            shift 2
            ;;
        --magisk-ver)
            MAGISK_VER="$2"
            shift 2
            ;;
        --magisk-custom)
            CUSTOM_MAGISK=1
            shift
            ;;
        --install-gapps)
            HAS_GAPPS=1
            shift
            ;;
        --remove-amazon)
            REMOVE_AMAZON=1
            shift
            ;;
        --offline)
            OFFLINE=1
            shift
            ;;
        --skip-download-wsa)
            SKIP_DOWN_WSA=1
            shift
            ;;
        --help)
            usage
            exit 0
            ;;
        --debug)
            DEBUG=1
            shift
            ;;
        --)
            shift
            break
            ;;
    esac
done

check_list() {
    local input=$1
    if [ -n "$input" ]; then
        local name=$2
        shift
        local arr=("$@")
        local list_count=${#arr[@]}
        for i in "${arr[@]}"; do
            if [ "$input" == "$i" ]; then
                echo "INFO: $name: $input"
                break
            fi
            ((list_count--))
            if (("$list_count" <= 0)); then
                exit_with_message "Invalid $name: $input"
            fi
        done
    fi
}

check_list "$ARCH" "Architecture" "${ARCH_MAP[@]}"
check_list "$RELEASE_TYPE" "Release Type" "${RELEASE_TYPE_MAP[@]}"
check_list "$MAGISK_VER" "Magisk Version" "${MAGISK_VER_MAP[@]}"
check_list "$ROOT_SOL" "Root Solution" "${ROOT_SOL_MAP[@]}"
check_list "$COMPRESS_FORMAT" "Compress Format" "${COMPRESS_FORMAT_MAP[@]}"

if [ "$DEBUG" ]; then
    set -x
fi

ROOT_SEL=""

if [ "$ROOT_SOL" = "none" ]; then
    ROOT_SEL="none"
elif [ "$ROOT_SOL" = "magisk" ]; then
    ROOT_SEL="magisk"
elif [ "$ROOT_SOL" = "kernelsu" ]; then
    ROOT_SEL="kernelsu"
fi

if [ "$HAS_GAPPS" ]; then
    case "$ROOT_SOL" in
        "none")
            ROOT_SOL="magisk"
            echo "WARN: Force install Magisk since GApps needs it to mount the file"
            ;;
        "kernelsu")
            abort "Unsupported combination: Install GApps and KernelSU"
            ;;
        *)
            ;;
    esac
fi

# shellcheck disable=SC1091
[ -f "$PYTHON_VENV_DIR/bin/activate" ] && {
    source "$PYTHON_VENV_DIR/bin/activate" || abort "Failed to activate virtual environment, please re-run install_deps.sh"
}
declare -A RELEASE_NAME_MAP=(["retail"]="Retail" ["RP"]="Release Preview" ["WIS"]="Insider Slow" ["WIF"]="Insider Fast")
declare -A ANDROID_API_MAP=(["30"]="11.0" ["32"]="12.1" ["33"]="13.0")
declare -A ARCH_NAME_MAP=(["x64"]="x86_64" ["arm64"]="arm64")
RELEASE_NAME=${RELEASE_NAME_MAP[$RELEASE_TYPE]} || abort
echo -e "INFO: Release Name: $RELEASE_NAME\n"
WSA_ZIP_PATH=$DOWNLOAD_DIR/wsa-$RELEASE_TYPE.zip
vclibs_PATH="$DOWNLOAD_DIR/Microsoft.VCLibs.140.00_$ARCH.appx"
UWPVCLibs_PATH="$DOWNLOAD_DIR/Microsoft.VCLibs.140.00.UWPDesktop_$ARCH.appx"
xaml_PATH="$DOWNLOAD_DIR/Microsoft.UI.Xaml.2.8_$ARCH.appx"
MAGISK_ZIP=magisk-$MAGISK_VER.zip
MAGISK_PATH=$DOWNLOAD_DIR/$MAGISK_ZIP
CUST_PATH="$DOWNLOAD_DIR/cust.img"
if [ "$CUSTOM_MAGISK" ]; then
    if [ ! -f "$MAGISK_PATH" ]; then
        echo "Custom Magisk $MAGISK_ZIP not found"
        MAGISK_ZIP=app-$MAGISK_VER.apk
        echo -e "Fallback to $MAGISK_ZIP\n"
        MAGISK_PATH=$DOWNLOAD_DIR/$MAGISK_ZIP
        if [ ! -f "$MAGISK_PATH" ]; then
            abort "Custom Magisk $MAGISK_ZIP not found\nPlease put custom Magisk in $DOWNLOAD_DIR"
        fi
    fi
fi
ANDROID_API=33
update_gapps_files_name() {
    GAPPS_IMAGE_NAME=gapps-${ANDROID_API_MAP[$ANDROID_API]}-${ARCH_NAME_MAP[$ARCH]}.img
    GAPPS_RC_NAME=gapps-${ANDROID_API_MAP[$ANDROID_API]}.rc
    GAPPS_IMAGE_PATH=$DOWNLOAD_DIR/$GAPPS_IMAGE_NAME
    GAPPS_RC_PATH=$DOWNLOAD_DIR/$GAPPS_RC_NAME
}
WSA_MAJOR_VER=0
getKernelVersion() {
    local bintype kernel_string kernel_version
    bintype="$(file -b "$1")"
    if [[ $bintype == *"version"* ]]; then
        readarray -td '' kernel_string < <(awk '{ gsub(/, /,"\0"); print; }' <<<"$bintype, ")
        unset 'kernel_string[-1]'
        for i in "${kernel_string[@]}"; do
            if [[ $i == *"version"* ]]; then
                IFS=" " read -r -a kernel_string <<<"$i"
                kernel_version="${kernel_string[1]}"
            fi
        done
    else
        IFS=" " read -r -a kernel_string <<<"$(strings "$1" | grep 'Linux version')"
        kernel_version="${kernel_string[2]}"
    fi
    IFS=" " read -r -a arr <<<"${kernel_version//-/ }"
    printf '%s' "${arr[0]}"
}
update_ksu_zip_name() {
    KERNEL_VER=""
    if [ -f "$WORK_DIR/wsa/$ARCH/Tools/kernel" ]; then
        KERNEL_VER=$(getKernelVersion "$WORK_DIR/wsa/$ARCH/Tools/kernel")
    fi
    KERNELSU_ZIP_NAME=kernelsu-$ARCH-$KERNEL_VER.zip
    KERNELSU_PATH=$DOWNLOAD_DIR/$KERNELSU_ZIP_NAME
    KERNELSU_INFO="$KERNELSU_PATH.info"
}

vhdx_to_raw_img() {
    qemu-img convert -q -f vhdx -O raw "$1" "$2" || return 1
    rm -f "$1" || return 1
}

ro_ext4_img_to_rw() {
    resize_img "$1" "$(($(du --apparent-size -sB512 "$1" | cut -f1) * 2))"s || return 1
    e2fsck -fp -E unshare_blocks "$1" || return 1
    resize_img "$1" || return 1
    return 0
}

resize_img() {
    sudo e2fsck -pf "$1" || return 1
    if [ "$2" ]; then
        sudo resize2fs "$1" "$2" || return 1
    else
        sudo resize2fs -M "$1" || return 1
    fi
    return 0
}

if [ -z ${OFFLINE+x} ]; then
    echo "Generating WSA Download Links"
    if [ -z ${SKIP_DOWN_WSA+x} ]; then
        python3 generateWSALinks.py "$ARCH" "$RELEASE_TYPE" "$DOWNLOAD_DIR" "$DOWNLOAD_CONF_NAME" || abort
        echo "Downloading WSA"
    else
        python3 generateWSALinks.py "$ARCH" "$RELEASE_TYPE" "$DOWNLOAD_DIR" "$DOWNLOAD_CONF_NAME" "$SKIP_DOWN_WSA" || abort
        echo "Skip download WSA, downloading WSA depends"
    fi
    if ! aria2c --no-conf --log-level=info --log="$DOWNLOAD_DIR/aria2_download.log" -x16 -s16 -j5 -c -R -m0 \
        --async-dns=false --check-integrity=true --continue=true --allow-overwrite=true --conditional-get=true \
        -d"$DOWNLOAD_DIR" -i"$DOWNLOAD_DIR/$DOWNLOAD_CONF_NAME"; then
        abort "We have encountered an error while downloading files."
    fi
    rm -f "${DOWNLOAD_DIR:?}/$DOWNLOAD_CONF_NAME"
fi

echo "Extracting WSA"
if [ -f "$WSA_ZIP_PATH" ]; then
    if ! python3 extractWSA.py "$ARCH" "$WSA_ZIP_PATH" "$WORK_DIR" "$WSA_WORK_ENV"; then
        CLEAN_DOWNLOAD_WSA=1
        abort "Unzip WSA failed"
    fi
    echo -e "done\n"
    # shellcheck disable=SC1090
    source "$WSA_WORK_ENV" || abort
else
    abort "The WSA zip package does not exist"
fi
if [[ "$WSA_MAJOR_VER" -lt 2211 ]]; then
    ANDROID_API=32
fi

echo "Convert vhdx to RAW image"
vhdx_to_raw_img "$WORK_DIR/wsa/$ARCH/system_ext.vhdx" "$WORK_DIR/wsa/$ARCH/system_ext.img" || abort
vhdx_to_raw_img "$WORK_DIR/wsa/$ARCH/product.vhdx" "$WORK_DIR/wsa/$ARCH/product.img" || abort
vhdx_to_raw_img "$WORK_DIR/wsa/$ARCH/system.vhdx" "$WORK_DIR/wsa/$ARCH/system.img" || abort
vhdx_to_raw_img "$WORK_DIR/wsa/$ARCH/vendor.vhdx" "$WORK_DIR/wsa/$ARCH/vendor.img" || abort
echo -e "Convert vhdx to RAW image done\n"

echo "Remove read-only flag for read-only EXT4 image"
ro_ext4_img_to_rw "$WORK_DIR/wsa/$ARCH/system_ext.img" || abort
ro_ext4_img_to_rw "$WORK_DIR/wsa/$ARCH/product.img" || abort
ro_ext4_img_to_rw "$WORK_DIR/wsa/$ARCH/system.img" || abort
ro_ext4_img_to_rw "$WORK_DIR/wsa/$ARCH/vendor.img" || abort
echo -e "Remove read-only flag for read-only EXT4 image done\n"

echo "Calculate the required space"
EXTRA_SIZE=10240

SYSTEM_EXT_NEED_SIZE=$EXTRA_SIZE
if [ -d "$WORK_DIR/gapps/system_ext" ]; then
    SYSTEM_EXT_NEED_SIZE=$((SYSTEM_EXT_NEED_SIZE + $(du --apparent-size -sB512 "$WORK_DIR/gapps/system_ext" | cut -f1)))
fi

PRODUCT_NEED_SIZE=$EXTRA_SIZE
if [ -d "$WORK_DIR/gapps/product" ]; then
    PRODUCT_NEED_SIZE=$((PRODUCT_NEED_SIZE + $(du --apparent-size -sB512 "$WORK_DIR/gapps/product" | cut -f1)))
fi

SYSTEM_NEED_SIZE=$EXTRA_SIZE
if [ -d "$WORK_DIR/gapps" ]; then
    SYSTEM_NEED_SIZE=$((SYSTEM_NEED_SIZE + $(du --apparent-size -sB512 "$WORK_DIR/gapps" | cut -f1) - PRODUCT_NEED_SIZE - SYSTEM_EXT_NEED_SIZE))
fi
if [ "$ROOT_SOL" = "magisk" ]; then
    if [ -d "$WORK_DIR/magisk" ]; then
        MAGISK_SIZE=$(du --apparent-size -sB512 "$WORK_DIR/magisk/magisk" | cut -f1)
        SYSTEM_NEED_SIZE=$((SYSTEM_NEED_SIZE + MAGISK_SIZE))
    fi
    if [ -f "$MAGISK_PATH" ]; then
        MAGISK_APK_SIZE=$(du --apparent-size -sB512 "$MAGISK_PATH" | cut -f1)
        SYSTEM_NEED_SIZE=$((SYSTEM_NEED_SIZE + MAGISK_APK_SIZE))
    fi
fi
if [ -d "../$ARCH/system" ]; then
    SYSTEM_NEED_SIZE=$((SYSTEM_NEED_SIZE + $(du --apparent-size -sB512 "../$ARCH/system" | cut -f1)))
fi
VENDOR_NEED_SIZE=$EXTRA_SIZE
echo -e "done\n"

echo "Expand images"
SYSTEM_EXT_IMG_SIZE=$(du --apparent-size -sB512 "$WORK_DIR/wsa/$ARCH/system_ext.img" | cut -f1)
PRODUCT_IMG_SIZE=$(du --apparent-size -sB512 "$WORK_DIR/wsa/$ARCH/product.img" | cut -f1)
SYSTEM_IMG_SIZE=$(du --apparent-size -sB512 "$WORK_DIR/wsa/$ARCH/system.img" | cut -f1)
VENDOR_IMG_SIZE=$(du --apparent-size -sB512 "$WORK_DIR/wsa/$ARCH/vendor.img" | cut -f1)
SYSTEM_EXT_TARGET_SIZE=$((SYSTEM_EXT_NEED_SIZE * 2 + SYSTEM_EXT_IMG_SIZE))
PRODUCT_TAGET_SIZE=$((PRODUCT_NEED_SIZE * 2 + PRODUCT_IMG_SIZE))
SYSTEM_TAGET_SIZE=$((SYSTEM_IMG_SIZE * 2))
VENDOR_TAGET_SIZE=$((VENDOR_NEED_SIZE * 2 + VENDOR_IMG_SIZE))

resize_img "$WORK_DIR/wsa/$ARCH/system_ext.img" "$SYSTEM_EXT_TARGET_SIZE"s || abort
resize_img "$WORK_DIR/wsa/$ARCH/product.img" "$PRODUCT_TAGET_SIZE"s || abort
resize_img "$WORK_DIR/wsa/$ARCH/system.img" "$SYSTEM_TAGET_SIZE"s || abort
resize_img "$WORK_DIR/wsa/$ARCH/vendor.img" "$VENDOR_TAGET_SIZE"s || abort

echo -e "Expand images done\n"

echo "Mount images"
sudo mkdir "$ROOT_MNT" || abort
sudo mount -vo loop "$WORK_DIR/wsa/$ARCH/system.img" "$ROOT_MNT" || abort
sudo mount -vo loop "$WORK_DIR/wsa/$ARCH/vendor.img" "$VENDOR_MNT" || abort
sudo mount -vo loop "$WORK_DIR/wsa/$ARCH/product.img" "$PRODUCT_MNT" || abort
sudo mount -vo loop "$WORK_DIR/wsa/$ARCH/system_ext.img" "$SYSTEM_EXT_MNT" || abort
echo -e "done\n"

if [ -z ${OFFLINE+x} ]; then
    echo "Generating Download Links"
    if [ "$ROOT_SOL" = "magisk" ]; then
        if [ -z ${CUSTOM_MAGISK+x} ]; then
            python3 generateMagiskLink.py "$MAGISK_VER" "$DOWNLOAD_DIR" "$DOWNLOAD_CONF_NAME" || abort
        fi
    fi
    if [ "$ROOT_SOL" = "kernelsu" ]; then
        update_ksu_zip_name
        python3 generateKernelSULink.py "$ARCH" "$DOWNLOAD_DIR" "$DOWNLOAD_CONF_NAME" "$KERNEL_VER" "$KERNELSU_ZIP_NAME" || abort
        # shellcheck disable=SC1090
        source "$WSA_WORK_ENV" || abort
        # shellcheck disable=SC2153
        echo "KERNELSU_VER=$KERNELSU_VER" >"$KERNELSU_INFO"
    fi
    if [ "$HAS_GAPPS" ]; then
        update_gapps_files_name
        python3 generateGappsLink.py "$ARCH" "$DOWNLOAD_DIR" "$DOWNLOAD_CONF_NAME" "$ANDROID_API" "$GAPPS_IMAGE_NAME" || abort
    fi
    if [ -f "$DOWNLOAD_DIR/$DOWNLOAD_CONF_NAME" ]; then
        echo "Downloading Artifacts"
        if ! aria2c --no-conf --log-level=info --log="$DOWNLOAD_DIR/aria2_download.log" -x16 -s16 -j5 -c -R -m0 \
            --async-dns=false --check-integrity=true --continue=true --allow-overwrite=true --conditional-get=true \
            -d"$DOWNLOAD_DIR" -i"$DOWNLOAD_DIR/$DOWNLOAD_CONF_NAME"; then
            abort "We have encountered an error while downloading files."
        fi
    fi
fi
declare -A FILES_CHECK_LIST=([xaml_PATH]="$xaml_PATH" [vclibs_PATH]="$vclibs_PATH" [UWPVCLibs_PATH]="$UWPVCLibs_PATH")
if [ "$ROOT_SOL" = "magisk" ]; then
    FILES_CHECK_LIST+=(["MAGISK_PATH"]="$MAGISK_PATH" ["CUST_PATH"]="$CUST_PATH")
fi
if [ "$ROOT_SOL" = "kernelsu" ]; then
    update_ksu_zip_name
    FILES_CHECK_LIST+=(["KERNELSU_PATH"]="$KERNELSU_PATH")
fi
if [ "$HAS_GAPPS" ]; then
    update_gapps_files_name
    FILES_CHECK_LIST+=(["GAPPS_IMAGE_PATH"]="$GAPPS_IMAGE_PATH" ["GAPPS_RC_PATH"]="$GAPPS_RC_PATH")
fi
for i in "${FILES_CHECK_LIST[@]}"; do
    if [ ! -f "$i" ]; then
        echo "Offline mode: missing [$i]"
        FILE_MISSING="1"
    fi
done
if [ "$FILE_MISSING" ]; then
    abort "Some files are missing"
fi
if [ "$ROOT_SOL" = "magisk" ]; then
    echo "Extracting Magisk"
    if [ -f "$MAGISK_PATH" ]; then
        MAGISK_VERSION_NAME=""
        MAGISK_VERSION_CODE=0
        if ! python3 extractMagisk.py "$ARCH" "$MAGISK_PATH" "$WORK_DIR"; then
            CLEAN_DOWNLOAD_MAGISK=1
            abort "Unzip Magisk failed, is the download incomplete?"
        fi
        # shellcheck disable=SC1090
        source "$WSA_WORK_ENV" || abort
        if [ "$MAGISK_VERSION_CODE" -lt 26000 ] && [ "$MAGISK_VER" != "stable" ] && [ -z ${CUSTOM_MAGISK+x} ]; then
            abort "Please install Magisk 26.0+"
        fi
        chmod +x "$WORK_DIR/magisk/magiskboot" || abort
    elif [ -z "${CUSTOM_MAGISK+x}" ]; then
        abort "The Magisk zip package does not exist, is the download incomplete?"
    else
        abort "The Magisk zip package does not exist, rename it to magisk-debug.zip and put it in the download folder."
    fi
    echo -e "done\n"
fi

if [ "$ROOT_SOL" = "magisk" ]; then
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
    "$WORK_DIR/magisk/magiskboot" cpio "$WORK_DIR/wsa/$ARCH/Tools/initrd.img" \
        "mv /init /wsainit" \
        "add 0750 /lspinit ../bin/$ARCH/lspinit" \
        "ln /lspinit /init" \
        "add 0750 /magiskinit $WORK_DIR/magisk/magiskinit" \
        "mkdir 0750 overlay.d" \
        "mkdir 0750 overlay.d/sbin" \
        "$SINGLEABI add 0644 overlay.d/sbin/magisk64.xz $WORK_DIR/magisk/magisk64.xz" \
        "$SINGLEABI add 0644 overlay.d/sbin/magisk32.xz $WORK_DIR/magisk/magisk32.xz" \
        "$SKIP add 0644 overlay.d/sbin/magisk.xz $WORK_DIR/magisk/magisk.xz" \
        "$SKIPINITLD add 0644 overlay.d/sbin/init-ld.xz $WORK_DIR/magisk/init-ld.xz" \
        "add 0644 overlay.d/sbin/stub.xz $WORK_DIR/magisk/stub.xz" \
        "mkdir 000 .backup" \
        "add 000 overlay.d/init.lsp.magisk.rc init.lsp.magisk.rc" \
        "add 000 overlay.d/sbin/post-fs-data.sh post-fs-data.sh" \
        "add 000 overlay.d/sbin/lsp_cust.img $CUST_PATH" \
        || abort "Unable to patch initrd"
elif [ "$ROOT_SOL" = "kernelsu" ]; then
    echo "Extracting KernelSU"
    # shellcheck disable=SC1090
    source "${KERNELSU_INFO:?}" || abort
    echo "WSA Kernel Version: $KERNEL_VER"
    echo "KernelSU Version: $KERNELSU_VER"
    if ! unzip "$KERNELSU_PATH" -d "$WORK_DIR/kernelsu"; then
        CLEAN_DOWNLOAD_KERNELSU=1
        abort "Unzip KernelSU failed, package is corrupted?"
    fi
    if [ "$ARCH" = "x64" ]; then
        mv "$WORK_DIR/kernelsu/bzImage" "$WORK_DIR/kernelsu/kernel"
    elif [ "$ARCH" = "arm64" ]; then
        mv "$WORK_DIR/kernelsu/Image" "$WORK_DIR/kernelsu/kernel"
    fi
    echo "Integrate KernelSU"
    mv "$WORK_DIR/wsa/$ARCH/Tools/kernel" "$WORK_DIR/wsa/$ARCH/Tools/kernel_origin"
    cp "$WORK_DIR/kernelsu/kernel" "$WORK_DIR/wsa/$ARCH/Tools/kernel"
fi
echo -e "done\n"
if [ "$HAS_GAPPS" ]; then
    update_gapps_files_name
    if [ -f "$GAPPS_IMAGE_PATH" ] && [ -f "$GAPPS_RC_PATH" ]; then
        echo "Integrating GApps"
        "$WORK_DIR/magisk/magiskboot" cpio "$WORK_DIR/wsa/$ARCH/Tools/initrd.img" \
            "add 000 overlay.d/gapps.rc $GAPPS_RC_PATH" \
            "add 000 overlay.d/sbin/lsp_gapps.img $GAPPS_IMAGE_PATH" \
            || abort "Unable to patch initrd"
        echo -e "done\n"
    else
        abort "The GApps package does not exist."
    fi
fi

if [ "$REMOVE_AMAZON" ]; then
    rm -f "$WORK_DIR/wsa/$ARCH/apex/"mado*.apex || abort
fi

# Download and install Houdini files
echo "Downloading and installing Houdini files (Many Thanks to SupremeGamers)"
HOUDINI_BASE_URL="https://github.com/supremegamers/vendor_intel_proprietary_houdini/raw/refs/heads/hpe-14/prebuilts"

# Create necessary directories
sudo mkdir -p "$VENDOR_MNT/etc/binfmt_misc" || abort "Failed to create binfmt_misc directory"
sudo mkdir -p "$VENDOR_MNT/lib" || abort "Failed to create vendor lib directory"
sudo mkdir -p "$VENDOR_MNT/lib64" || abort "Failed to create vendor lib64 directory"
sudo mkdir -p "$VENDOR_MNT/bin" || abort "Failed to create vendor bin directory"
sudo mkdir -p "$SYSTEM_MNT/bin" || abort "Failed to create system bin directory"

# Download and copy binfmt_misc files
echo "Downloading binfmt_misc files..."
curl -L "$HOUDINI_BASE_URL/etc/binfmt_misc/arm64_dyn" -o "/tmp/arm64_dyn" || abort "Failed to download arm64_dyn"
curl -L "$HOUDINI_BASE_URL/etc/binfmt_misc/arm64_exe" -o "/tmp/arm64_exe" || abort "Failed to download arm64_exe"
curl -L "$HOUDINI_BASE_URL/etc/binfmt_misc/arm_dyn" -o "/tmp/arm_dyn" || abort "Failed to download arm_dyn"
curl -L "$HOUDINI_BASE_URL/etc/binfmt_misc/arm_exe" -o "/tmp/arm_exe" || abort "Failed to download arm_exe"

sudo cp "/tmp/arm64_dyn" "$VENDOR_MNT/etc/binfmt_misc/" || abort "Failed to copy arm64_dyn"
sudo cp "/tmp/arm64_exe" "$VENDOR_MNT/etc/binfmt_misc/" || abort "Failed to copy arm64_exe"
sudo cp "/tmp/arm_dyn" "$VENDOR_MNT/etc/binfmt_misc/" || abort "Failed to copy arm_dyn"
sudo cp "/tmp/arm_exe" "$VENDOR_MNT/etc/binfmt_misc/" || abort "Failed to copy arm_exe"

# Set SELinux properties for binfmt_misc files
sudo setfattr -n security.selinux -v "u:object_r:vendor_configs_file:s0" "$VENDOR_MNT/etc/binfmt_misc/arm64_dyn" || abort "Failed to set SELinux context for arm64_dyn"
sudo setfattr -n security.selinux -v "u:object_r:vendor_configs_file:s0" "$VENDOR_MNT/etc/binfmt_misc/arm64_exe" || abort "Failed to set SELinux context for arm64_exe"
sudo setfattr -n security.selinux -v "u:object_r:vendor_configs_file:s0" "$VENDOR_MNT/etc/binfmt_misc/arm_dyn" || abort "Failed to set SELinux context for arm_dyn"
sudo setfattr -n security.selinux -v "u:object_r:vendor_configs_file:s0" "$VENDOR_MNT/etc/binfmt_misc/arm_exe" || abort "Failed to set SELinux context for arm_exe"

# Download and copy vendor lib files
echo "Downloading vendor library files..."
curl -L "$HOUDINI_BASE_URL/lib/libhoudini.so" -o "/tmp/libhoudini_32.so" || abort "Failed to download 32-bit libhoudini.so"
curl -L "$HOUDINI_BASE_URL/lib64/libhoudini.so" -o "/tmp/libhoudini_64.so" || abort "Failed to download 64-bit libhoudini.so"

sudo cp "/tmp/libhoudini_32.so" "$VENDOR_MNT/lib/libhoudini.so" || abort "Failed to copy 32-bit libhoudini.so"
sudo cp "/tmp/libhoudini_64.so" "$VENDOR_MNT/lib64/libhoudini.so" || abort "Failed to copy 64-bit libhoudini.so"

# Set SELinux properties for vendor lib files
sudo setfattr -n security.selinux -v "u:object_r:same_process_hal_file:s0" "$VENDOR_MNT/lib/libhoudini.so" || abort "Failed to set SELinux context for 32-bit libhoudini.so"
sudo setfattr -n security.selinux -v "u:object_r:same_process_hal_file:s0" "$VENDOR_MNT/lib64/libhoudini.so" || abort "Failed to set SELinux context for 64-bit libhoudini.so"

# Download and copy vendor bin files
echo "Downloading vendor binary files..."
curl -L "$HOUDINI_BASE_URL/bin/houdini" -o "/tmp/houdini" || abort "Failed to download houdini binary"
curl -L "$HOUDINI_BASE_URL/bin/houdini64" -o "/tmp/houdini64" || abort "Failed to download houdini64 binary"

sudo cp "/tmp/houdini" "$VENDOR_MNT/bin/" || abort "Failed to copy houdini to vendor bin"
sudo cp "/tmp/houdini64" "$VENDOR_MNT/bin/" || abort "Failed to copy houdini64 to vendor bin"

# Set SELinux properties for vendor bin files
sudo setfattr -n security.selinux -v "u:object_r:same_process_hal_file:s0" "$VENDOR_MNT/bin/houdini" || abort "Failed to set SELinux context for vendor houdini"
sudo setfattr -n security.selinux -v "u:object_r:same_process_hal_file:s0" "$VENDOR_MNT/bin/houdini64" || abort "Failed to set SELinux context for vendor houdini64"

# Copy to system bin and set SELinux properties
echo "Copying to system bin..."
sudo cp "/tmp/houdini" "$SYSTEM_MNT/bin/" || abort "Failed to copy houdini to system bin"
sudo cp "/tmp/houdini64" "$SYSTEM_MNT/bin/" || abort "Failed to copy houdini64 to system bin"

# Set SELinux properties for system bin files
sudo setfattr -n security.selinux -v "u:object_r:system_file:s0" "$SYSTEM_MNT/bin/houdini" || abort "Failed to set SELinux context for system houdini"
sudo setfattr -n security.selinux -v "u:object_r:system_file:s0" "$SYSTEM_MNT/bin/houdini64" || abort "Failed to set SELinux context for system houdini64"

# Set executable permissions
sudo chmod 755 "$VENDOR_MNT/bin/houdini" "$VENDOR_MNT/bin/houdini64" "$SYSTEM_MNT/bin/houdini" "$SYSTEM_MNT/bin/houdini64" || abort "Failed to set executable permissions"

# Clean up temporary files
rm -f /tmp/arm64_dyn /tmp/arm64_exe /tmp/arm_dyn /tmp/arm_exe /tmp/libhoudini_32.so /tmp/libhoudini_64.so /tmp/houdini /tmp/houdini64

echo -e "Houdini files installation completed\n"


echo "Umount images"
sudo find "$ROOT_MNT" -exec touch -hamt 200901010000.00 {} \;
sudo umount -v "$VENDOR_MNT"
sudo umount -v "$PRODUCT_MNT"
sudo umount -v "$SYSTEM_EXT_MNT"
sudo umount -v "$ROOT_MNT"
echo -e "done\n"
echo "Shrink images"
resize_img "$WORK_DIR/wsa/$ARCH/system.img" || abort
resize_img "$WORK_DIR/wsa/$ARCH/vendor.img" || abort
resize_img "$WORK_DIR/wsa/$ARCH/product.img" || abort
resize_img "$WORK_DIR/wsa/$ARCH/system_ext.img" || abort
echo -e "Shrink images done\n"

echo "Convert images to vhdx"
qemu-img convert -q -f raw -o subformat=fixed -O vhdx "$WORK_DIR/wsa/$ARCH/system_ext.img" "$WORK_DIR/wsa/$ARCH/system_ext.vhdx" || abort
qemu-img convert -q -f raw -o subformat=fixed -O vhdx "$WORK_DIR/wsa/$ARCH/product.img" "$WORK_DIR/wsa/$ARCH/product.vhdx" || abort
qemu-img convert -q -f raw -o subformat=fixed -O vhdx "$WORK_DIR/wsa/$ARCH/system.img" "$WORK_DIR/wsa/$ARCH/system.vhdx" || abort
qemu-img convert -q -f raw -o subformat=fixed -O vhdx "$WORK_DIR/wsa/$ARCH/vendor.img" "$WORK_DIR/wsa/$ARCH/vendor.vhdx" || abort
rm -f "$WORK_DIR/wsa/$ARCH/"*.img || abort
echo -e "Convert images to vhdx done\n"

echo "Removing signature and add scripts"
rm -rf "${WORK_DIR:?}"/wsa/"$ARCH"/\[Content_Types\].xml "$WORK_DIR/wsa/$ARCH/AppxBlockMap.xml" "$WORK_DIR/wsa/$ARCH/AppxSignature.p7x" "$WORK_DIR/wsa/$ARCH/AppxMetadata" || abort
cp "$vclibs_PATH" "$xaml_PATH" "$WORK_DIR/wsa/$ARCH" || abort
cp "$UWPVCLibs_PATH" "$xaml_PATH" "$WORK_DIR/wsa/$ARCH" || abort
cp "../bin/$ARCH/makepri.exe" "$WORK_DIR/wsa/$ARCH" || abort
cp "../xml/priconfig.xml" "$WORK_DIR/wsa/$ARCH/xml/" || abort
cp ../installer/MakePri.ps1 "$WORK_DIR/wsa/$ARCH" || abort
cp ../installer/Install.ps1 "$WORK_DIR/wsa/$ARCH" || abort
cp ../installer/Run.bat "$WORK_DIR/wsa/$ARCH" || abort
find "$WORK_DIR/wsa/$ARCH" -maxdepth 1 -mindepth 1 -printf "%P\n" >"$WORK_DIR/wsa/$ARCH/filelist.txt" || abort
echo -e "done\n"

if [[ "$ROOT_SEL" = "none" ]]; then
    name1=""
elif [ "$ROOT_SEL" = "magisk" ]; then
    name1="-with-magisk-$MAGISK_VERSION_NAME($MAGISK_VERSION_CODE)-$MAGISK_VER"
elif [ "$ROOT_SEL" = "kernelsu" ]; then
    name1="-with-$ROOT_SEL-$KERNELSU_VER"
fi
if [ -z "$HAS_GAPPS" ]; then
    name2="-NoGApps"
else
    name2=-GApps-${ANDROID_API_MAP[$ANDROID_API]}
fi

artifact_name=WSA_${WSA_VER}_${ARCH}_${WSA_REL}${name1}${name2}
[ "$REMOVE_AMAZON" ] && artifact_name+=-NoAmazon

short_artifact_name=WSA_${WSA_VER}_${ARCH}

if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi

OUTPUT_PATH="${OUTPUT_DIR:?}/$short_artifact_name"
mv "$WORK_DIR/wsa/$ARCH" "$OUTPUT_PATH"
{
  echo "artifact_folder=${short_artifact_name}"  
  echo "artifact=${artifact_name}"
  echo "arch=${ARCH}"
  echo "built=$(date -u +%Y%m%d%H%M%S)"
  echo "file_ext=${COMPRESS_FORMAT}"
} >> "$GITHUB_OUTPUT"
