{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-snowflake-plymouth";
  src = ./.;

  nativeBuildInputs = with pkgs; [ librsvg ];

  buildPhase = ''
    # Watermark (logo shown on black background)
    rsvg-convert -w 150 -h 150 nix-snowflake-white.svg -o watermark.png

    # 12 throbber frames, 30° apart
    for i in 0 1 2 3 4 5 6 7 8 9 10 11; do
      angle=$((i * 30))
      cat > frame.svg << EOF
<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48">
  <path d="M 24 3 A 21 21 0 1 1 45 24" fill="none" stroke="white"
        stroke-width="4" stroke-linecap="round" transform="rotate(${angle},24,24)"/>
</svg>
EOF
      rsvg-convert -w 48 -h 48 frame.svg -o throbber-$(printf '%04d' $i).png
    done
  '';

  installPhase = ''
    dir=$out/share/plymouth/themes/nixos-snowflake
    mkdir -p $dir

    cat > $dir/nixos-snowflake.plymouth << EOF
[Plymouth Theme]
Name=NixOS Snowflake
Description=NixOS themed boot splash with snowflake logo
ModuleName=two-step

[two-step]
Font=Sans 20
ImageDir=$dir
BackgroundStartColor=0x000000
BackgroundEndColor=0x000000
HorizontalAlignment=.5
VerticalAlignment=.8
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

    cp watermark.png  $dir/
    cp throbber-*.png $dir/
  '';
}
