{ ... }:
{
  boot.loader.systemd-boot.enable = true;

  boot.initrd.availableKernelModules = [
    "virtio_blk" "virtio_pci" "virtio_gpu"
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "yes";
  };

  users.users.root.initialPassword = "root";
}
