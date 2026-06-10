{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  name = "nixos-snowflake-plymouth";
  dontUnpack = true;

  installPhase = ''
    dir=$out/share/plymouth/themes/nixos-snowflake
    mkdir -p $dir

    cp ${pkgs.nixos-bgrt-plymouth}/share/plymouth/themes/nixos-bgrt/images/throbber-*.png $dir/

    cat > $dir/nixos-snowflake.plymouth << 'EOF'
[Plymouth Theme]
Name=NixOS Snowflake
Description=NixOS spinning snowflake on black background
ModuleName=script

[script]
ImageDir=%plymouth:theme-path%
ScriptFile=%plymouth:theme-path%/nixos-snowflake.script
EOF

    cat > $dir/nixos-snowflake.script << 'EOF'
Window.SetBackgroundTopColor(0, 0, 0);
Window.SetBackgroundBottomColor(0, 0, 0);

screen_width  = Window.GetWidth();
screen_height = Window.GetHeight();

t[0]  = Image("throbber-0001.png"); t[1]  = Image("throbber-0002.png");
t[2]  = Image("throbber-0003.png"); t[3]  = Image("throbber-0004.png");
t[4]  = Image("throbber-0005.png"); t[5]  = Image("throbber-0006.png");
t[6]  = Image("throbber-0007.png"); t[7]  = Image("throbber-0008.png");
t[8]  = Image("throbber-0009.png"); t[9]  = Image("throbber-0010.png");
t[10] = Image("throbber-0011.png"); t[11] = Image("throbber-0012.png");
t[12] = Image("throbber-0013.png"); t[13] = Image("throbber-0014.png");
t[14] = Image("throbber-0015.png"); t[15] = Image("throbber-0016.png");
t[16] = Image("throbber-0017.png"); t[17] = Image("throbber-0018.png");
t[18] = Image("throbber-0019.png"); t[19] = Image("throbber-0020.png");
t[20] = Image("throbber-0021.png"); t[21] = Image("throbber-0022.png");
t[22] = Image("throbber-0023.png"); t[23] = Image("throbber-0024.png");
t[24] = Image("throbber-0025.png"); t[25] = Image("throbber-0026.png");
t[26] = Image("throbber-0027.png"); t[27] = Image("throbber-0028.png");
t[28] = Image("throbber-0029.png"); t[29] = Image("throbber-0030.png");

i = 0;
s = Sprite(t[0]);
s.SetX(screen_width  / 2 - t[0].GetWidth()  / 2);
s.SetY(screen_height / 2 - t[0].GetHeight() / 2);
s.SetZ(10);

fun refresh_callback() {
    i = i + 1;
    if (i >= 30)
        i = 0;
    s.SetImage(t[i]);
}

Plymouth.SetRefreshFunction(refresh_callback);
EOF
  '';
}
