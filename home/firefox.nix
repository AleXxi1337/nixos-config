{ ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      userChrome = ''
        * { font-family: "Roboto" !important; }
      '';
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "font.default.x-western"         = "sans-serif";
        "font.name.sans-serif.x-western" = "Roboto";
        "font.name.serif.x-western"      = "Noto Serif";
        "font.name.monospace.x-western"  = "JetBrainsMono Nerd Font";
        "font.size.variable.x-western"   = 16;
        "font.size.monospace.x-western"  = 14;
      };
    };
  };
}
