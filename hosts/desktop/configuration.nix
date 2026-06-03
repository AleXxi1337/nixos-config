{ pkgs, lib, hostname, username, ... }:
{
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  boot.initrd.systemd.enable = true;

  boot.initrd.availableKernelModules = [
    "virtio_blk" "virtio_pci"
    "tpm_tis" "tpm_crb"
  ];

  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-partlabel/root";
  };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    sbctl
    tpm2-tools
  ];

  system.stateVersion = "25.05";
}
