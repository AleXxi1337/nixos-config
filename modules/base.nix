{ pkgs, hostname, username, ... }:
{
  hardware.enableRedistributableFirmware = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  boot.initrd.systemd.enable = true;

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ (pkgs.callPackage ./plymouth-theme {}) ];
  };
  boot.kernelParams = [
    "quiet" "splash"
    "systemd.show_status=false"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  systemd.settings.Manager.ShowStatus = "no";
  services.journald.extraConfig = "ForwardToConsole=no";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$A1/5sUrpBBWII0Bb$7jeNdGgdzDDjbjnzHKT3F9MAeeNWOHV72eCF0n/JMDUkCaorJlWHm9xz03QvnuQtBpes5BBP36S.5WE/kpdeM/";
  };

  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.niri}/bin/niri-session";
      user = username;
    };
  };

  environment.systemPackages = with pkgs; [
    git vim wget curl
  ];

  system.stateVersion = "25.11";
}
