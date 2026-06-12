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

      Mod+Ctrl+Left  { focus-workspace-left; }
      Mod+Ctrl+Right { focus-workspace-right; }

      Mod+F { fullscreen-window; }
      Mod+M { maximize-column; }
    }
  '';
}
