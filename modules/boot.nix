{ pkgs, ... }:
{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  boot.initrd.systemd.enable = true;

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ (pkgs.callPackage ./plymouth-theme { }) ];
  };
  boot.kernelParams = [
    "quiet"
    "splash"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.blacklistedKernelModules = [ "serial8250" ];
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  systemd.settings.Manager.ShowStatus = "no";
}
