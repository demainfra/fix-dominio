# Documentação — Script de Reinstalação Automática do `libpam-mount`

## Nome
`fix_pam_mount_auto.sh`

## Descrição
Este script executa automaticamente o processo de remoção, reinstalação e correção de configuração do pacote `libpam-mount` em sistemas Linux baseados em Debian/Ubuntu (incluindo Pop!_OS).

Ele elimina completamente prompts interativos durante a execução do `apt` utilizando parâmetros específicos do `dpkg`, garantindo execução não-interativa e segura para automação, troubleshooting ou padronização de ambientes.

Também garante a presença da diretiva `pam_mkhomedir` no arquivo `/etc/pam.d/common-session`, necessária para criação automática de diretórios home de usuários autenticados via PAM.

---

## Objetivo
O script foi criado para:

- Resolver problemas relacionados ao `pam_mount` ou `pam_winbind` após atualizações;
- Forçar reinstalação limpa do `libpam-mount`;
- Eliminar prompts gráficos durante operações do `apt`;
- Automatizar correções para ambientes corporativos;
- Garantir criação automática do diretório home com `pam_mkhomedir`.

---

## O que o script faz

### 1. Define o modo não-interativo para o APT
```
export DEBIAN_FRONTEND=noninteractive
```

### 2. Configura opções do `dpkg`
```
-o Dpkg::Options::=--force-confdef
-o Dpkg::Options::=--force-confold
```

### 3. Remove o pacote `libpam-mount`
```
apt ${DPKG_OPTS[@]} remove --purge -y libpam-mount
```

### 4. Reinstala o pacote
```
apt ${DPKG_OPTS[@]} install -y libpam-mount
```

### 5. Garante a diretiva `pam_mkhomedir`
```
session required pam_mkhomedir.so skel=/etc/skel umask=0077
```

---

## Instalação / Uso
```
chmod +x fix_pam_mount_auto.sh
sudo ./fix_pam_mount_auto.sh
```

---

## Requisitos
- Debian/Ubuntu/Pop!_OS
- Acesso root/sudo
- Terminal

---

## Avisos
- Afeta todos os usuários PAM.
- Pode exigir reboot.
- dpkg operará sem prompts.

---

## Licença
Uso livre.