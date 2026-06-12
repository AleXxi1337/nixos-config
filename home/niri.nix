{ ... }:
{
  xdg.configFile."niri/config.kdl".text = ''
    prefer-no-csd

    binds {
      Mod+T { spawn "kitty"; }
      Mod+Q { close-window; }
      Mod+Shift+E { quit; }

      Mod+Left  { focus-column-left; }
      Mod+Right { focus-column-right; }
      Mod+Down  { focus-window-down; }
      Mod+Up    { focus-window-up; }

      Mod+Shift+Left  { move-column-left; }
      Mod+Shift+Right { move-column-right; }
      Mod+Shift+Down  { move-window-down; }
      Mod+Shift+Up    { move-window-up; }

      Mod+Ctrl+Up   { focus-workspace-up; }
      Mod+Ctrl+Down { focus-workspace-down; }

      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }

      Mod+Shift+1 { move-window-to-workspace 1; }
      Mod+Shift+2 { move-window-to-workspace 2; }
      Mod+Shift+3 { move-window-to-workspace 3; }
      Mod+Shift+4 { move-window-to-workspace 4; }
      Mod+Shift+5 { move-window-to-workspace 5; }

      Mod+F { fullscreen-window; }
      Mod+M { maximize-column; }
    }
  '';
}
