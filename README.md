# NixOS Config

NixOS 25.11 with Secure Boot (lanzaboote), LUKS encryption, TPM2 auto-unlock, Btrfs.

## Hosts

| Name     | Disk          | User |
|----------|---------------|------|
| desktop  | /dev/nvme0n1  | user |
| thinkpad | /dev/nvme0n1  | user |
| vm       | /dev/vda      | user |

## Installation

### 1. Get the config

```bash
git clone https://github.com/AleXxi1337/nixos-config
cd nixos-config
```

### 2. Expand nix store tmpfs

```bash
sudo mount -o remount,size=8G /nix/.rw-store
```

### 3. Partition and format

```bash
sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode destroy,format,mount \
  --flake .#<host>
```

> **Warning:** this will wipe the disk completely.

### 4. Install NixOS

```bash
sudo nixos-install --flake .#<host>
```

## Post-install: TPM2 auto-unlock

```bash
sudo systemd-cryptenroll \
  --tpm2-device=auto \
  --tpm2-pcrs=0+7 \
  /dev/disk/by-partlabel/disk-main-root
```
