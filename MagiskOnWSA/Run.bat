:: This file is part of MagiskOnWSALocal.
::
:: MagiskOnWSALocal is free software: you can redistribute it and/or modify
:: it under the terms of the GNU Affero General Public License as
:: published by the Free Software Foundation, either version 3 of the
:: License, or (at your option) any later version.
::
:: MagiskOnWSALocal is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU Affero General Public License for more details.
::
:: You should have received a copy of the GNU Affero General Public License
:: along with MagiskOnWSALocal.  If not, see <https://www.gnu.org/licenses/>.
::
:: Copyright (C) 2023 LSPosed Contributors
::

:: ... (Keep all the licensing/header lines the same) ...

@echo off
%~d0
cd "%~dp0"

if not exist Install.ps1 (
    echo "Install.ps1" is not found.
    echo Press any key to exit
    pause>nul
    exit 1
) else (
    :: ========================================================
    :: HOTFIX: Apply a fix to WsaClient.exe before install
    :: ========================================================
    echo Checking for WsaClient crash compatibility patch...
    if exist "Tools\WSAfix.exe" (
        echo Applying WSAfix to WsaClient.exe...
        "Tools\WSAfix.exe" "WsaClient\WsaClient.exe"
    ) else (
        echo [INFO] WSAfix.exe not found in Tools directory, skipping.
    )
    :: ========================================================

    :: Now proceed to standard installation
    start powershell.exe -ExecutionPolicy Bypass -File .\Install.ps1
    exit
)
