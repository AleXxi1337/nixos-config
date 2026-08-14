{ pkgs, lib, ... }:
{
  home.activation.copyOnlyOfficeFonts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.local/share/fonts/corefonts
    cp -f --remove-destination ${pkgs.corefonts}/share/fonts/truetype/*.ttf $HOME/.local/share/fonts/corefonts/
    chmod 644 $HOME/.local/share/fonts/corefonts/*.ttf
  '';
}
