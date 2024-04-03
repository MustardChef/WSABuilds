#!/bin/sh
MAGISKTMP=/sbin
[ -d /sbin ] || MAGISKTMP=/debug_ramdisk
MAGISKBIN=/data/adb/magisk
if [ ! -d /data/adb ]; then
    mkdir -m 700 /data/adb
    chcon u:object_r:adb_data_file:s0 /data/adb
fi
if [ ! -d $MAGISKBIN ]; then
    # shellcheck disable=SC2174
    mkdir -p -m 755 $MAGISKBIN
    chcon u:object_r:system_file:s0 $MAGISKBIN
fi
ABI=$(getprop ro.product.cpu.abi)
for file in busybox magiskpolicy magiskboot magiskinit; do
    [ -x "$MAGISKBIN/$file" ] || {
        unzip -d $MAGISKBIN -oj $MAGISKTMP/stub.apk "lib/$ABI/lib$file.so"
        mv $MAGISKBIN/lib$file.so $MAGISKBIN/$file
        chmod 755 "$MAGISKBIN/$file"
    }
done
for file in util_functions.sh boot_patch.sh; do
    [ -x "$MAGISKBIN/$file" ] || {
        unzip -d $MAGISKBIN -oj $MAGISKTMP/stub.apk "assets/$file"
        chmod 755 "$MAGISKBIN/$file"
    }
done
for file in "$MAGISKTMP"/*; do
    if echo "$file" | grep -Eq "lsp_.+\.img"; then
        foldername=$(basename "$file" .img)
        mkdir -p "$MAGISKTMP/$foldername"
        mount -t auto -o ro,loop "$file" "$MAGISKTMP/$foldername"
        "$MAGISKTMP/$foldername/post-fs-data.sh" &
    fi
done
wait
for file in "$MAGISKTMP"/*; do
    if echo "$file" | grep -Eq "lsp_.+\.img"; then
        foldername=$(basename "$file" .img)
        umount "$MAGISKTMP/$foldername"
        rm -rf "${MAGISKTMP:?}/${foldername:?}"
        rm -f "$file"
    fi
done
