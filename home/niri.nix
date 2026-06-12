{ config, ... }:
{
  programs.niri.settings = {
    prefer-no-csd = true;

    binds = with config.lib.niri.actions; {
      "Mod+T".action        = spawn "kitty";
      "Mod+Q".action        = close-window;
      "Mod+Shift+E".action  = quit;

      "Mod+Left".action       = focus-column-left;
      "Mod+Right".action      = focus-column-right;
      "Mod+Down".action       = focus-window-down;
      "Mod+Up".action         = focus-window-up;

      "Mod+Shift+Left".action  = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Down".action  = move-window-down;
      "Mod+Shift+Up".action    = move-window-up;

      "Mod+Ctrl+Up".action   = focus-workspace-up;
      "Mod+Ctrl+Down".action = focus-workspace-down;

"Mod+F".action = fullscreen-window;
      "Mod+M".action = maximize-column;
    };
  };
}
