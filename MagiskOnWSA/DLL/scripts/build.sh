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

# shellcheck disable=SC2034
cd "$(dirname "$0")" || exit 1
# export TMPDIR=$HOME/.cache/wsa
if [ "$TMPDIR" ] && [ ! -d "$TMPDIR" ]; then
    mkdir -p "$TMPDIR"
fi
WORK_DIR=$(mktemp -d -t wsa-build-XXXXXXXXXX_) || exit 1

DOWNLOAD_DIR=../download
DOWNLOAD_WSA_CONF_NAME=wsa.list
DOWNLOAD_CONF_NAME=download.list
PYTHON_VENV_DIR="$(dirname "$PWD")/python3-env"
OUTPUT_DIR=../output
WSA_WORK_ENV="${WORK_DIR:?}/ENV"

touch "$WSA_WORK_ENV"
export WSA_WORK_ENV
abort() {
    [ "$1" ] && echo -e "ERROR: $1"
    echo "Build: an error has occurred, exit"
    exit 1
}
trap abort INT TERM

default() {
    ARCH=x64
#    CUSTOM_MODEL=redfin
    RELEASE_TYPE=retail
    MAGISK_BRANCH=topjohnwu
    MAGISK_VER=stable
    ROOT_SOL=magisk
    COMPRESS_FORMAT=none
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
    "latest"
)

MAGISK_BRANCH_MAP=(
    "topjohnwu"
    "HuskyDG"
    "vvb2060"
)

MAGISK_VER_MAP=(
    "stable"
    "beta"
    "canary"
    "debug"
    "release"
    "delta"
    "alpha"
)

# CUSTOM_MODEL_MAP=(
#    "none"
#    "sunfish"
#    "bramble"
#    "redfin"
#    "barbet"
#    "raven"
#    "oriole"
#    "bluejay"
#    "panther"
#    "cheetah"
#    "lynx"
#    "tangorpro"
#    "felix"
# )

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

ARGUMENT_LIST=(
    "compress-format:"
    "arch:"
    "release-type:"
    "root-sol:"
    "magisk-branch:"
    "magisk-ver:"
    "install-gapps"
    "remove-amazon"
)

default

opts=$(
    getopt \
        --longoptions "$(printf "%s," "${ARGUMENT_LIST[@]}")" \
        --name "$(basename "$0")" \
        --options "" \
        -- "$@"
) || abort "Failed to parse options, please check your input"

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
        --magisk-branch)
            MAGISK_BRANCH="$2"
            shift 2
            ;;
        --magisk-ver)
            MAGISK_VER="$2"
            shift 2
            ;;
        --install-gapps)
            HAS_GAPPS=1
            shift
            ;;
        --remove-amazon)
            REMOVE_AMAZON=1
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
                abort "Invalid $name: $input"
            fi
        done
    fi
}

check_list "$ARCH" "Architecture" "${ARCH_MAP[@]}"
check_list "$RELEASE_TYPE" "Release Type" "${RELEASE_TYPE_MAP[@]}"
check_list "$MAGISK_BRANCH" "Magisk Branch" "${MAGISK_BRANCH_MAP[@]}"
check_list "$MAGISK_VER" "Magisk Version" "${MAGISK_VER_MAP[@]}"
check_list "$ROOT_SOL" "Root Solution" "${ROOT_SOL_MAP[@]}"
# check_list "$CUSTOM_MODEL" "Custom Model" "${CUSTOM_MODEL_MAP[@]}"
check_list "$COMPRESS_FORMAT" "Compress Format" "${COMPRESS_FORMAT_MAP[@]}"

# shellcheck disable=SC1091
[ -f "$PYTHON_VENV_DIR/bin/activate" ] && {
    source "$PYTHON_VENV_DIR/bin/activate" || abort "Failed to activate virtual environment"
}
declare -A RELEASE_NAME_MAP=(["retail"]="Retail" ["latest"]="Insider Private" ["RP"]="Release Preview" ["WIS"]="Insider Slow" ["WIF"]="Insider Fast")
declare -A ANDROID_API_MAP=(["33"]="13.0" ["34"]="14.0")
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
    KERNELSU_APK_PATH=$DOWNLOAD_DIR/KernelSU.apk
    KERNELSU_INFO="$KERNELSU_PATH.info"
}

echo "Generating WSA Download Links"
python3 generateWSALinks.py "$ARCH" "$RELEASE_TYPE" "$DOWNLOAD_DIR" "$DOWNLOAD_WSA_CONF_NAME" || abort

if [ "$RELEASE_TYPE" == "latest" ]; then
    printf "%s\n" "$(curl -sL https://api.github.com/repos/bubbles-wow/WSA-Archive/releases/latest | jq -r '.assets[] | .browser_download_url')" >> "$DOWNLOAD_DIR/$DOWNLOAD_WSA_CONF_NAME" || abort
    printf "  dir=%s\n" "$DOWNLOAD_DIR" >> "$DOWNLOAD_DIR/$DOWNLOAD_WSA_CONF_NAME" || abort
    printf "  out=wsa-latest.zip\n" >> "$DOWNLOAD_DIR/$DOWNLOAD_WSA_CONF_NAME" || abort
    WSA_VER=$(curl -sL https://api.github.com/repos/bubbles-wow/WSA-Archive/releases/latest | jq -r '.tag_name')
    WSA_MAJOR_VER=${WSA_VER:0:4}
else
    # shellcheck disable=SC1090
    source "$WSA_WORK_ENV" || abort
fi

if ! aria2c --no-conf --log-level=info --log="$DOWNLOAD_DIR/aria2_download.log" -x16 -s16 -j7 -m0 \
    --async-dns=false --check-integrity=true \
    -d"$DOWNLOAD_DIR" -i"$DOWNLOAD_DIR/$DOWNLOAD_WSA_CONF_NAME"; then
    abort "We have encountered an error while downloading files."
fi

echo "Extracting WSA"
if [ -f "$WSA_ZIP_PATH" ]; then
    if ! python3 extractWSA.py "$ARCH" "$WSA_ZIP_PATH" "$WORK_DIR" "$WSA_WORK_ENV"; then
        abort "Unzip WSA failed"
    fi
    echo -e "done\n"
    # shellcheck disable=SC1090
    source "$WSA_WORK_ENV" || abort
else
    abort "The WSA zip package does not exist"
fi

echo "Generating Download Links"
if [ "$HAS_GAPPS" ] || [ "$ROOT_SOL" = "magisk" ]; then
    python3 generateMagiskLink.py "$MAGISK_BRANCH" "$MAGISK_VER" "$DOWNLOAD_DIR" "$DOWNLOAD_CONF_NAME" || abort
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
    if ! aria2c --no-conf --log-level=info --log="$DOWNLOAD_DIR/aria2_download.log" -x16 -s16 -j7 -m0 \
        --async-dns=false --check-integrity=true \
        -d"$DOWNLOAD_DIR" -i"$DOWNLOAD_DIR/$DOWNLOAD_CONF_NAME"; then
        abort "We have encountered an error while downloading files."
    fi
fi

declare -A FILES_CHECK_LIST=([xaml_PATH]="$xaml_PATH" [vclibs_PATH]="$vclibs_PATH" [UWPVCLibs_PATH]="$UWPVCLibs_PATH")
if [ "$HAS_GAPPS" ] || [ "$ROOT_SOL" = "magisk" ]; then
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
if [ "$HAS_GAPPS" ] || [ "$ROOT_SOL" = "magisk" ]; then
    echo "Extracting Magisk"
    if [ -f "$MAGISK_PATH" ]; then
        MAGISK_VERSION_NAME=""
        MAGISK_VERSION_CODE=0
        if ! python3 extractMagisk.py "$ARCH" "$MAGISK_PATH" "$WORK_DIR"; then
            abort "Unzip Magisk failed, is the download incomplete?"
        fi
        # shellcheck disable=SC1090
        source "$WSA_WORK_ENV" || abort
        chmod +x "$WORK_DIR/magisk/magiskboot" || abort
    else
        abort "The Magisk zip package does not exist, rename it to magisk-debug.zip and put it in the download folder."
    fi
    echo -e "done\n"
fi

if [ "$HAS_GAPPS" ] || [ "$ROOT_SOL" = "magisk" ]; then
    echo "Integrating Magisk"
    "$WORK_DIR/magisk/magiskboot" compress=xz "$WORK_DIR/magisk/magisk64" "$WORK_DIR/magisk/magisk64.xz"
    "$WORK_DIR/magisk/magiskboot" compress=xz "$WORK_DIR/magisk/magisk32" "$WORK_DIR/magisk/magisk32.xz"
    "$WORK_DIR/magisk/magiskboot" compress=xz "$MAGISK_PATH" "$WORK_DIR/magisk/stub.xz"
    "$WORK_DIR/magisk/magiskboot" cpio "$WORK_DIR/wsa/$ARCH/Tools/initrd.img" \
        "mv /init /wsainit" \
        "add 0750 /lspinit ../bin/$ARCH/lspinit" \
        "ln /lspinit /init" \
        "add 0750 /magiskinit $WORK_DIR/magisk/magiskinit" \
        "mkdir 0750 overlay.d" \
        "mkdir 0750 overlay.d/sbin" \
        "add 0644 overlay.d/sbin/magisk64.xz $WORK_DIR/magisk/magisk64.xz" \
        "add 0644 overlay.d/sbin/magisk32.xz $WORK_DIR/magisk/magisk32.xz" \
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
            "add 000 /lspolicy.rule sepolicy.rule" \
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

echo "Removing signature and add scripts"
rm -rf "${WORK_DIR:?}"/wsa/"$ARCH"/\[Content_Types\].xml "$WORK_DIR/wsa/$ARCH/AppxBlockMap.xml" "$WORK_DIR/wsa/$ARCH/AppxSignature.p7x" "$WORK_DIR/wsa/$ARCH/AppxMetadata" || abort
cp "$vclibs_PATH" "$xaml_PATH" "$WORK_DIR/wsa/$ARCH" || abort
cp "$UWPVCLibs_PATH" "$xaml_PATH" "$WORK_DIR/wsa/$ARCH" || abort
cp "../xml/priconfig.xml" "$WORK_DIR/wsa/$ARCH/xml/" || abort
cp "../installer/$ARCH/MakePri.ps1" "$WORK_DIR/wsa/$ARCH" || abort
cp "../installer/$ARCH/Install.ps1" "$WORK_DIR/wsa/$ARCH" || abort
cp "../installer/Run.bat" "$WORK_DIR/wsa/$ARCH" || abort
find "$WORK_DIR/wsa/$ARCH" -maxdepth 1 -mindepth 1 -printf "%P\n" >"$WORK_DIR/wsa/$ARCH/filelist.txt" || abort
find "$WORK_DIR/wsa/$ARCH/pri" -printf "%P\n" | sed -e 's/^/pri\\/' -e '/^$/d' > "$WORK_DIR/wsa/$ARCH/filelist-pri.txt" || abort
find "$WORK_DIR/wsa/$ARCH/xml" -printf "%P\n" | sed -e 's/^/xml\\/' -e '/^$/d' >> "$WORK_DIR/wsa/$ARCH/filelist-pri.txt" || abort
echo -e "done\n"

if [[ "$ROOT_SOL" = "none" ]]; then
    name1=""
elif [ "$ROOT_SOL" = "magisk" ]; then
    name1="-with-magisk-$MAGISK_VERSION_NAME($MAGISK_VERSION_CODE)-$MAGISK_VER"
elif [ "$ROOT_SOL" = "kernelsu" ]; then
    name1="-with-$ROOT_SOL-$KERNELSU_VER"
fi
if [ -z "$HAS_GAPPS" ]; then
    name2="-NoGApps"
else
    name2=-GApps-${ANDROID_API_MAP[$ANDROID_API]}
fi
#if [[ "$MODEL_NAME" != "default" ]]; then
#    name3="-as-$MODEL_NAME"
#fi
artifact_name=WSA_${WSA_VER}_${ARCH}_${WSA_REL}${name1}${name2}
#${name3}
[ "$REMOVE_AMAZON" ] && artifact_name+=-NoAmazon

if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi
OUTPUT_PATH="${OUTPUT_DIR:?}/$artifact_name"
mv "$WORK_DIR/wsa/$ARCH" "$OUTPUT_PATH"
{
  echo "artifact=${artifact_name}"
  echo "arch=${ARCH}"
  echo "built=$(date -u +%Y%m%d%H%M%S)"
  echo "file_ext=${COMPRESS_FORMAT}"
} >> "$GITHUB_OUTPUT"
