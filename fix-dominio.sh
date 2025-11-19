#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

# Opções do dpkg para evitar qualquer pergunta
DPKG_OPTS=(
    "-o" "Dpkg::Options::=--force-confdef"
    "-o" "Dpkg::Options::=--force-confold"
)

echo "[1/3] Removendo libpam-mount..."
apt "${DPKG_OPTS[@]}" remove --purge -y libpam-mount

echo "[2/3] Instalando libpam-mount..."
apt "${DPKG_OPTS[@]}" install -y libpam-mount

echo "[3/3] Garantindo 'pam_mkhomedir' no common-session..."

LINHA="session required pam_mkhomedir.so skel=/etc/skel umask=0077"
ARQ="/etc/pam.d/common-session"

if ! grep -Fxq "$LINHA" "$ARQ"; then
    echo "$LINHA" >> "$ARQ"
    echo "Linha adicionada ao $ARQ"
else
    echo "Linha já existe no $ARQ"
fi

echo ""
echo "✔ Concluído!"