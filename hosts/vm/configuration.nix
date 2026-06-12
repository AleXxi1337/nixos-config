{ ... }:
{
  boot.loader.systemd-boot.enable = true;

  boot.initrd.availableKernelModules = [
    "virtio_blk" "virtio_pci"
  ];
}
