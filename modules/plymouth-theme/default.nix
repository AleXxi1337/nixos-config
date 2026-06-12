{ pkgs }:
let src = "${pkgs.nixos-bgrt-plymouth}/share/plymouth/themes/nixos-bgrt";
in pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-custom-plymouth";
  dontUnpack = true;

  installPhase = ''
    dir=$out/share/plymouth/themes/nixos-bgrt
    mkdir -p "$dir/images"

    cp ${src}/images/*.png "$dir/images/"

    cp ${src}/nixos-bgrt.plymouth "$dir/"
    sed -i \
      -e 's/UseFirmwareBackground=true/UseFirmwareBackground=false/g' \
      -e "s|ImageDir=.*|ImageDir=$dir/images|g" \
      -e 's/VerticalAlignment=.8/VerticalAlignment=.5/g' \
      -e 's/DialogVerticalAlignment=.8/DialogVerticalAlignment=.5/g' \
      "$dir/nixos-bgrt.plymouth"
  '';
}
