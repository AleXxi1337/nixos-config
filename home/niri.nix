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

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;

      "Mod+Shift+1".action = move-window-to-workspace 1;
      "Mod+Shift+2".action = move-window-to-workspace 2;
      "Mod+Shift+3".action = move-window-to-workspace 3;
      "Mod+Shift+4".action = move-window-to-workspace 4;
      "Mod+Shift+5".action = move-window-to-workspace 5;

      "Mod+F".action = fullscreen-window;
      "Mod+M".action = maximize-column;
    };
  };
}
