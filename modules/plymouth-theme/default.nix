{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-snowflake-plymouth";
  src = ./.;

  nativeBuildInputs = with pkgs; [ librsvg imagemagick ];

  buildPhase = ''
    # Snowflake: render SVG to PNG, then make white (preserve alpha)
    rsvg-convert -w 150 -h 150 \
      ${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg \
      -o logo_color.png

    convert -size 150x150 xc:white \
      \( logo_color.png -alpha extract \) \
      -compose CopyOpacity -composite logo.png

    # Spinner: 270° arc with rounded caps
    cat > spinner.svg << 'SVGEOF'
<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48">
  <path d="M 24 3 A 21 21 0 1 1 45 24"
        fill="none" stroke="white" stroke-width="4"
        stroke-linecap="round"/>
</svg>
SVGEOF
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
