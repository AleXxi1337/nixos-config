{ pkgs, lib, ... }:
{
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    autoEnrollKeys = {
      enable = true;
      includeMicrosoftKeys = true;
    };
  };

  boot.initrd.availableKernelModules = [
    "nvme" "xhci_pci" "usb_storage"
    "tpm_tis" "tpm_crb"
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.happ.enable = true;

  environment.systemPackages = with pkgs; [
    sbctl tpm2-tools
  ];
}
