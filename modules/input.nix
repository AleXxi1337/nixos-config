{ ... }:
{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "leftshift";
        leftshift = "capslock";
      };
    };
  };
}
