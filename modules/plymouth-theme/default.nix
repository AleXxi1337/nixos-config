{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-snowflake-plymouth";
  src = ./.;

  nativeBuildInputs = with pkgs; [ librsvg imagemagick ];

  buildPhase = ''
    # Convert bundled SVG to PNG
    rsvg-convert -w 150 -h 150 nix-snowflake-white.svg -o logo.png

    # Spinner: 270° arc with rounded caps
    printf '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48"><path d="M 24 3 A 21 21 0 1 1 45 24" fill="none" stroke="white" stroke-width="4" stroke-linecap="round"/></svg>' > spinner.svg
    rsvg-convert -w 48 -h 48 spinner.svg -o spinner.png
  '';

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/nixos-snowflake
    cp nixos-snowflake.plymouth $out/share/plymouth/themes/nixos-snowflake/
    cp nixos-snowflake.script   $out/share/plymouth/themes/nixos-snowflake/
    cp logo.png                 $out/share/plymouth/themes/nixos-snowflake/
    cp spinner.png              $out/share/plymouth/themes/nixos-snowflake/
  '';
}
