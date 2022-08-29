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
# Copyright (C) 2022 LSPosed Contributors
#

if [ ! "$BASH_VERSION" ] ; then
    echo "Please do not use sh to run this script, just execute it directly" 1>&2
    exit 1
fi
HOST_ARCH=$(uname -m)
if [ "$HOST_ARCH" != "x86_64" ] && [ "$HOST_ARCH" != "aarch64" ]; then
    echo "Unsupported architectures: $HOST_ARCH"
    exit 1
fi
cd "$(dirname "$0")" || exit 1
trap umount_clean EXIT
WORK_DIR=$(mktemp -d -t wsa-build-XXXXXXXXXX_) || exit 1
DOWNLOAD_DIR=../download
DOWNLOAD_CONF_NAME=download.list
OUTPUT_DIR=../output
MOUNT_DIR="$WORK_DIR"/system
CLEAN_DOWNLOAD_WSA=0
CLEAN_DOWNLOAD_MAGISK=0
CLEAN_DOWNLOAD_GAPPS=0
REMOVE_AMAZON="keep"
COMPRESS_OUTPUT="no"
OFFLINE=0
umount_clean(){
    echo "Cleanup Work Directory"
    if [ -d "$MOUNT_DIR" ]; then
        if [ -d "$MOUNT_DIR/vendor" ]; then
            sudo umount "$MOUNT_DIR"/vendor
        fi
        if [ -d "$MOUNT_DIR/product" ]; then
            sudo umount "$MOUNT_DIR"/product
        fi
        if [ -d "$MOUNT_DIR/system_ext" ]; then
            sudo umount "$MOUNT_DIR"/system_ext
        fi
        sudo umount "$MOUNT_DIR"
    fi
    sudo rm -rf "${WORK_DIR:?}"
}
clean_download(){
    if [ -d "$DOWNLOAD_DIR" ]; then
        echo "Cleanup Download Directory"
        if [ "$CLEAN_DOWNLOAD_WSA" = "1" ]; then
            rm -f "${WSA_ZIP_PATH:?}"
        fi
        if [ "$CLEAN_DOWNLOAD_MAGISK" = "1" ]; then
            rm -f "${MAGISK_PATH:?}"
        fi
        if [ "$CLEAN_DOWNLOAD_GAPPS" = "1" ]; then
            rm -f "${GAPPS_PATH:?}"
        fi
    fi
}
abort() {
    echo "Build: an error has occurred, exit"
    if [ -d "$WORK_DIR" ]; then
        umount_clean
    fi
    clean_download
    exit 1
}
trap abort INT TERM

function Gen_Rand_Str {
    tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w "$1" | head -n 1
}

usage(){
    if [ -n "$1" ]; then
        echo "Unknown parameter: $1"
    fi
    echo "Usage:
    --arch
    --release-type
    --magisk-ver
    --gapps-brand
    --gapps-variant
    --root-sol
    --remove-amazon
    --compress
    --offline
    --magisk-custom
    --debug
    "
    exit 1
}

ARGUMENT_LIST=(
  "arch:"
  "release-type:"
  "magisk-ver:"
  "gapps-brand:"
  "gapps-variant:"
  "root-sol:"
  "remove-amazon"
  "compress"
  "offline"
  "magisk-custom"
  "debug"
)

opts=$(getopt \
  --longoptions "$(printf "%s," "${ARGUMENT_LIST[@]}")" \
  --name "$(basename "$0")" \
  --options "" \
  -- "$@"
)

eval set --"$opts"
while [[ $# -gt 0 ]]; do
   case "$1" in
      --arch            ) ARCH="$2"; shift 2 ;;
      --release-type    ) RELEASE_TYPE="$2"; shift 2 ;;
      --magisk-ver      ) MAGISK_VER="$2"; shift 2 ;;
      --gapps-brand     ) GAPPS_BRAND="$2"; shift 2 ;;
      --gapps-variant   ) GAPPS_VARIANT="$2"; shift 2 ;;
      --remove-amazon   ) REMOVE_AMAZON="remove"; shift ;;
      --root-sol        ) ROOT_SOL="$2"; shift 2 ;;
      --compress        ) COMPRESS_OUTPUT="yes"; shift ;;
      --offline         ) OFFLINE="1"; shift ;;
      --debug           ) DEBUG="1"; shift ;;
      --magisk-custom   ) CUSTOM_MAGISK="1"; shift ;;
      --                ) shift; break;;
      ?                 ) usage "$2"; shift ;;
      *                 ) break ;;
   esac
done

declare -A PARA_CHECK_LIST=([ARCH]="$ARCH" [RELEASE_TYPE]="$RELEASE_TYPE" [MAGISK_VER]="$MAGISK_VER" [GAPPS_VARIANT]="$GAPPS_VARIANT" [REMOVE_AMAZON]="$REMOVE_AMAZON" [ROOT_SOL]="$ROOT_SOL")
for i in "${PARA_CHECK_LIST[@]}";
do
    if [ -z "$i" ]; then
        usage
    fi
done

echo -e "build: ARCH=$ARCH\nRELEASE_TYPE=$RELEASE_TYPE\nMAGISK_VER=$MAGISK_VER\nGAPPS_VARIANT=$GAPPS_VARIANT\nREMOVE_AMAZON=$REMOVE_AMAZON\nROOT_SOL=$ROOT_SOL\nCOMPRESS_OUTPUT=$COMPRESS_OUTPUT"

declare -A RELEASE_TYPE_MAP=(["retail"]="Retail" ["release preview"]="RP" ["insider slow"]="WIS" ["insider fast"]="WIF")

WSA_ZIP_PATH=$DOWNLOAD_DIR/wsa-$ARCH-${RELEASE_TYPE_MAP[$RELEASE_TYPE]}.zip
vclibs_PATH=vclibs-"$ARCH".appx
xaml_PATH=xaml-"$ARCH".appx
MAGISK_PATH=$DOWNLOAD_DIR/magisk-$MAGISK_VER.zip
if [ "$GAPPS_BRAND" = "OpenGApps" ]; then
    GAPPS_PATH="$DOWNLOAD_DIR"/OpenGApps-$ARCH-$GAPPS_VARIANT.zip
else
    GAPPS_PATH="$DOWNLOAD_DIR"/MindTheGapps-"$ARCH".zip
fi

if [ "$OFFLINE" != "1" ]; then
    trap 'rm -f -- "${DOWNLOAD_DIR:?}/${DOWNLOAD_CONF_NAME}"' EXIT
    echo "Generate Download Links"
    python3 generateWSALinks.py "$ARCH" "$RELEASE_TYPE" "$DOWNLOAD_DIR" "$DOWNLOAD_CONF_NAME" || abort
    if [ "$CUSTOM_MAGISK" != "1" ]; then
        python3 generateMagiskLink.py "$MAGISK_VER" "$DOWNLOAD_DIR" "$DOWNLOAD_CONF_NAME" || abort
    fi
    if [ "$GAPPS_VARIANT" != 'none' ] && [ "$GAPPS_VARIANT" != '' ]; then
        if [ "$GAPPS_BRAND" = "OpenGApps" ]; then
            python3 generateGappsLink.py "$ARCH" "$GAPPS_VARIANT" "$DOWNLOAD_DIR" "$DOWNLOAD_CONF_NAME" || abort
        fi
    fi

    echo "Download Artifacts"
    if ! aria2c --no-conf --log-level=info --log="$DOWNLOAD_DIR/aria2_download.log" -x16 -s16 -j5 -c -R -m0 --allow-overwrite=true --conditional-get=true -d"$DOWNLOAD_DIR" -i"$DOWNLOAD_DIR"/"$DOWNLOAD_CONF_NAME"; then
        echo "We have encountered an error while downloading files."
        exit 1
    fi
else
    if [ ! -f "$WSA_ZIP_PATH" ] || [ ! -f "$xaml_PATH" ] || [ ! -f "$vclibs_PATH" ]; then
        echo "Offline mode: missing WSA files."
        OFFLINE_ERR="1"
    fi
    if [ ! -f "$MAGISK_PATH" ]; then
        echo "Offline mode: missing Magisk $MAGISK_VER file."
        OFFLINE_ERR="1"
    fi
    if [ "$GAPPS_VARIANT" != 'none' ] && [ "$GAPPS_VARIANT" != '' ]; then
        if [ ! -f "$GAPPS_PATH" ]; then
            echo "Offline mode: missing $GAPPS_BRAND file."
            OFFLINE_ERR="1"
        fi
    fi
    if [ -n "$OFFLINE_ERR" ]; then
        echo "Offline mode: Some files are missing, please disable offline mode."
        exit 1
    fi
fi

echo "Extract WSA"
if [ -f "$WSA_ZIP_PATH" ]; then
    WSA_WORK_ENV="${WORK_DIR:?}"/ENV
    if [ -f "$WSA_WORK_ENV" ]; then rm -f "${WSA_WORK_ENV:?}"; fi
    export WSA_WORK_ENV
    if ! python3 extractWSA.py "$ARCH" "$WSA_ZIP_PATH" "$WORK_DIR"; then
        echo "Unzip WSA failed, is the download incomplete?"
        CLEAN_DOWNLOAD_WSA=1
        abort
    fi
    echo -e "Extract done\n"
    # shellcheck disable=SC1091
    source "${WORK_DIR:?}/ENV" || abort
else
    echo "The WSA zip package does not exist, is the download incomplete?"
    exit 1
fi
echo "Extract Magisk"

if [ -f "$MAGISK_PATH" ]; then
    if ! python3 extractMagisk.py "$ARCH" "$MAGISK_PATH" "$WORK_DIR"; then
        echo "Unzip Magisk failed, is the download incomplete?"
        CLEAN_DOWNLOAD_MAGISK=1
        abort
    fi
elif [ "$CUSTOM_MAGISK" != "1" ]; then
    echo "The Magisk zip package does not exist, is the download incomplete?"
    exit 1
else
    echo "The Magisk zip package does not exist, rename it to magisk-debug.zip and put it in the download folder."
    exit 1
fi
echo -e "done\n"

if [ "$GAPPS_VARIANT" != 'none' ] && [ "$GAPPS_VARIANT" != '' ]; then
    echo "Extract GApps"
    mkdir -p "$WORK_DIR"/gapps || abort
    if [ -f "$GAPPS_PATH" ]; then
        if [ "$GAPPS_BRAND" = "OpenGApps" ]; then
            if ! unzip -p "$GAPPS_PATH" {Core,GApps}/'*.lz' | tar --lzip -C "$WORK_DIR"/gapps -xf - -i --strip-components=2 --exclude='setupwizardtablet-x86_64' --exclude='packageinstallergoogle-all' --exclude='speech-common' --exclude='markup-lib-arm' --exclude='markup-lib-arm64' --exclude='markup-all' --exclude='setupwizarddefault-x86_64' --exclude='pixellauncher-all' --exclude='pixellauncher-common'; then
                echo "Unzip OpenGApps failed, is the download incomplete?"
                CLEAN_DOWNLOAD_GAPPS=1
                abort
            fi
        else
            if ! unzip "$GAPPS_PATH" "system/*" -x "system/addon.d/*" "system/system_ext/priv-app/SetupWizard/*" -d "$WORK_DIR"/gapps; then
                echo "Unzip MindTheGapps failed, package is corrupted?"
                abort
            fi
            mv "$WORK_DIR"/gapps/system/* "$WORK_DIR"/gapps || abort
            rm -rf "${WORK_DIR:?}"/gapps/system || abort
        fi
        cp -r ../"$ARCH"/gapps/* "$WORK_DIR"/gapps || abort
        if [ "$GAPPS_BRAND" = "MindTheGapps" ]; then
            mv "$WORK_DIR"/gapps/priv-app/* "$WORK_DIR"/gapps/system_ext/priv-app || abort
            rm -rf "${WORK_DIR:?}"/gapps/priv-app || abort
        fi
    else
        echo "The $GAPPS_BRAND zip package does not exist."
        exit 1
    fi
    echo -e "Extract done\n"
fi

echo "Expand images"

e2fsck -yf "$WORK_DIR"/wsa/"$ARCH"/system_ext.img || abort
SYSTEM_EXT_SIZE=$(($(du --apparent-size -sB512 "$WORK_DIR"/wsa/"$ARCH"/system_ext.img | cut -f1) + 20000))
if [ -d "$WORK_DIR"/gapps/system_ext ]; then
    SYSTEM_EXT_SIZE=$(( SYSTEM_EXT_SIZE + $(du --apparent-size -sB512 "$WORK_DIR"/gapps/system_ext | cut -f1) ))
fi
resize2fs "$WORK_DIR"/wsa/"$ARCH"/system_ext.img "$SYSTEM_EXT_SIZE"s || abort

e2fsck -yf "$WORK_DIR"/wsa/"$ARCH"/product.img || abort
PRODUCT_SIZE=$(($(du --apparent-size -sB512 "$WORK_DIR"/wsa/"$ARCH"/product.img | cut -f1) + 20000))
if [ -d "$WORK_DIR"/gapps/product ]; then
    PRODUCT_SIZE=$(( PRODUCT_SIZE + $(du --apparent-size -sB512 "$WORK_DIR"/gapps/product | cut -f1) ))
fi
resize2fs "$WORK_DIR"/wsa/"$ARCH"/product.img "$PRODUCT_SIZE"s || abort

e2fsck -yf "$WORK_DIR"/wsa/"$ARCH"/system.img || abort
SYSTEM_SIZE=$(($(du --apparent-size -sB512 "$WORK_DIR"/wsa/"$ARCH"/system.img | cut -f1) + 20000))
if [ -d "$WORK_DIR"/gapps ]; then
    SYSTEM_SIZE=$(( SYSTEM_SIZE + $(du --apparent-size -sB512 "$WORK_DIR"/gapps | cut -f1) - $(du --apparent-size -sB512 "$WORK_DIR"/gapps/product | cut -f1) ))
    if [ -d "$WORK_DIR"/gapps/system_ext ]; then
        SYSTEM_SIZE=$(( SYSTEM_SIZE - $(du --apparent-size -sB512 "$WORK_DIR"/gapps/system_ext | cut -f1) ))
    fi
fi
if [ -d "$WORK_DIR"/magisk ]; then
    SYSTEM_SIZE=$(( SYSTEM_SIZE + $(du --apparent-size -sB512 "$WORK_DIR"/magisk/magisk | cut -f1) ))
fi
if [ -f "$MAGISK_PATH" ]; then
    SYSTEM_SIZE=$(( SYSTEM_SIZE + $(du --apparent-size -sB512 "$MAGISK_PATH" | cut -f1) ))
fi
if [ -d "../$ARCH/system" ]; then
    SYSTEM_SIZE=$(( SYSTEM_SIZE + $(du --apparent-size -sB512 "../$ARCH/system" | cut -f1) ))
fi
resize2fs "$WORK_DIR"/wsa/"$ARCH"/system.img "$SYSTEM_SIZE"s || abort

e2fsck -yf "$WORK_DIR"/wsa/"$ARCH"/vendor.img || abort
VENDOR_SIZE=$(($(du --apparent-size -sB512 "$WORK_DIR"/wsa/"$ARCH"/vendor.img | cut -f1) + 20000))
resize2fs "$WORK_DIR"/wsa/"$ARCH"/vendor.img "$VENDOR_SIZE"s || abort
echo -e "Expand images done\n"

echo "Mount images"
sudo mkdir "$MOUNT_DIR" || abort
sudo mount -o loop "$WORK_DIR"/wsa/"$ARCH"/system.img "$MOUNT_DIR" || abort
sudo mount -o loop "$WORK_DIR"/wsa/"$ARCH"/vendor.img "$MOUNT_DIR"/vendor || abort
sudo mount -o loop "$WORK_DIR"/wsa/"$ARCH"/product.img "$MOUNT_DIR"/product || abort
sudo mount -o loop "$WORK_DIR"/wsa/"$ARCH"/system_ext.img "$MOUNT_DIR"/system_ext || abort
echo -e "done\n"

if [ "$REMOVE_AMAZON" = 'remove' ]; then
    echo "Remove Amazon AppStore"
    find "${MOUNT_DIR:?}"/product/{etc/permissions,etc/sysconfig,framework,priv-app} | grep -e amazon -e venezia | sudo xargs rm -rf
    echo -e "done\n"
fi

if [ "$ROOT_SOL" = 'magisk' ] || [ "$ROOT_SOL" = '' ]; then
    echo "Integrate Magisk"
    sudo mkdir "$MOUNT_DIR"/sbin
    sudo chcon --reference "$MOUNT_DIR"/init.environ.rc "$MOUNT_DIR"/sbin
    sudo chown root:root "$MOUNT_DIR"/sbin
    sudo chmod 0700 "$MOUNT_DIR"/sbin
    sudo cp "$WORK_DIR"/magisk/magisk/* "$MOUNT_DIR"/sbin/
    sudo cp "$MAGISK_PATH" "$MOUNT_DIR"/sbin/magisk.apk
    sudo tee -a "$MOUNT_DIR"/sbin/loadpolicy.sh <<EOF
#!/system/bin/sh
mkdir -p /data/adb/magisk
cp /sbin/* /data/adb/magisk/
chmod -R 755 /data/adb/magisk
restorecon -R /data/adb/magisk
for module in \$(ls /data/adb/modules); do
    if ! [ -f "/data/adb/modules/\$module/disable" ] && [ -f "/data/adb/modules/\$module/sepolicy.rule" ]; then
        /sbin/magiskpolicy --live --apply "/data/adb/modules/\$module/sepolicy.rule"
    fi
done
EOF

    sudo find "$MOUNT_DIR"/sbin -type f -exec chmod 0755 {} \;
    sudo find "$MOUNT_DIR"/sbin -type f -exec chown root:root {} \;
    sudo find "$MOUNT_DIR"/sbin -type f -exec chcon --reference "$MOUNT_DIR"/product {} \;
    sudo patchelf --replace-needed libc.so "../linker/$HOST_ARCH/libc.so" "$WORK_DIR"/magisk/magiskpolicy || abort
    sudo patchelf --replace-needed libm.so "../linker/$HOST_ARCH/libm.so" "$WORK_DIR"/magisk/magiskpolicy || abort
    sudo patchelf --replace-needed libdl.so "../linker/$HOST_ARCH/libdl.so" "$WORK_DIR"/magisk/magiskpolicy || abort
    sudo patchelf --set-interpreter "../linker/$HOST_ARCH/linker64" "$WORK_DIR"/magisk/magiskpolicy || abort
    chmod +x "$WORK_DIR"/magisk/magiskpolicy || abort
    TMP_PATH=$(Gen_Rand_Str 8)
    echo "/dev/$TMP_PATH(/.*)?    u:object_r:magisk_file:s0" | sudo tee -a "$MOUNT_DIR"/vendor/etc/selinux/vendor_file_contexts
    echo '/data/adb/magisk(/.*)?   u:object_r:magisk_file:s0' | sudo tee -a "$MOUNT_DIR"/vendor/etc/selinux/vendor_file_contexts
    sudo "$WORK_DIR"/magisk/magiskpolicy --load "$MOUNT_DIR"/vendor/etc/selinux/precompiled_sepolicy --save "$MOUNT_DIR"/vendor/etc/selinux/precompiled_sepolicy --magisk "allow * magisk_file lnk_file *" || abort
    SERVER_NAME1=$(Gen_Rand_Str 12)
    SERVER_NAME2=$(Gen_Rand_Str 12)
    SERVER_NAME3=$(Gen_Rand_Str 12)
    SERVER_NAME4=$(Gen_Rand_Str 12)
    sudo tee -a "$MOUNT_DIR"/system/etc/init/hw/init.rc <<EOF
on post-fs-data
    start adbd
    mkdir /dev/$TMP_PATH
    mount tmpfs tmpfs /dev/$TMP_PATH mode=0755
    copy /sbin/magisk64 /dev/$TMP_PATH/magisk64
    chmod 0755 /dev/$TMP_PATH/magisk64
    symlink ./magisk64 /dev/$TMP_PATH/magisk
    symlink ./magisk64 /dev/$TMP_PATH/su
    symlink ./magisk64 /dev/$TMP_PATH/resetprop
    copy /sbin/magisk32 /dev/$TMP_PATH/magisk32
    chmod 0755 /dev/$TMP_PATH/magisk32
    copy /sbin/magiskinit /dev/$TMP_PATH/magiskinit
    chmod 0755 /dev/$TMP_PATH/magiskinit
    copy /sbin/magiskpolicy /dev/$TMP_PATH/magiskpolicy
    chmod 0755 /dev/$TMP_PATH/magiskpolicy
    mkdir /dev/$TMP_PATH/.magisk 700
    mkdir /dev/$TMP_PATH/.magisk/mirror 700
    mkdir /dev/$TMP_PATH/.magisk/block 700
    copy /sbin/magisk.apk /dev/$TMP_PATH/stub.apk
    rm /dev/.magisk_unblock
    start $SERVER_NAME1
    start $SERVER_NAME2
    wait /dev/.magisk_unblock 40
    rm /dev/.magisk_unblock

service $SERVER_NAME1 /system/bin/sh /sbin/loadpolicy.sh
    user root
    seclabel u:r:magisk:s0
    oneshot

service $SERVER_NAME2 /dev/$TMP_PATH/magisk --post-fs-data
    user root
    seclabel u:r:magisk:s0
    oneshot

service $SERVER_NAME3 /dev/$TMP_PATH/magisk --service
    class late_start
    user root
    seclabel u:r:magisk:s0
    oneshot

on property:sys.boot_completed=1
    mkdir /data/adb/magisk 755
    copy /sbin/magisk.apk /data/adb/magisk/magisk.apk
    start $SERVER_NAME4

service $SERVER_NAME4 /dev/$TMP_PATH/magisk --boot-complete
    user root
    seclabel u:r:magisk:s0
    oneshot
EOF
echo -e "Integrate Magisk done\n"
fi

echo "Merge Language Resources"
cp "$WORK_DIR"/wsa/"$ARCH"/resources.pri "$WORK_DIR"/wsa/pri/en-us.pri
cp "$WORK_DIR"/wsa/"$ARCH"/AppxManifest.xml "$WORK_DIR"/wsa/xml/en-us.xml
tee "$WORK_DIR"/wsa/priconfig.xml <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<resources targetOsVersion="10.0.0" majorVersion="1">
<index root="\" startIndexAt="\">
    <indexer-config type="folder" foldernameAsQualifier="true" filenameAsQualifier="true" qualifierDelimiter="."/>
    <indexer-config type="PRI"/>
</index>
</resources>
EOF
wine64 ../wine/"$HOST_ARCH"/makepri.exe new /pr "$WORK_DIR"/wsa/pri /in MicrosoftCorporationII.WindowsSubsystemForAndroid /cf "$WORK_DIR"/wsa/priconfig.xml /of "$WORK_DIR"/wsa/"$ARCH"/resources.pri /o
sed -i -zE "s/<Resources.*Resources>/<Resources>\n$(cat "$WORK_DIR"/wsa/xml/* | grep -Po '<Resource [^>]*/>' | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/\$/\\$/g' | sed 's/\//\\\//g')\n<\/Resources>/g" "$WORK_DIR"/wsa/"$ARCH"/AppxManifest.xml
echo -e "Merge Language Resources done\n"

echo "Add extra packages"
sudo cp -r ../"$ARCH"/system/* "$MOUNT_DIR" || abort
find ../"$ARCH"/system/system/priv-app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system/priv-app/dir -type d -exec chmod 0755 {} \;
find ../"$ARCH"/system/system/priv-app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system/priv-app/dir -type f -exec chmod 0644 {} \;
find ../"$ARCH"/system/system/priv-app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system/priv-app/dir -exec chown root:root {} \;
find ../"$ARCH"/system/system/priv-app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system/priv-app/dir -exec chcon --reference="$MOUNT_DIR"/system/priv-app {} \;
find ../"$ARCH"/system/system/etc/permissions/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I file sudo find "$MOUNT_DIR"/system/etc/permissions/file -type f -exec chmod 0644 {} \;
find ../"$ARCH"/system/system/etc/permissions/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I file sudo find "$MOUNT_DIR"/system/etc/permissions/file -exec chown root:root {} \;
find ../"$ARCH"/system/system/etc/permissions/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I file sudo find "$MOUNT_DIR"/system/etc/permissions/file -type f -exec chcon --reference="$MOUNT_DIR"/system/etc/permissions/platform.xml {} \;
echo -e "Add extra packages done\n"

if [ "$GAPPS_VARIANT" != 'none' ] && [ "$GAPPS_VARIANT" != '' ]; then
    echo "Integrate GApps"

    find "$WORK_DIR/gapps/" -mindepth 1 -type d -exec sudo chmod 0755 {} \;
    find "$WORK_DIR/gapps/" -mindepth 1 -type d -exec sudo chown root:root {} \;
    file_list="$(find "$WORK_DIR/gapps/" -mindepth 1 -type f | cut -d/ -f5-)"
    for file in $file_list; do
        sudo chown root:root "$WORK_DIR/gapps/${file}"
        sudo chmod 0644 "$WORK_DIR/gapps/${file}"
    done

    if [ "$GAPPS_BRAND" = "OpenGApps" ]; then
        find "$WORK_DIR"/gapps/ -maxdepth 1 -mindepth 1 -type d -not -path '*product' -exec sudo cp --preserve=all -r {} "$MOUNT_DIR"/system \; || abort
    elif [ "$GAPPS_BRAND" = "MindTheGapps" ]; then
        sudo cp --preserve=all -r "$WORK_DIR"/gapps/system_ext/* "$MOUNT_DIR"/system_ext/ || abort
        if [ -e "$MOUNT_DIR"/system_ext/priv-app/SetupWizard ] ; then
            rm -rf "${MOUNT_DIR:?}/system_ext/priv-app/Provision"
        fi
    fi
    sudo cp --preserve=all -r "$WORK_DIR"/gapps/product/* "$MOUNT_DIR"/product || abort

    find "$WORK_DIR"/gapps/product/overlay -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I file sudo find "$MOUNT_DIR"/product/overlay/file -type f -exec chcon --reference="$MOUNT_DIR"/product/overlay/FontNotoSerifSource/FontNotoSerifSourceOverlay.apk {} \;

    if [ "$GAPPS_BRAND" = "OpenGApps" ]; then
        find "$WORK_DIR"/gapps/app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system/app/dir -type d -exec chcon --reference="$MOUNT_DIR"/system/app {} \;
        find "$WORK_DIR"/gapps/framework/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system/framework/dir -type d -exec chcon --reference="$MOUNT_DIR"/system/framework {} \;
        find "$WORK_DIR"/gapps/priv-app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system/priv-app/dir -type d -exec chcon --reference="$MOUNT_DIR"/system/priv-app {} \;
        find "$WORK_DIR"/gapps/app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I file sudo find "$MOUNT_DIR"/system/app/file -type f -exec chcon --reference="$MOUNT_DIR"/system/app/KeyChain/KeyChain.apk {} \;
        find "$WORK_DIR"/gapps/framework/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I file sudo find "$MOUNT_DIR"/system/framework/file -type f -exec chcon --reference="$MOUNT_DIR"/system/framework/ext.jar {} \;
        find "$WORK_DIR"/gapps/priv-app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I file sudo find "$MOUNT_DIR"/system/priv-app/file -type f -exec chcon --reference="$MOUNT_DIR"/system/priv-app/Shell/Shell.apk {} \;
        find "$WORK_DIR"/gapps/etc/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system/etc/dir -type d -exec chcon --reference="$MOUNT_DIR"/system/etc/permissions {} \;
        find "$WORK_DIR"/gapps/etc/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system/etc/dir -type f -exec chcon --reference="$MOUNT_DIR"/system/etc/permissions {} \;
    else
        find "$WORK_DIR"/gapps/product/app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I item sudo find "$MOUNT_DIR"/product/app/item -type d -exec chcon --reference="$MOUNT_DIR"/product/app {} \;
        find "$WORK_DIR"/gapps/product/etc/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I item sudo find "$MOUNT_DIR"/product/etc/item -type d -exec chcon --reference="$MOUNT_DIR"/product/etc {} \;
        find "$WORK_DIR"/gapps/product/priv-app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I item sudo find "$MOUNT_DIR"/product/priv-app/item -type d -exec chcon --reference="$MOUNT_DIR"/product/priv-app {} \;
        find "$WORK_DIR"/gapps/product/framework/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I item sudo find "$MOUNT_DIR"/product/framework/item -type d -exec chcon --reference="$MOUNT_DIR"/product/framework {} \;

        find "$WORK_DIR"/gapps/product/app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I item sudo find "$MOUNT_DIR"/product/app/item -type f -exec chcon --reference="$MOUNT_DIR"/product/app/HomeApp/HomeApp.apk {} \;
        find "$WORK_DIR"/gapps/product/etc/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I item sudo find "$MOUNT_DIR"/product/etc/item -type f -exec chcon --reference="$MOUNT_DIR"/product/etc/permissions/com.android.settings.intelligence.xml {} \;
        find "$WORK_DIR"/gapps/product/priv-app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I item sudo find "$MOUNT_DIR"/product/priv-app/item -type f -exec chcon --reference="$MOUNT_DIR"/product/priv-app/SettingsIntelligence/SettingsIntelligence.apk {} \;
        find "$WORK_DIR"/gapps/product/framework/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I item sudo find "$MOUNT_DIR"/product/framework/item -type f -exec chcon --reference="$MOUNT_DIR"/product/etc/permissions/com.android.settings.intelligence.xml {} \;
        find "$WORK_DIR"/gapps/system_ext/etc/permissions/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I file sudo find "$MOUNT_DIR"/system_ext/etc/permissions/file -type f -exec chcon --reference="$MOUNT_DIR"/system_ext/etc/permissions/com.android.systemui.xml {} \;

        sudo chcon --reference="$MOUNT_DIR"/product/lib64/libjni_eglfence.so "$MOUNT_DIR"/product/lib
        find "$WORK_DIR"/gapps/product/lib/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I file sudo find "$MOUNT_DIR"/product/lib/file -exec chcon --reference="$MOUNT_DIR"/product/lib64/libjni_eglfence.so {} \;
        find "$WORK_DIR"/gapps/product/lib64/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I file sudo find "$MOUNT_DIR"/product/lib64/file -type f -exec chcon --reference="$MOUNT_DIR"/product/lib64/libjni_eglfence.so {} \;        
        find "$WORK_DIR"/gapps/system_ext/priv-app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system_ext/priv-app/dir -type d -exec chcon --reference="$MOUNT_DIR"/system_ext/priv-app {} \;
        find "$WORK_DIR"/gapps/system_ext/etc/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system_ext/etc/dir -type d -exec chcon --reference="$MOUNT_DIR"/system_ext/etc {} \;
        find "$WORK_DIR"/gapps/system_ext/priv-app/ -maxdepth 1 -mindepth 1 -printf '%P\n' | xargs -I dir sudo find "$MOUNT_DIR"/system_ext/priv-app/dir -type f -exec chcon --reference="$MOUNT_DIR"/system_ext/priv-app/Settings/Settings.apk {} \;
    fi

    sudo patchelf --replace-needed libc.so "../linker/$HOST_ARCH/libc.so" "$WORK_DIR"/magisk/magiskpolicy || abort
    sudo patchelf --replace-needed libm.so "../linker/$HOST_ARCH/libm.so" "$WORK_DIR"/magisk/magiskpolicy || abort
    sudo patchelf --replace-needed libdl.so "../linker/$HOST_ARCH/libdl.so" "$WORK_DIR"/magisk/magiskpolicy || abort
    sudo patchelf --set-interpreter "../linker/$HOST_ARCH/linker64" "$WORK_DIR"/magisk/magiskpolicy || abort
    chmod +x "$WORK_DIR"/magisk/magiskpolicy || abort
    sudo "$WORK_DIR"/magisk/magiskpolicy --load "$MOUNT_DIR"/vendor/etc/selinux/precompiled_sepolicy --save "$MOUNT_DIR"/vendor/etc/selinux/precompiled_sepolicy "allow gmscore_app gmscore_app vsock_socket { create connect write read }" "allow gmscore_app device_config_runtime_native_boot_prop file read" "allow gmscore_app system_server_tmpfs dir search" "allow gmscore_app system_server_tmpfs file open" || abort
    echo -e "Integrate GApps done\n"
fi

if [ "$GAPPS_VARIANT" != 'none' ] && [ "$GAPPS_VARIANT" != '' ]; then
    echo "Fix GApps prop"
    sudo python3 fixGappsProp.py "$MOUNT_DIR" || abort
    echo -e "done\n"
fi

echo "Umount images"
sudo find "$MOUNT_DIR" -exec touch -amt 200901010000.00 {} \; >/dev/null 2>&1
sudo umount "$MOUNT_DIR"/vendor
sudo umount "$MOUNT_DIR"/product
sudo umount "$MOUNT_DIR"/system_ext
sudo umount "$MOUNT_DIR"
echo -e "done\n"

echo "Shrink images"
e2fsck -yf "$WORK_DIR"/wsa/"$ARCH"/system.img || abort
resize2fs -M "$WORK_DIR"/wsa/"$ARCH"/system.img || abort
e2fsck -yf "$WORK_DIR"/wsa/"$ARCH"/vendor.img || abort
resize2fs -M "$WORK_DIR"/wsa/"$ARCH"/vendor.img || abort
e2fsck -yf "$WORK_DIR"/wsa/"$ARCH"/product.img || abort
resize2fs -M "$WORK_DIR"/wsa/"$ARCH"/product.img || abort
e2fsck -yf "$WORK_DIR"/wsa/"$ARCH"/system_ext.img || abort
resize2fs -M "$WORK_DIR"/wsa/"$ARCH"/system_ext.img || abort
echo -e "Shrink images done\n"

echo "Remove signature and add scripts"
sudo rm -rf "${WORK_DIR:?}"/wsa/"$ARCH"/\[Content_Types\].xml "$WORK_DIR"/wsa/"$ARCH"/AppxBlockMap.xml "$WORK_DIR"/wsa/"$ARCH"/AppxSignature.p7x "$WORK_DIR"/wsa/"$ARCH"/AppxMetadata || abort
cp "$DOWNLOAD_DIR"/"$vclibs_PATH" "$DOWNLOAD_DIR"/"$xaml_PATH" "$WORK_DIR"/wsa/"$ARCH" || abort
tee "$WORK_DIR"/wsa/"$ARCH"/Install.ps1 <<EOF
# Automated Install script by Midonei
# http://github.com/doneibcn
function Test-Administrator {
    [OutputType([bool])]
    param()
    process {
        [Security.Principal.WindowsPrincipal]\$user = [Security.Principal.WindowsIdentity]::GetCurrent();
        return \$user.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
    }
}

function Finish {
    Clear-Host
    Start-Process "wsa://com.topjohnwu.magisk"
    Start-Process "wsa://com.android.vending"
}

if (-not (Test-Administrator)) {
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force
    \$proc = Start-Process -PassThru -WindowStyle Hidden -Verb RunAs powershell.exe -Args "-executionpolicy bypass -command Set-Location '\$PSScriptRoot'; &'\$PSCommandPath' EVAL"
    \$proc.WaitForExit()
    if (\$proc.ExitCode -ne 0) {
        Clear-Host
        Write-Warning "Failed to launch start as Administrator\`r\`nPress any key to exit"
        \$null = \$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    }
    exit
}
elseif ((\$args.Count -eq 1) -and (\$args[0] -eq "EVAL")) {
    Start-Process powershell.exe -Args "-executionpolicy bypass -command Set-Location '\$PSScriptRoot'; &'\$PSCommandPath'"
    exit
}

if (((Test-Path -Path $(find "$WORK_DIR"/wsa/"$ARCH" -maxdepth 1 -mindepth 1 -printf "\"%P\"\n" | paste -sd "," -)) -eq \$false).Count) {
    Write-Error "Some files are missing in the folder. Please try to build again. Press any key to exist"
    \$null = \$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    exit 1
}

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

\$VMP = Get-WindowsOptionalFeature -Online -FeatureName 'VirtualMachinePlatform'
if (\$VMP.State -ne "Enabled") {
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'VirtualMachinePlatform'
    Clear-Host
    Write-Warning "Need restart to enable virtual machine platform\`r\`nPress y to restart or press any key to exit"
    \$key = \$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    If ("y" -eq \$key.Character) {
        Restart-Computer -Confirm
    }
    Else {
        exit 1
    }
}

Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Path vclibs-$ARCH.appx
Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Path xaml-$ARCH.appx

\$Installed = \$null
\$Installed = Get-AppxPackage -Name 'MicrosoftCorporationII.WindowsSubsystemForAndroid'

If ((\$null -ne \$Installed) -and (-not (\$Installed.IsDevelopmentMode))) {
    Clear-Host
    Write-Warning "There is already one installed WSA. Please uninstall it first.\`r\`nPress y to uninstall existing WSA or press any key to exit"
    \$key = \$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    If ("y" -eq \$key.Character) {
        Remove-AppxPackage -Package \$Installed.PackageFullName
    }
    Else {
        exit 1
    }
}
Clear-Host
Write-Host "Installing MagiskOnWSA..."
Stop-Process -Name "wsaclient" -ErrorAction "silentlycontinue"
Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
if (\$?) {
    Finish
}
Elseif (\$null -ne \$Installed) {
    Clear-Host
    Write-Host "Failed to update, try to uninstall existing installation while preserving userdata..."
    Remove-AppxPackage -PreserveApplicationData -Package \$Installed.PackageFullName
    Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
    if (\$?) {
        Finish
    }
}
Write-Host "All Done\`r\`nPress any key to exit"
\$null = \$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
EOF
echo -e "Remove signature and add scripts done\n"

echo "Generate info"

if [[ "$ROOT_SOL" = "none" ]]; then
    name1=""
elif [[ "$ROOT_SOL" = "" ]]; then
    name1="-with-magisk-$MAGISK_VER"
else
    name1="-with-$ROOT_SOL-$MAGISK_VER"
fi
if [[ "$GAPPS_VARIANT" = "none" || "$GAPPS_VARIANT" = "" ]]; then
    name2="-NoGApps"
else
    if [ "$GAPPS_BRAND" = "OpenGApps" ]; then
        name2="-$GAPPS_BRAND-${GAPPS_VARIANT}"
    else
        name2="-$GAPPS_BRAND"
    fi
    if [ "$GAPPS_BRAND" = "OpenGApps" ] && [ "$DEBUG" != "1" ]; then
        echo ":warning: Since OpenGApps doesn't officially support Android 12.1 yet, lock the variant to pico!"
    fi
fi
artifact_name="WSA${name1}${name2}_${WSA_VER}_${ARCH}_${WSA_REL}"
echo "$artifact_name"
echo -e "\nFinishing building...."
if [ -f "$OUTPUT_DIR" ]; then
    sudo rm -rf "${OUTPUT_DIR:?}"
fi
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi
if [ "$COMPRESS_OUTPUT" = "yes" ]; then
    rm -f "${OUTPUT_DIR:?}"/"$artifact_name.7z" || abort
    7z a "$OUTPUT_DIR"/"$artifact_name.7z" "$WORK_DIR/wsa/$ARCH/" || abort
elif [ "$COMPRESS_OUTPUT" = "no" ]; then
    rm -rf "${OUTPUT_DIR:?}/${artifact_name}" || abort
    mv "$WORK_DIR"/wsa/"$ARCH" "$OUTPUT_DIR/$artifact_name" || abort
fi
echo -e "done\n"

echo "Cleanup Work Directory"
sudo rm -rf "${WORK_DIR:?}"
echo "done"
