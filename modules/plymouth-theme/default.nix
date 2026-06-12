{ pkgs }:
let
  src = "${pkgs.nixos-bgrt-plymouth}/share/plymouth/themes/nixos-bgrt";
  nFrames = 60;
in pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-custom-plymouth";
  dontUnpack = true;

  nativeBuildInputs = [ pkgs.imagemagick ];

  installPhase = ''
    dir=$out/share/plymouth/themes/nixos-bgrt
    mkdir -p "$dir/images"

    for i in $(seq 1 ${toString nFrames}); do
      angle=$(( (i - 1) * 360 / ${toString nFrames} ))
      convert ${src}/images/throbber-0001.png \
        -distort SRT "$angle" \
        "$dir/images/throbber-$(printf '%04d' $i).png"
    done

    cp ${src}/nixos-bgrt.plymouth "$dir/"
    sed -i \
      -e 's/UseFirmwareBackground=true/UseFirmwareBackground=false/g' \
      -e 's/VerticalAlignment=.*/VerticalAlignment=.5/g' \
      -e 's|ImageDir=.*|ImageDir=%plymouth:theme-path%/images|g' \
      "$dir/nixos-bgrt.plymouth"
  '';
}
