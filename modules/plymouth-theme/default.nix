{ pkgs }:
let src = "${pkgs.nixos-bgrt-plymouth}/share/plymouth/themes/nixos-bgrt";
in pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-custom-plymouth";
  dontUnpack = true;

  nativeBuildInputs = [ pkgs.imagemagick ];

  installPhase = ''
    dir=$out/share/plymouth/themes/nixos-bgrt
    mkdir -p "$dir/images"

    for f in bullet.png capslock.png entry.png keyboard.png keymap-render.png lock.png; do
      cp ${src}/images/$f "$dir/images/"
    done

    # 120 rotation frames (3° per frame)
    for i in $(seq 1 120); do
      angle=$(( (i - 1) * 3 ))
      convert ${src}/images/throbber-0001.png \
        -distort SRT "$angle" \
        "$dir/images/throbber-$(printf '%04d' $i).png"
    done

    # 30 fade-to-black end animation frames
    for i in $(seq 1 30); do
      alpha=$(awk "BEGIN{printf \"%.4f\", ($i - 1) / 30.0 * -1 + 1}")
      convert ${src}/images/throbber-0001.png \
        -channel alpha -evaluate multiply "$alpha" +channel \
        "$dir/images/end-animation-$(printf '%04d' $i).png"
    done

    cp ${src}/nixos-bgrt.plymouth "$dir/"
    sed -i \
      -e 's/UseFirmwareBackground=true/UseFirmwareBackground=false/g' \
      -e "s|ImageDir=.*|ImageDir=$dir/images|g" \
      -e 's/VerticalAlignment=.8/VerticalAlignment=.5/g' \
      -e 's/DialogVerticalAlignment=.8/DialogVerticalAlignment=.5/g' \
      -e 's/UseEndAnimation=false/UseEndAnimation=true/g' \
      "$dir/nixos-bgrt.plymouth"
  '';
}
