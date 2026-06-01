# NixOS Config

## Installation

### 1. Boot NixOS ISO

Download from [nixos.org/download](https://nixos.org/download). For VM: enable UEFI (OVMF).

### 2. Get the config

```bash
nix-shell -p git
git clone https://github.com/YOUR_USERNAME/nixos-config
cd nixos-config
```

### 3. Partition and format the disk

```bash
sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko/latest -- \
  --mode destroy,format,mount ./hosts/desktop/disk-config.nix
```

> **Warning:** this will wipe the disk completely.

### 4. Install

```bash
sudo nixos-install --flake .#desktop
```

### 5. Set user password

```bash
sudo nixos-enter --root /mnt
passwd user
exit
```

### 6. Reboot

```bash
reboot
```

## Hosts

| Name    | Disk   | User |
|---------|--------|------|
| desktop | /dev/vda | user |
