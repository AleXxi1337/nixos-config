{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-minimal-plymouth";
  dontUnpack = true;

  installPhase = ''
    dir=$out/share/plymouth/themes/nixos-minimal
    mkdir -p "$dir"

    cp ${pkgs.nixos-bgrt-plymouth}/share/plymouth/themes/nixos-bgrt/images/throbber-*.png \
       "$dir/"

    cat > "$dir/nixos-minimal.plymouth" << 'EOF'
[Plymouth Theme]
Name=NixOS Minimal
Description=NixOS boot splash, black background
ModuleName=two-step

[two-step]
ImageDir=%plymouth:theme-path%
Font=Cantarell 20
HorizontalAlignment=.5
VerticalAlignment=.5
Transition=none
TransitionDuration=0.0
BackgroundStartColor=0x000000
BackgroundEndColor=0x000000
MessageBelowAnimation=true

[boot-up]
UseEndAnimation=false
UseFirmwareBackground=false

[shutdown]
UseEndAnimation=false
UseFirmwareBackground=false

[reboot]
UseEndAnimation=false
UseFirmwareBackground=false
EOF
  '';
}
