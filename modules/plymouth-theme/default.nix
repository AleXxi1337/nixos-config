{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-minimal-plymouth";
  dontUnpack = true;

  installPhase = ''
    dir=$out/share/plymouth/themes/nixos-minimal
    mkdir -p "$dir"

    cp ${pkgs.nixos-bgrt-plymouth}/share/plymouth/themes/nixos-bgrt/images/throbber-0001.png \
       "$dir/snowflake.png"

    cat > "$dir/nixos-minimal.plymouth" << 'EOF'
[Plymouth Theme]
Name=NixOS Minimal
Description=NixOS boot splash, black background with fade
ModuleName=script

[script]
ImageDir=%plymouth:theme-path%
ScriptFile=%plymouth:theme-path%/nixos-minimal.script
EOF

    cat > "$dir/nixos-minimal.script" << 'EOF'
Window.SetBackgroundTopColor(0, 0, 0);
Window.SetBackgroundBottomColor(0, 0, 0);

sw = Window.GetWidth();
sh = Window.GetHeight();

img = Image("snowflake.png");
s   = Sprite(img);
s.SetX(sw / 2 - img.GetWidth()  / 2);
s.SetY(sh / 2 - img.GetHeight() / 2);
s.SetZ(10);

t        = 0;
quitting = 0;
opacity  = 1.0;

fun quit_callback() {
    quitting = 1;
}

fun refresh_callback() {
    t = t + 1;

    if (quitting == 1) {
        opacity = opacity - 0.04;
        if (opacity < 0) opacity = 0;
        s.SetOpacity(opacity);
    } else {
        s.SetOpacity(0.6 + Math.Sin(t * 0.08) * 0.4);
    }
}

Plymouth.SetQuitTransition(quit_callback, 1000);
Plymouth.SetRefreshFunction(refresh_callback);
EOF
  '';
}
