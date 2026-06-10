{ pkgs }:
pkgs.runCommand "nixos-snowflake-plymouth"
{ nativeBuildInputs = [ pkgs.librsvg ]; }
''
  dir=$out/share/plymouth/themes/nixos-snowflake
  mkdir -p $dir

  # Reuse throbbers from nixos-bgrt-plymouth (spinning NixOS snowflake)
  cp ${pkgs.nixos-bgrt-plymouth}/share/plymouth/themes/nixos-bgrt/images/throbber-*.png $dir/

  # Generate .plymouth without firmware background
  cat > $dir/nixos-snowflake.plymouth << EOF
[Plymouth Theme]
Name=NixOS Snowflake
Description=NixOS spinning snowflake on black background
ModuleName=two-step

[two-step]
Font=Cantarell 20
ImageDir=$dir
BackgroundStartColor=0x000000
BackgroundEndColor=0x000000
HorizontalAlignment=.5
VerticalAlignment=.5
DialogHorizontalAlignment=.5
DialogVerticalAlignment=.8
Transition=none
TransitionDuration=0.0
MessageBelowAnimation=false

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
''
