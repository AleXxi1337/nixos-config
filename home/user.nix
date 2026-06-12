{ username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  imports = [ ./niri.nix ];

  programs.kitty.enable = true;
}
