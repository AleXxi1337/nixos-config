{
  pkgs,
  hostname,
  username,
  ...
}:
{
  imports = [
    ./boot.nix
    ./desktop.nix
    ./audio.nix
    ./bluetooth.nix
    ./input.nix
    ./printing.nix
    ./virtualization.nix
  ];

  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "lp"
    ];
    hashedPassword = "$6$A1/5sUrpBBWII0Bb$7jeNdGgdzDDjbjnzHKT3F9MAeeNWOHV72eCF0n/JMDUkCaorJlWHm9xz03QvnuQtBpes5BBP36S.5WE/kpdeM/";
    shell = pkgs.zsh;
  };

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Roboto" ];
    serif = [ "Noto Serif" ];
    monospace = [ "JetBrainsMono Nerd Font" ];
    emoji = [ "Noto Color Emoji" ];
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    jq
    gcc
    nodejs
    python3
    unzip
    distrobox
    fd
  ];

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  system.stateVersion = "26.05";
}
