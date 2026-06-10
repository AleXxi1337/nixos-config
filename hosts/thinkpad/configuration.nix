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
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    autoEnrollKeys = {
      enable = true;
      includeMicrosoftKeys = true;
    };
  };

  boot.initrd.systemd.enable = true;

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };
  boot.kernelParams = [
    "quiet" "splash"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "vt.global_cursor_default=0"
  ];
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.loader.timeout = 0;

  systemd.settings.Manager.ShowStatus = "no";

  boot.initrd.availableKernelModules = [
    "nvme" "xhci_pci" "usb_storage"
    "tpm_tis" "tpm_crb"
  ];

  # Early KMS for Plymouth (Intel iGPU)
  boot.initrd.kernelModules = [ "i915" ];

  users.users.root.hashedPassword = "$6$A1/5sUrpBBWII0Bb$7jeNdGgdzDDjbjnzHKT3F9MAeeNWOHV72eCF0n/JMDUkCaorJlWHm9xz03QvnuQtBpes5BBP36S.5WE/kpdeM/";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$A1/5sUrpBBWII0Bb$7jeNdGgdzDDjbjnzHKT3F9MAeeNWOHV72eCF0n/JMDUkCaorJlWHm9xz03QvnuQtBpes5BBP36S.5WE/kpdeM/";
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    sbctl
    tpm2-tools
  ];

  system.stateVersion = "25.11";
}
