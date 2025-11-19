#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive

# PARAMETROS DO DPKG CORRETOS
DPKG_OPTS=(
    "-oDpkg::Options::=--force-confdef"
    "-oDpkg::Options::=--force-confold"
)

echo "[1/3] Removendo libpam-mount..."
apt "${DPKG_OPTS[@]}" remove --purge -y libpam-mount

echo "[2/3] Reinstalando libpam-mount..."
apt "${DPKG_OPTS[@]}" install -y libpam-mount

echo "[3/3] Garantindo pam_mkhomedir..."
FILE="/etc/pam.d/common-session"
LINE="session required pam_mkhomedir.so skel=/etc/skel umask=0077"

grep -qxF "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

echo "Concluído!"
