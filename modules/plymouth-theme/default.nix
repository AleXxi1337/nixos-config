{ pkgs }:
let
  src = "${pkgs.nixos-bgrt-plymouth}/share/plymouth/themes/nixos-bgrt";
  snowflakeSvg = ./nix-snowflake-white.svg;
in
pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-custom-plymouth";
  dontUnpack = true;

  nativeBuildInputs = [
    pkgs.imagemagick
    pkgs.librsvg
  ];

  installPhase = ''
        dir=$out/share/plymouth/themes/nixos-bgrt
        mkdir -p "$dir/images"

        for f in bullet.png capslock.png entry.png keyboard.png keymap-render.png lock.png; do
          cp ${src}/images/$f "$dir/images/"
        done

        rsvg-convert -w 200 -h 200 ${snowflakeSvg} -o "$dir/images/throbber-0001.png"

        # 24 fade-to-black frames: startup-animation- prefix, bright → black
        for i in $(seq 1 24); do
          brightness=$(awk "BEGIN{printf \"%.0f\", 100 - ($i - 1) * 100 / 23}")
          convert "$dir/images/throbber-0001.png" \
            -modulate "$brightness,100,100" \
            "$dir/images/startup-animation-$(printf '%04d' $i).png"
        done

        cat > "$dir/nixos-bgrt.plymouth" << EOF
    [Plymouth Theme]
    Name=NixOS Custom
    Description=NixOS splash, black background with fade-to-black
    ModuleName=two-step

    [two-step]
    Font=Cantarell 20
    ImageDir=$dir/images
    DialogHorizontalAlignment=.5
    DialogVerticalAlignment=.5
    HorizontalAlignment=.5
    VerticalAlignment=.5
    Transition=none
    TransitionDuration=0.0
    BackgroundStartColor=0x000000
    BackgroundEndColor=0x000000
    ProgressBarBackgroundColor=0x606060
    ProgressBarForegroundColor=0xffffff
    MessageBelowAnimation=true

    [boot-up]
    UseEndAnimation=true
    UseFirmwareBackground=false

    [shutdown]
    UseEndAnimation=true
    UseFirmwareBackground=false

    [reboot]
    UseEndAnimation=true
    UseFirmwareBackground=false
    EOF
  '';
}
