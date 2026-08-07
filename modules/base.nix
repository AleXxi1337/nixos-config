{ pkgs, hostname, username, ... }:
{
  nixpkgs.config.allowUnfree = true;

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
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.blacklistedKernelModules = [ "serial8250" ];
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  systemd.settings.Manager.ShowStatus = "no";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "lp" ];
    hashedPassword = "$6$A1/5sUrpBBWII0Bb$7jeNdGgdzDDjbjnzHKT3F9MAeeNWOHV72eCF0n/JMDUkCaorJlWHm9xz03QvnuQtBpes5BBP36S.5WE/kpdeM/";
    shell = pkgs.zsh;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock  = "leftshift";
        leftshift = "capslock";
      };
    };
  };

  fonts.packages = with pkgs; [
    corefonts
  ];

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Roboto" ];
    serif     = [ "Noto Serif" ];
    monospace = [ "JetBrainsMono Nerd Font" ];
    emoji     = [ "Noto Color Emoji" ];
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  programs.hyprland.enable = true;
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.writeShellScript "hyprland-session" ''
        exec start-hyprland > /dev/null 2>&1
      ''}";
      user = username;
    };
  };

  environment.systemPackages = with pkgs; [
    git vim wget curl jq gcc nodejs python3 unzip
  ];

  system.stateVersion = "25.11";
}
