{ pkgs }:
let src = "${pkgs.nixos-bgrt-plymouth}/share/plymouth/themes/nixos-bgrt";
in pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-custom-plymouth";
  dontUnpack = true;

  installPhase = ''
    dir=$out/share/plymouth/themes/nixos-bgrt
    mkdir -p "$dir"

    cp -r ${src}/. "$dir/"

    sed -i 's/UseFirmwareBackground=true/UseFirmwareBackground=false/g' \
      "$dir/nixos-bgrt.plymouth"
  '';
}
