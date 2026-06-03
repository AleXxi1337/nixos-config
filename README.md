# NixOS Config

NixOS 25.11 with Secure Boot (lanzaboote), LUKS encryption, TPM2 auto-unlock, Btrfs.

## Hosts

| Name    | Disk      | User |
|---------|-----------|------|
| desktop | /dev/vda  | user |

## Requirements

- UEFI firmware (not Legacy BIOS)
- TPM 2.0 chip
- Secure Boot in **Setup Mode** (clear existing keys in BIOS before install)

For VM: OVMF with Secure Boot + emulated TPM 2.0 (virt-manager: Add Hardware → TPM → Emulated, 2.0).

## Installation

### 1. Boot NixOS ISO

Download from [nixos.org/download](https://nixos.org/download). Boot in UEFI mode:

```bash
ls /sys/firmware/efi  # must exist
```

### 2. Get the config

```bash
nix-shell -p git
git clone https://github.com/YOUR_USERNAME/nixos-config
cd nixos-config
```

### 3. Check disk name

```bash
lsblk
```

If your disk is not `/dev/vda`, edit [hosts/desktop/disk-config.nix](hosts/desktop/disk-config.nix) and change the `device` field.

### 4. Partition, format and install

One command handles everything — disko partitions the disk, formats LUKS+Btrfs, and runs nixos-install:

```bash
sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko#disko-install -- \
  --flake .#desktop \
  --disk main /dev/vda
```

You will be prompted to set a **LUKS passphrase** — save it, it's needed until TPM2 is enrolled.

> **Warning:** this will wipe the disk completely.

### 5. Set user password

```bash
sudo nixos-enter --root /mnt
passwd user
exit
```

### 6. Reboot

Remove the ISO and reboot. Enter the LUKS passphrase when prompted.

On first boot, lanzaboote will automatically:
- Generate Secure Boot keys into `/var/lib/sbctl`
- Enroll keys into firmware (requires Setup Mode)
- Sign the bootloader and kernel

## Post-install: TPM2 auto-unlock

After the first successful boot, bind LUKS to TPM2 so the disk unlocks automatically on trusted boots:

```bash
sudo systemd-cryptenroll \
  --tpm2-device=auto \
  --tpm2-pcrs=0+7 \
  /dev/disk/by-partlabel/disk-main-root
```

PCR 0+7 means: unlock only if firmware (PCR0) and Secure Boot state (PCR7) have not changed.

Reboot to verify — no passphrase should be required.

## Verify Secure Boot

```bash
sudo sbctl status
# Secure Boot: enabled ✓
```

## Disk layout

```
/dev/vda
├── EFI System Partition  1024M  /boot  (vfat)
└── root                  100%
    └── LUKS (cryptroot)
        └── Btrfs
            ├── @      → /
            ├── @home  → /home
            └── @nix   → /nix
```
