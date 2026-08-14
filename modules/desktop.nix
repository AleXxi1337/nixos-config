{ pkgs, username, ... }:
{
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
}
