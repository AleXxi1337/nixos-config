{ ... }:
{
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "tpm_tis"
    "tpm_crb"
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.happ.enable = true;
}
