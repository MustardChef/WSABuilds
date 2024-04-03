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
cd "$(dirname "$0")" || exit 1

./install_deps.sh || exit 1

WHIPTAIL=$(command -v whiptail 2>/dev/null)
DIALOG=$(command -v dialog 2>/dev/null)
DIALOG=${WHIPTAIL:-$DIALOG}
function Radiolist {
    declare -A o="$1"
    shift
    if ! $DIALOG --nocancel --radiolist "${o[title]}" 0 0 0 "$@" 3>&1 1>&2 2>&3; then
        echo "${o[default]}"
    fi
}

function YesNoBox {
    declare -A o="$1"
    local default
    [ "$2" ] && {
        [ "$2" = "no" ] && default="--defaultno"
    }
    shift
    $DIALOG --title "${o[title]}" $default --yesno "${o[text]}" 0 0
}

function DialogBox {
    declare -A o="$1"
    shift
    $DIALOG --title "${o[title]}" --msgbox "${o[text]}" 0 0
}
intro="Welcome to MagiskOnWSA!

    With this utility, you can integrate Magisk for WSA easily.
    Use arrow keys to navigate, and press space to select.
    Press enter to confirm.
"
DialogBox "([title]='Intro to MagiskOnWSA' \
            [text]='$intro')"

ARCH=$(
    Radiolist '([title]="Build arch"
                [default]="x64")' \
        'x64' "X86_64" 'on' \
        'arm64' "AArch64" 'off'
)

RELEASE_TYPE=$(
    Radiolist '([title]="WSA release type"
                [default]="retail")' \
        'retail' "Stable Channel" 'on' \
        'release preview' "Release Preview Channel" 'off' \
        'insider slow' "Beta Channel" 'off' \
        'insider fast' "Dev Channel" 'off'
)
declare -A RELEASE_TYPE_MAP=(["retail"]="retail" ["release preview"]="RP" ["insider slow"]="WIS" ["insider fast"]="WIF")
COMMAND_LINE=(--arch "$ARCH" --release-type "${RELEASE_TYPE_MAP[$RELEASE_TYPE]}")
if (YesNoBox '([title]="Root" [text]="Do you want to Root WSA?")'); then
    ROOT_SOL=$(
        Radiolist '([title]="Root solution"
                    [default]="magisk")' \
            'magisk' "Magisk" 'on' \
            'kernelsu' "KernelSU" 'off'
    )
    COMMAND_LINE+=(--root-sol "$ROOT_SOL")
fi

if [ "$ROOT_SOL" = "magisk" ]; then
    MAGISK_VER=$(
        Radiolist '([title]="Magisk version"
                    [default]="stable")' \
            'stable' "Stable Channel" 'on' \
            'beta' "Beta Channel" 'off' \
            'canary' "Canary Channel" 'off' \
            'debug' "Canary Channel Debug Build" 'off'
    )
    COMMAND_LINE+=(--magisk-ver "$MAGISK_VER")
    if (YesNoBox '([title]="Install GApps" [text]="Do you want to install GApps?")'); then
        COMMAND_LINE+=(--install-gapps)
    fi
fi

if (YesNoBox '([title]="Remove Amazon Appstore" [text]="Do you want to remove Amazon Appstore?")' no); then
    COMMAND_LINE+=(--remove-amazon)
fi

if (YesNoBox '([title]="Compress output" [text]="Do you want to compress the output?")'); then
    COMPRESS_FORMAT=$(
        Radiolist '([title]="Compress format"
                    [default]="7z")' \
            '7z' "7-Zip" 'on' \
            'zip' "Zip" 'off'
    )
    COMMAND_LINE+=(--compress-format "$COMPRESS_FORMAT")
fi

clear
echo "COMMAND_LINE=${COMMAND_LINE[*]}"
chmod +x ./build.sh
./build.sh "${COMMAND_LINE[@]}"
