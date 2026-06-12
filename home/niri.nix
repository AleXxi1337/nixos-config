{ config, ... }:
{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+T".action = spawn "kitty";
    "Mod+Q".action = close-window;
    "Mod+Shift+E".action = quit;
  };
}
